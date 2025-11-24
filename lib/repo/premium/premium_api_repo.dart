abstract class PremiumApiRepo {
  Future<dynamic> premiumPlan();
  Future<dynamic> subscribePlan(String id); /// plan id
}