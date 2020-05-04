import 'dart:convert';

import 'package:http/http.dart' as http;
class NetworkUtil{
 // static String base_url = 'http://api.neodove.com/api/v1/';
  static String base_url = 'http://api-staging.neodove.com/api/v1/';
  static String Image_url = 'http://grossry.com/backend/public/';

  static NetworkUtil _instance = new NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> get(String url, {Map<String, String> headers, encoding}) {
    return http
        .get(
      url,
      headers: headers,
    ).then((http.Response response) {
      String res = response.body;
      int statusCode = response.statusCode;
      print("API Response: " + res);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        res = "{\"status\":"+
            statusCode.toString() +
            ",\"message\":\"error\",\"response\":" +
            res +
            "}";
        throw new Exception( statusCode);
      }
      return _decoder.convert(res);
    }).timeout(const Duration(seconds:300));
  }

  Future<dynamic> post(String url,
      {Map<String, String> headers, body, encoding}) {

    return http
        .post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      String res = response.body;
      int statusCode = response.statusCode;
      print("API Response: " + res);
      if (statusCode < 200 || statusCode > 400 || json == null) {

        throw new Exception( statusCode);
      }
      return _decoder.convert(res);
    }).timeout(const Duration(seconds:30));
  }
  Future<dynamic> put(String url,
      {Map<String, String> headers, body, encoding}) {

    return http
        .put(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      String res = response.body;
      int statusCode = response.statusCode;
      print("API Response: " + res);
      if (statusCode < 200 || statusCode > 400 || json == null) {

        throw new Exception( statusCode);
      }
      return _decoder.convert(res);
    }).timeout(const Duration(seconds:30));
  }

}