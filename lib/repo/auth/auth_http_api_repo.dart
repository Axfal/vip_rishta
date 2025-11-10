// ignore_for_file: avoid_print

import 'package:rishta_app/core/constants/app_urls/api_urls.dart';
import 'package:rishta_app/data/network/network_service.dart';
import 'package:rishta_app/repo/auth/auth_api_repo.dart';

class AuthHttpApiRepo extends AuthApiRepo {
  final _apiService = NetworkApiService();

  @override
  Future forgotPassword(data) async {
    try {
      final response = await _apiService.postApi(APIUrls.forgotPassword, data);
      return response;
    } catch (e) {
      print('error: $e');
      rethrow;
    }
  }

  @override
  Future login(dynamic data) async {
    try {
      final response = await _apiService.postApi(APIUrls.login, data);
      return response;
    } catch (e) {
      print('error: $e');
      rethrow;
    }
  }

  @override
  Future signup(data) async {
    try {
      final response = await _apiService.postApi(APIUrls.signup, data);
      return response;
    } catch (e) {
      print('error: $e');
      rethrow;
    }
  }

  @override
  Future verifyOTP(data) async {
    try {
      final response = await _apiService.postApi(APIUrls.verifyOTP, data);
      return response;
    } catch (e) {
      print('error: $e');
      rethrow;
    }
  }
}
