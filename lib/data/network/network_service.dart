import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../exception/app_excetions.dart';
import 'base_service.dart';

class NetworkApiService implements BaseApiServices {
  final Duration timeoutDuration = const Duration(seconds: 20);

  Map<String, String> getHeaders({
    Map<String, String>? customHeaders,
    String? token,
  }) {
    final defaultHeaders = {
      HttpHeaders.contentTypeHeader: 'application/json',
      if (token != null) HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    if (customHeaders != null) {
      defaultHeaders.addAll(customHeaders);
    }

    return defaultHeaders;
  }

  @override
  Future<dynamic> getApi(String url, {Map<String, String>? headers}) async {
    if (kDebugMode) print('GET $url');

    try {
      final response = await http
          .get(Uri.parse(url), headers: getHeaders(customHeaders: headers))
          .timeout(timeoutDuration);
      return _returnResponse(response);
    } on SocketException {
      throw NoInternetException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request timeout');
    }
  }

  @override
  Future<dynamic> postApi(
    String url,
    dynamic data, {
    Map<String, String>? headers,
  }) async {
    if (kDebugMode) {
      print('POST $url');
      print('Body: $data');
    }

    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: getHeaders(customHeaders: headers),
            body: jsonEncode(data),
          )
          .timeout(timeoutDuration);
      return _returnResponse(response);
    } on SocketException {
      throw NoInternetException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request timeout');
    }
  }

  @override
  Future<dynamic> postMultipartApi(
    String url,
    Map<String, dynamic> data, {
    Map<String, String>? headers,
  }) async {
    if (kDebugMode) {
      print('POST Multipart $url');
      print('Data: $data');
    }

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.headers.addAll(
        getHeaders(
          customHeaders:
              headers ??
              {
                "Content-Type": "multipart/form-data",
                "Accept": "application/json",
              },
        ),
      );

      data.forEach((key, value) async {
        if (value is File) {
          request.files.add(await http.MultipartFile.fromPath(key, value.path));
        } else {
          request.fields[key] = value.toString();
        }
      });

      var streamedResponse = await request.send().timeout(timeoutDuration);
      var response = await http.Response.fromStream(streamedResponse);

      return _returnResponse(response);
    } on SocketException {
      throw NoInternetException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request timeout');
    }
  }

  @override
  Future<dynamic> putApi(
    String url,
    dynamic data, {
    File? file,
   required String token,
        Map<String, String>? headers,
  }) async {
    if (kDebugMode) print('PUT $url');

    try {
      if (file != null) {
        var request = http.MultipartRequest('PUT', Uri.parse(url));

        request.headers.addAll(
          getHeaders(customHeaders: headers ?? {"Accept": "application/json", "Authorization": "Bearer $token",}),
        );

        data.forEach((key, value) {
          request.fields[key] = value.toString();
        });

        request.files.add(
          await http.MultipartFile.fromPath('image', file.path),
        );

        var streamedResponse = await request.send().timeout(timeoutDuration);
        var response = await http.Response.fromStream(streamedResponse);

        return _returnResponse(response);
      }

      final response = await http
          .put(
            Uri.parse(url),
            headers: getHeaders(customHeaders: headers),
            body: jsonEncode(data),
          )
          .timeout(timeoutDuration);

      return _returnResponse(response);
    } on SocketException {
      throw NoInternetException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request timeout');
    }
  }

  @override
  Future<dynamic> deleteApi(String url, dynamic data) async {
    if (kDebugMode) print('DELETE $url');

    try {
      final response = await http
          .delete(Uri.parse(url), body: jsonEncode(data))
          .timeout(timeoutDuration);
      return _returnResponse(response);
    } on SocketException {
      throw NoInternetException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request timeout');
    }
  }

  @override
  Future<dynamic> patchApi(
    String url,
    dynamic data, {
    Map<String, String>? headers,
  }) async {
    if (kDebugMode) print('PATCH $url');

    try {
      final response = await http
          .patch(
            Uri.parse(url),
            headers: getHeaders(customHeaders: headers),
            body: jsonEncode(data),
          )
          .timeout(timeoutDuration);
      return _returnResponse(response);
    } on SocketException {
      throw NoInternetException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request timeout');
    }
  }

  dynamic _returnResponse(http.Response response) {
    if (kDebugMode) {
      print('Status: ${response.statusCode}');
      print('Response: ${response.body}');
    }

    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body);
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw FetchDataException("Resource not found");
      case 500:
      default:
        throw FetchDataException(
          'Error occurred: ${response.statusCode} ${response.reasonPhrase}',
        );
    }
  }
}
