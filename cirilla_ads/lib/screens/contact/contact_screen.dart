import 'dart:async';

import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/setting/setting.dart';
import 'package:cirilla/screens/contact/widgets/with_out_map.dart';
import 'package:cirilla/store/setting/setting_store.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'widgets/horizontal.dart';
import 'widgets/vertical.dart';
import 'widgets/modal_get_in_touch.dart';

class ContactScreen extends StatefulWidget {
  static const String routeName = '/contact';

  /// data Contact
  final Data? data;

  final SettingStore? store;

  const ContactScreen({
    Key? key,
    this.store,
    this.data,
  }) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> with Utility {
  late SettingStore _settingStore;
  final Completer<GoogleMapController> _controller = Completer();
  Map<String, Marker> markers = {};

  @override
  void didChangeDependencies() {
    _settingStore = Provider.of<SettingStore>(context);
    super.didChangeDependencies();
  }

  Future _gotoMarker(double lat, double lng, double bearing, double tilt, double zoom) async {
    final GoogleMapController controllerMarker = await _controller.future;
    controllerMarker.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      bearing: bearing,
      target: LatLng(lat, lng),
      tilt: tilt,
      zoom: zoom,
    )));
  }

  void showModal(BuildContext context, String? formId) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: borderRadiusBottomSheet,
      ),
      builder: (
        BuildContext context,
      ) {
        return ModalGetInTouch(formId: formId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        Data data = widget.store!.data!.screens!['contact']!;
        WidgetConfig widgetConfig = data.widgets!['contactPage']!;

        String layout = widgetConfig.layout ?? Strings.contactHorizontal;
        // general config
        bool enablePinMap = get(widgetConfig.fields, ['enablePinMap'], true);
        bool? enableFeedback = get(widgetConfig.fields, ['enableFeedback'], true);
        bool? enableDirectMap = get(widgetConfig.fields, ['enableDirectMap'], true);
        String? formId = get(widgetConfig.fields, ['formId'], '');
        String? image = ConvertData.imageFromConfigs(get(widgetConfig.fields, ['image'], ''), _settingStore.locale);
        List itemsCustomize = get(widgetConfig.fields, ['itemsCustomize'], []);
        String? mapTypeData = get(widgetConfig.fields, ['mapType'], "normal");

        // init visit
        double lat = itemsCustomize.isNotEmpty
            ? ConvertData.stringToDouble(get(itemsCustomize.elementAt(0), ['data', 'lat'], initLat))
            : initLat;
        double lng = itemsCustomize.isNotEmpty
            ? ConvertData.stringToDouble(get(itemsCustomize.elementAt(0), ['data', 'lng'], initLng))
            : initLng;

        Map<String, dynamic> mapTypes = {
          'none': MapType.none,
          'normal': MapType.normal,
          'satellite': MapType.satellite,
          'terrain': MapType.terrain,
          'hybrid': MapType.hybrid,
        };

        Widget mapView = GoogleMap(
          mapType: mapTypes[mapTypeData!] ?? mapTypes['normal'],
          initialCameraPosition: const CameraPosition(
            target: LatLng(initLat, initLng),
            zoom: initZoom,
          ),
          myLocationButtonEnabled: false,
          markers: markers.values.toSet(),
          onMapCreated: enablePinMap
              ? (GoogleMapController controller) => _onMapCreated(
                    controller,
                    items: itemsCustomize,
                    initMarker: LatLng(lat, lng),
                  )
              : null,
        );

        Widget? buttonLocation = enableFeedback == true
            ? FloatingActionButton(
                child: const Icon(FeatherIcons.mail),
                onPressed: () => showModal(context, formId),
              )
            : null;
        switch (layout) {
          case Strings.contactVertical:
            return VerticalContact(
              items: itemsCustomize,
              mapView: mapView,
              gotoMarker: _gotoMarker,
              enableDirectMap: enableDirectMap,
              buttonLocation: buttonLocation,
              languageKey: _settingStore.languageKey,
            );
          case Strings.contactDefault:
            return WithOutMap(
              items: itemsCustomize,
              enableDirectMap: enableDirectMap,
              buttonLocation: buttonLocation,
              languageKey: _settingStore.languageKey,
              image: image,
            );
          default:
            return HorizontalContact(
              items: itemsCustomize,
              mapView: mapView,
              gotoMarker: _gotoMarker,
              enableDirectMap: enableDirectMap,
              buttonLocation: buttonLocation,
              languageKey: _settingStore.languageKey,
            );
        }
      },
    );
  }

  void _onMapCreated(GoogleMapController controller, {List? items, LatLng? initMarker}) async {
    String? langKey = _settingStore.languageKey;
    _controller.complete(controller);

    setState(() {
      markers.clear();
      if (items!.isNotEmpty) {
        List.generate(items.length, (index) {
          Map? itemsData = get(items.elementAt(index), ['data'], {});
          String? titleData = get(itemsData, ['titleAddress', langKey], '');
          double lat = ConvertData.stringToDouble(get(itemsData, ['lat'], initLat), initLat);
          double lng = ConvertData.stringToDouble(get(itemsData, ['lng'], initLng), initLng);

          return markers[index.toString()] = Marker(
            markerId: MarkerId(index.toString()),
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(
              title: titleData,
            ),
          );
        });
      } else {
        markers['0'] = Marker(
          markerId: const MarkerId(''),
          position: initMarker!,
          infoWindow: const InfoWindow(
            title: '',
          ),
        );
      }
    });
  }
}
