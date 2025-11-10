abstract class AuthApiRepo {
  Future<dynamic> login(dynamic data);
  Future<dynamic> signup(dynamic data);
  Future<dynamic> forgotPassword(dynamic data);
  Future<dynamic> verifyOTP(dynamic data);
}
