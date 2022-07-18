// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

class ENV {
  /// ? Mapbox access token
  static const String ACCESS_TOKEN = String.fromEnvironment("ACCESS_TOKEN");

  /// ? API and stuff
  // static const String DOMAIN = "http://localhost:";
  static const String DOMAIN = "http://194.163.146.6";
  static const String PORT = ":8008";
  static const String BASE = DOMAIN + PORT;
  static const String ENDPOINT = "/v1";

  /// ?
  static const String API_URL = BASE + ENDPOINT;
}

class PROCESS {
  static int resendPasswordDuration = 30;
}
