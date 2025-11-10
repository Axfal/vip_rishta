import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rishta_app/utils/route/routes_name.dart';

import '../model/auth/user_model.dart';
import 'local_storage.dart';

class SessionController {
  final LocalStorage localStorage = LocalStorage();

  /// Singleton instance
  static final SessionController _instance = SessionController._internal();

  static bool isLogin = false;
  static UserModel user = UserModel();
  static String accessToken = '';
  static String refreshToken = '';

  SessionController._internal();

  factory SessionController() => _instance;

  /// Save user model in secure storage
  Future<void> saveUserInPreference(UserModel userModel) async {
    final String userJson = jsonEncode(userModel.toJson());

    await localStorage.setValue('user', userJson);
    await localStorage.setValue('isLogin', 'true');

    // Save Tokens
    await localStorage.setValue('accessToken', userModel.tokens?.access ?? "");
    await localStorage.setValue(
      'refreshToken',
      userModel.tokens?.refresh ?? "",
    );

    // Set static session variables
    SessionController.user = userModel;
    SessionController.isLogin = true;
    SessionController.accessToken = userModel.tokens?.access ?? "";
    SessionController.refreshToken = userModel.tokens?.refresh ?? "";
  }

  /// Load user session on app start
  Future<void> getUserFromPreference() async {
    try {
      final String? userData = await localStorage.readValue('user');
      final String? isLoginStr = await localStorage.readValue('isLogin');
      final String? storedAccess = await localStorage.readValue('accessToken');
      final String? storedRefresh = await localStorage.readValue(
        'refreshToken',
      );

      if (userData != null && userData.isNotEmpty) {
        SessionController.user = UserModel.fromJson(jsonDecode(userData));
      } else {
        SessionController.user = UserModel();
      }

      SessionController.isLogin = (isLoginStr == 'true');
      SessionController.accessToken = storedAccess ?? '';
      SessionController.refreshToken = storedRefresh ?? '';
    } catch (e) {
      debugPrint("Session load error: $e");
      SessionController.isLogin = false;
      SessionController.user = UserModel();
      SessionController.accessToken = '';
      SessionController.refreshToken = '';
    }
  }

  /// Logout and clear all session data
  Future<void> logoutUser(BuildContext context) async {
    try {
      await localStorage.clearValue('user');
      await localStorage.clearValue('isLogin');
      await localStorage.clearValue('accessToken');
      await localStorage.clearValue('refreshToken');

      SessionController.isLogin = false;
      SessionController.user = UserModel();
      SessionController.accessToken = '';
      SessionController.refreshToken = '';

      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.login,
        (_) => false,
      );
    } catch (e) {
      debugPrint("Logout error: $e");
    }
  }
}
