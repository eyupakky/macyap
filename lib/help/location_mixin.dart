import 'dart:io';

import 'package:flutter/services.dart';
import 'package:location/location.dart';

mixin LocationMixin {
  var location = Location();
  late PermissionStatus _permissionGranted;
  bool _serviceEnabled = false;

  Future<LocationData?> getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    return await location.getLocation();
  }
}
