import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

class MockClientFactory {
  static http.Client get200Client(String response) {
    return MockClient((request) async => http.Response(response, 200));
  }

  static http.Client get404Client() {
    return MockClient((request) async => http.Response("", 404));
  }

  static http.Client getSocketExceptionClient() {
    return MockClient((request) async =>
        throw const SocketException("This is a simulated SocketException!"));
  }

  static http.Client getTimeoutExceptionClient() {
    return MockClient((request) async =>
        throw TimeoutException("This is a simulated TimeoutException!"));
  }

  static http.Client getHttpExceptionClient() {
    return MockClient((request) async =>
        throw const HttpException("This is a simulated HttpException"));
  }
}
