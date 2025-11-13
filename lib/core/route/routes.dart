import 'package:rishta_app/screens/auth/forgot_password/request_otp.dart';
import 'package:rishta_app/screens/auth/forgot_password/verify_otp.dart';

import 'route_exports.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case RoutesName.signup:
        return MaterialPageRoute(builder: (context) => SignUpScreen());
      case RoutesName.forgot:
        return MaterialPageRoute(builder: (context) => RequestOTP());
      case RoutesName.verifyOtp:
        return MaterialPageRoute(builder: (context) => VerifyOtp());

      case RoutesName.home:
        return MaterialPageRoute(builder: (context) => HomePage());

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
