import 'dart:async';

import 'package:flutter/services.dart';

class FlutterUtilsSmartidBam {
  static const MethodChannel _channel =
      const MethodChannel('flutter_utils_smartid_bam');

  static const String GET_INSTANCE = "getInstance";

  static Future<Map<String, dynamic>> getInstance() async {
    final Map<dynamic, dynamic> response =
        await _channel.invokeMethod(GET_INSTANCE, {});
    return Map<String, dynamic>.from(response);
  }
}
