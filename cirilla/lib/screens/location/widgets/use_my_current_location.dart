import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'package:cirilla/models/location/user_location.dart';
import 'package:cirilla/store/auth/auth_store.dart';
import 'package:cirilla/store/auth/location_store.dart';
import 'package:cirilla/widgets/cirilla_tile.dart';

class UseMyCurrentLocation extends StatefulWidget {
  const UseMyCurrentLocation({Key? key}) : super(key: key);

  @override
  State<UseMyCurrentLocation> createState() => _UseMyCurrentLocationState();
}

class _UseMyCurrentLocationState extends State<UseMyCurrentLocation> {
  final GeolocatorPlatform _geoLocatorPlatform = GeolocatorPlatform.instance;

  late LocationStore _locationStore;

  bool _loading = false;

  @override
  void didChangeDependencies() {
    _locationStore = Provider.of<AuthStore>(context).locationStore;

    super.didChangeDependencies();
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

    return true;
  }

  Future<void> _getLocation() async {
    setState(() {
      _loading = true;
    });

    bool enabled = await _handlePermission();

    if (!enabled) {
      setState(() {
        _loading = false;
      });
      await _geoLocatorPlatform.openAppSettings();
      return;
    }

    final position = await _geoLocatorPlatform.getCurrentPosition();

    List<Placemark> placements = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placements.first;

    avoidPrint(position);

    _locationStore.setLocation(
      location: UserLocation(
        lat: position.latitude,
        lng: position.longitude,
        address: '${place.name}, ${place.administrativeArea}, ${place.isoCountryCode}',
        tag: '',
      ),
    );

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return CirillaTile(
      title: Text(
        translate('location_current_location'),
        style: theme.textTheme.caption?.copyWith(color: theme.textTheme.subtitle1!.color),
      ),
      trailing: _loading
          ? const SizedBox(width: 25, height: 25, child: CircularProgressIndicator(strokeWidth: 2))
          : Icon(
              Icons.my_location,
              size: 20,
              color: theme.textTheme.subtitle1!.color,
            ),
      isChevron: false,
      height: 50,
      onTap: () => _getLocation(),
    );
  }
}
