import 'dart:io';

/// Abstract class for defining base API services.
abstract class BaseApiServices {
  Future<dynamic> getApi(String url, {Map<String, String>? headers});

  Future<dynamic> postApi(
    String url,
    dynamic data, {
    Map<String, String>? headers,
  });

  Future<dynamic> postMultipartApi(
    String url,
    Map<String, dynamic> data, {
    Map<String, String>? headers,
  });

  Future<dynamic> putApi(
    String url,
    dynamic data, {
    required String token,
    File? file,
    Map<String, String>? headers,
  });

  Future<dynamic> deleteApi(
    String url,
    dynamic data, {
    Map<String, String>? headers,
  });

  Future<dynamic> patchApi(String url, dynamic data);
}
