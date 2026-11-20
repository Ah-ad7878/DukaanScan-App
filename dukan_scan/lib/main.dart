import 'package:dukan_scan/firebase_options.dart';
import 'package:dukan_scan/navigator/navigator_class.dart';
import 'package:dukan_scan/providers/home_screen_provider.dart';
import 'package:dukan_scan/providers/login_page_provider.dart';
import 'package:dukan_scan/providers/product_page_provider.dart';
import 'package:dukan_scan/providers/signup_screen_provider.dart';
import 'package:dukan_scan/providers/splash_screen_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashProvider()),
        ChangeNotifierProvider(create: (context) => SignupScreenProvider()),
        ChangeNotifierProvider(create: (context) => LoginPageProvider()),
        ChangeNotifierProvider(create: (context) => HomeScreenProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
      ],
      child: const NameBar(),
    ),
  );
}

class NameBar extends StatelessWidget {
  const NameBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'DukanScan',
          debugShowCheckedModeBanner: false,
          initialRoute: FirebaseAuth.instance.currentUser != null
              ? NavigatorClass.homeScreenRouteName
              : NavigatorClass.splahScreenRouteName,
          onGenerateRoute: NavigatorClass.onGenerate,
        );
      },
    );
  }
}
