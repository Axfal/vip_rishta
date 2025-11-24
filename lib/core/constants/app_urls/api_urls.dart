class APIUrls {
  static const String baseUrl = 'https://onlypureherbal.com';

  ///Authentication
  static const String login = '$baseUrl/api/accounts/login/';
  static const String signup = '$baseUrl/api/accounts/register/';
  static const String verifyOTP = '$baseUrl/api/accounts/verify-otp/';
  static const String forgotPassword = '$baseUrl/api/accounts/request-otp/';

  /// Social
  // Profile
  static const String getProfile =
      '$baseUrl/api/social/get_profile/'; // id is required
  static const String updateProfile = '$baseUrl/api/social/profile/update/';

  // likes
  static const String likeSomeone = '$baseUrl/api/social/like/';
  static const String whoLikesMe = '$baseUrl/api/social/likes/me/';

  //match
  static const String suggestedMatch = '$baseUrl/api/social/matches/suggested';
  static const String updatePreferences =
      '$baseUrl/api/social/preference/update/';

  static const String premiumPlan = '$baseUrl/api/premium/plans/';
  static const String subscribePlan = '$baseUrl/api/premium/subscribe';

  /// Activity
  static const String sendContact = '$baseUrl/api/activity/contact/send/'; //id
  static const String receiveContact = '$baseUrl/api/activity/contact/received/';
  static const String approveContact = '$baseUrl/api/activity/contact/approve/'; //id
}
