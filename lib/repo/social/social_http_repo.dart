// ignore_for_file: avoid_print

import 'package:rishta_app/core/constants/app_urls/api_urls.dart';
import 'package:rishta_app/data/network/base_service.dart';
import 'package:rishta_app/data/network/network_service.dart';
import 'package:rishta_app/repo/social/social_api_repo.dart';

import '../../services/user_session.dart';

class SocialHttpAPIRepo extends SocialAPIRepo {
  final BaseApiServices apiServices = NetworkApiService();

  @override
  Future<dynamic> likeSomeone(dynamic data, {required String id}) async {
    try {
      final response = await apiServices.postApi(
        '${APIUrls.likeSomeone}/$id/',
        data,
      );
      return response;
    } catch (e) {
      print('error: $e');
      rethrow;
    }
  }

  @override
  Future<dynamic> whoLikesMe() async {
    try {
      final token = SessionController.user.tokens!.access.toString();
      Map<String, String>? headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };

      final response = await apiServices.getApi(
        APIUrls.whoLikesMe,
        headers: headers,
      );
      return response;
    } catch (e) {
      print('error: $e');
      rethrow;
    }
  }

  @override
  Future suggestedMatch(dynamic data) {
    // TODO: implement suggestedMatch
    throw UnimplementedError();
  }

  @override
  Future updatePreference(dynamic data) {
    // TODO: implement updatePreference
    throw UnimplementedError();
  }
}
