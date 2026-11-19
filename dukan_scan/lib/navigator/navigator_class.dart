import 'package:dukan_scan/screens/home_screen.dart';
import 'package:dukan_scan/screens/login_screen.dart';
import 'package:dukan_scan/screens/sign_up_screen.dart';
import 'package:dukan_scan/screens/splash_screen.dart';
import 'package:material_ui/material_ui.dart';

class NavigatorClass {
  static const String splahScreenRouteName = '/';
  static const String signUpScreenRouteName = '/signup';
  static const String loginScreenRouteName = '/login';
  static const String homeScreenRouteName = '/home';

  static Route<dynamic> onGenerate(RouteSettings setting) {
    if (setting.name == splahScreenRouteName) {
      return MaterialPageRoute(builder: (context) => const SplashScreen());
    } else if (setting.name == homeScreenRouteName) {
      return MaterialPageRoute(builder: (context) => const HomeScreen());
    } else if (setting.name == signUpScreenRouteName) {
      return MaterialPageRoute(builder: (context) => const SignUpScreen());
    } else if (setting.name == loginScreenRouteName) {
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    } else {
      return MaterialPageRoute(
        builder: (context) =>
            const Scaffold(body: Center(child: Text('Route not found'))),
      );
    }
  }
}
