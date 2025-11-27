// ignore_for_file: avoid_print

import 'package:rishta_app/core/constants/app_urls/api_urls.dart';
import 'package:rishta_app/data/network/base_service.dart';
import 'package:rishta_app/data/network/network_service.dart';
import 'package:rishta_app/repo/activity/activity_api_repo.dart';
import 'package:rishta_app/services/user_session.dart';

class ActivityHttpApiRepo extends ActivityApiRepo {
  BaseApiServices apiServices = NetworkApiService();

  @override
  Future partnerPreference(dynamic data) async {
    try {
      final token = SessionController.user.tokens!.access.toString();
      final response = await apiServices.postApi(
        APIUrls.updatePreferences,
        data,
        headers: {"Authorization": "Bearer $token"},
      );
      return response;
    } catch (e) {
      print('error: $e');
      rethrow;
    }
  }

  @override
  Future suggestedMatch() async {
    try {
      final token = SessionController.user.tokens!.access.toString();
      final response = await apiServices.getApi(
        APIUrls.suggestedMatch,
        headers: {"Authorization": "Bearer $token"},
      );
      return response;
    } catch (e) {
      print('error: $e');
      rethrow;
    }
  }

  /// Contact

  @override
  Future<dynamic> cancelRequest({
    dynamic data,
    required String requestedId,
  }) async {
    try {
      final token = SessionController.user.tokens!.access.toString();
      final response = await apiServices.deleteApi(
        '${APIUrls.cancelRequest}$requestedId/',
        data,
        headers: {"Authorization": "Bearer $token"},
      );
      return response;
    } catch (e) {
      print('error: $e');
      rethrow;
    }
  }

  @override
  Future<dynamic> getSentRequest(data) {
    // TODO: implement getSentRequest
    throw UnimplementedError();
  }

  @override
  Future<dynamic> sendContact({
    dynamic data,
    required String requestedId,
  }) async {
    try {
      final token = SessionController.user.tokens!.access.toString();
      final response = await apiServices.postApi(
        '${APIUrls.sendContact}$requestedId/',
        data,
        headers: {"Authorization": "Bearer $token"},
      );
      return response;
    } catch (e) {
      print('error: $e');
      rethrow;
    }
  }

  @override
  Future<dynamic> getSenContactRequestList() async {
    try {
      final token = SessionController.user.tokens!.access.toString();
      final response = await apiServices.getApi(
        APIUrls.mySentContactRequestList,
        headers: {"Authorization": "Bearer $token"},
      );
      return response;
    } catch (e) {
      print('error: $e');
      rethrow;
    }
  }

  @override
  Future<dynamic> approveContactRequest({
    dynamic data,
    required String requestedId,
  }) async {
    try {
      final token = SessionController.user.tokens!.access.toString();
      final response = await apiServices.postApi(
        '${APIUrls.approveContact}$requestedId/',
        data,
        headers: {"Authorization": "Bearer $token"},
      );
      return response;
    } catch (e) {
      print('error: $e');
      rethrow;
    }
  }

  @override
  Future<dynamic> receivedContactRequests() async{
    try {
      final token = SessionController.user.tokens!.access.toString();
      final response = await apiServices.getApi(
        APIUrls.receiveContact,
        headers: {"Authorization": "Bearer $token"},
      );
      return response;
    } catch (e) {
      print('error: $e');
      rethrow;
    }
  }
}
