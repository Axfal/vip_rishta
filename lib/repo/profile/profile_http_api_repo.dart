// ignore_for_file: avoid_print

import 'package:rishta_app/core/constants/app_urls/api_urls.dart';
import 'package:rishta_app/data/network/base_service.dart';
import 'package:rishta_app/data/network/network_service.dart';
import 'package:rishta_app/repo/profile/profille_api_repo.dart';

class ProfileHttpApiRepo extends ProfileApiRepo {
  BaseApiServices apiServices = NetworkApiService();
  @override
  Future getProfile(dynamic data) async {
    final uri = Uri.parse(APIUrls.getProfile).replace(queryParameters: data);
    try {
      final response = await apiServices.getApi(uri.toString());
      return response;
    } catch (e) {
      print('error: $e');
      rethrow;
    }
  }

  @override
  Future updateProfile(dynamic data) async {
    try {
      final response = await apiServices.putApi(APIUrls.updateProfile, data);
      return response;
    } catch (e) {
      print('error: $e');
    }
  }
}
