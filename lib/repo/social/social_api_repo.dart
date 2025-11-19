abstract class SocialAPIRepo {
  Future<dynamic> whoLikesMe();
  Future<dynamic> likeSomeone(dynamic data, {required String id});
  Future<dynamic> updatePreference(dynamic data);
  Future<dynamic> suggestedMatch(dynamic data);
}
