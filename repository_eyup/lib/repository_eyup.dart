
import 'dart:async';

import 'package:flutter/services.dart';

class RepositoryEyup {
  static const MethodChannel _channel = MethodChannel('repository_eyup');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
