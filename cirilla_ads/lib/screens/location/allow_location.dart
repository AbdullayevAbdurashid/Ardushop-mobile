import 'dart:async';
import 'package:flutter/material.dart';

import 'package:awesome_icons/awesome_icons.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'package:ui/notification/notification_screen.dart';

import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/models/location/place.dart';
import 'package:cirilla/models/location/user_location.dart';
import 'package:cirilla/screens/location/search_location.dart';
import 'package:cirilla/screens/location/widgets/looking_location.dart';
import 'package:cirilla/service/helpers/google_place_helper.dart';
import 'package:cirilla/store/auth/auth_store.dart';
import 'package:cirilla/store/auth/location_store.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/store/setting/setting_store.dart';

class AllowLocationScreen extends StatefulWidget {
  static const routeName = '/location/allow_location';
  final SettingStore? store;

  const AllowLocationScreen({
    Key? key,
    this.store,
  }) : super(key: key);

  @override
  State<AllowLocationScreen> createState() => _AllowLocationScreenState();
}

class _AllowLocationScreenState extends State<AllowLocationScreen> with AppBarMixin {
  final GeolocatorPlatform _geoLocatorPlatform = GeolocatorPlatform.instance;

  StreamSubscription<ServiceStatus>? _serviceStatusStreamSubscription;

  late LocationStore _locationStore;
  late SettingStore _settingStore;

  bool _loading = false;
  bool _listen = false;

  @override
  void initState() {
    _handlePermission();
    _toggleServiceStatusStream();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _locationStore = Provider.of<AuthStore>(context).locationStore;
    _settingStore = Provider.of<SettingStore>(context);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    if (_serviceStatusStreamSubscription != null) {
      _serviceStatusStreamSubscription!.cancel();
      _serviceStatusStreamSubscription = null;
    }

    super.dispose();
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await _geoLocatorPlatform.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return false;
    }

    permission = await _geoLocatorPlatform.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await _geoLocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    await _getLocation(permission);

    return true;
  }

  void _toggleServiceStatusStream() {
    if (_serviceStatusStreamSubscription == null) {
      final serviceStatusStream = _geoLocatorPlatform.getServiceStatusStream();

      _serviceStatusStreamSubscription = serviceStatusStream.handleError((error) {
        _serviceStatusStreamSubscription?.cancel();
        _serviceStatusStreamSubscription = null;
      }).listen((serviceStatus) {
        if (serviceStatus == ServiceStatus.enabled && _listen) {
          _handlePermission();
        }
      });
    }
  }

  void _openAppSettings() async {
    bool allow = await _handlePermission();
    if (!allow) {
      setState(() {
        _listen = true;
      });
      await _geoLocatorPlatform.openAppSettings();
    }
  }

  Future<void> _getLocation(LocationPermission permission) async {
    setState(() {
      _loading = true;
    });

    final position = await _geoLocatorPlatform.getCurrentPosition();

    List<Placemark> placements = await placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark place = placements.first;

    _locationStore.setLocation(
      location: UserLocation(
        lat: position.latitude,
        lng: position.longitude,
        address: '${place.name}, ${place.administrativeArea}, ${place.isoCountryCode}',
        tag: '',
      ),
    );

    await _settingStore.closeAllowLocation();

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: _loading ? _buildLoading() : _buildContent(context),
      bottomNavigationBar: !_loading
          ? Padding(
              padding: paddingHorizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _openAppSettings,
                      style: ElevatedButton.styleFrom(padding: paddingVerticalSmall),
                      child: Text(translate('search_allow_btn')),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final result = await showSearch(
                          context: context,
                          delegate: SearchLocationScreen(context, translate),
                        );
                        if (result != null) {
                          setState(() {
                            _loading = true;
                          });

                          Place place = await GooglePlaceApiHelper().getPlaceDetailFromId(queryParameters: {
                            'place_id': result.placeId,
                          });
                          await _locationStore.setLocation(location: place.toUserLocation());

                          setState(() {
                            _loading = false;
                          });

                          await _settingStore.closeAllowLocation();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: paddingVerticalSmall,
                        primary: theme.colorScheme.surface,
                        onPrimary: theme.textTheme.subtitle1!.color,
                      ),
                      child: Text(translate('search_enter_btn')),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                ],
              ),
            )
          : null,
    );
  }

  Widget _buildLoading() {
    return const LookingLocationScreen(
      locationTitle: '',
    );
  }

  Widget _buildContent(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return Center(
      child: Padding(
        padding: paddingHorizontal,
        child: NotificationScreen(
          title: Text(translate('search_you_are_turning_off_location_access'), style: theme.textTheme.subtitle1),
          content: Text(
            translate('search_allowing'),
            style: theme.textTheme.bodyText2,
            textAlign: TextAlign.center,
          ),
          iconData: FontAwesomeIcons.mapMarked,
          isButton: false,
        ),
      ),
    );
  }
}
