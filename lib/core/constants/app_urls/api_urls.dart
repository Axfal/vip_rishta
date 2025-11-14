class APIUrls {
  static const String baseUrl = 'https://promac.pk';

  ///Authentication
  static const String login = '$baseUrl/api/accounts/login/';
  static const String signup = '$baseUrl/api/accounts/register/';
  static const String verifyOTP = '$baseUrl/api/accounts/verify-otp/';
  static const String forgotPassword = '$baseUrl/api/accounts/request-otp/';

  /// Profile
  static const String getProfile =
      '$baseUrl/api/social/get_profile/'; // id is required
  static const String updateProfile = '$baseUrl/api/social/profile/update/';
}
