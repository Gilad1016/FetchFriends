import 'dart:async';

import 'package:flutter/services.dart';
import 'package:location/location.dart';

class LocationProvider {
  Location location = Location();
  late LocationData _locationData;
  bool _serviceEnabled = false;
  final StreamController<bool> _onLocationStateChange =
  StreamController.broadcast();

  Stream<bool> get onLocationStateChange => _onLocationStateChange.stream;

  void _updateLocationState(bool isGranted) {
    _onLocationStateChange.add(isGranted);
  }


  Future<void> checkService() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        _updateLocationState(false);
        throw PlatformException(
            code: 'LOCATION_SERVICES_DISABLED',
            message: 'Location services are disabled.');
      }
    }
  }

  Future<void> checkPermission() async {
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted != PermissionStatus.granted) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        _updateLocationState(false);
        throw PlatformException(
            code: 'LOCATION_PERMISSION_DENIED',
            message: 'Location permission is denied.');
      }
    }
  }

  Future<String> getLocation() async {
    try {
      await checkService();
      await checkPermission();
      _locationData = await location.getLocation();
    } on PlatformException catch (e) {
      return e.message ?? "error";
    }
    _updateLocationState(true);
    return "success";
  }

  Future<bool> isLocationReady() async {
    return await location.serviceEnabled() && await location.hasPermission() == PermissionStatus.granted;
  }


  double? get latitude => _locationData.latitude;

  double? get longitude => _locationData.longitude;
}
