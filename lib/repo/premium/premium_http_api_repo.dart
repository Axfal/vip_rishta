// ignore_for_file: avoid_print

import 'package:rishta_app/core/constants/app_urls/api_urls.dart';
import 'package:rishta_app/data/network/base_service.dart';
import 'package:rishta_app/data/network/network_service.dart';
import 'package:rishta_app/repo/premium/premium_api_repo.dart';
import 'package:rishta_app/services/user_session.dart';

class PremiumHttpApiRepo extends PremiumApiRepo {
  final BaseApiServices apiServices = NetworkApiService();
  final token = SessionController.user.tokens?.access.toString();

  @override
  Future<dynamic> subscribePlan(String id) async{
    try {
      final response = await apiServices.getApi(
        '${APIUrls.subscribePlan}/$id',
        headers: {"Authorization": "Bearer $token"},
      );

      return response;
    } catch (e) {
      print('error: $e');
      rethrow;
    }
  }


  @override
  Future<dynamic> premiumPlan() async {
    try {
      final response = await apiServices.getApi(
        APIUrls.premiumPlan,
        headers: {"Authorization": "Bearer $token"},
      );

      return response;
    } catch (e) {
      print('error: $e');
      rethrow;
    }
  }
}
