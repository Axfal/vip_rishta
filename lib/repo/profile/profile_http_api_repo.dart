// ignore_for_file: avoid_print
import 'dart:io';
import 'package:rishta_app/core/constants/app_urls/api_urls.dart';
import 'package:rishta_app/data/network/base_service.dart';
import 'package:rishta_app/data/network/network_service.dart';
import 'package:rishta_app/repo/profile/profille_api_repo.dart';
import '../../services/user_session.dart';

class ProfileHttpApiRepo extends ProfileApiRepo {
  BaseApiServices apiServices = NetworkApiService();
  @override
  Future getProfile(dynamic data) async {
    final uri = Uri.parse(APIUrls.getProfile).replace(queryParameters: data);

    try {
      final token = SessionController.user.tokens!.access.toString();

      final response = await apiServices.getApi(
        uri.toString(),
        headers: {"Authorization": "Bearer $token"},
      );

      return response;
    } catch (e) {
      print('error: $e');
      rethrow;
    }
  }

  @override
  Future updateProfile(dynamic data, File? image) async {
    try {
      final token = SessionController.user.tokens!.access.toString();
      Map<String, String>? headers;
      if (image != null) {
        headers = {
          "Content-Type": "multipart/form-data",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        };
      }

      final response = await apiServices.putApi(
        APIUrls.updateProfile,
        data,
        file: image,
        token: token,
        headers: headers,
      );

      return response;
    } catch (e) {
      print("Update Profile Error: $e");
      rethrow;
    }
  }
}
