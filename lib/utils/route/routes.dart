import 'package:flutter/material.dart';
import 'package:rishta_app/screens/auth/login/login_screen.dart';
import 'package:rishta_app/screens/auth/signup/view/signup_screen.dart';
import 'package:rishta_app/screens/splash_screen/splash_screen.dart';
import 'package:rishta_app/utils/route/routes_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case RoutesName.signup:
        return MaterialPageRoute(
          builder: (context) => SignupScreen(onTap: () {}),
        );

      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(child: Text('No route defined')),
            );
          },
        );
    }
  }
}
