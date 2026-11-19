import 'package:dukan_scan/navigator/navigator_class.dart';
import 'package:material_ui/material_ui.dart';

class SplashProvider extends ChangeNotifier {
  final PageController pageController = PageController();
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  final List onboardingData = [
    {
      'animation': 'assets/animations/cart.json',
      'title': 'Tez Barcode Scanning',
      'subtitle': 'Apne mobile camera se kisi bhi item ka barcode scan karein aur foran bill banayein.',
    },
    {
      'animation': 'assets/animations/qr.json',
      'title': 'Dukan ka Mukammal Hisaab',
      'subtitle': 'Rozana ki bikri, stock aur munafa ka record ab ek click par mehfooz rakhein.',
    },
    {
      'animation': 'assets/animations/payment.json',
      'title': 'Asaan aur Digital Dukaandaari',
      'subtitle': 'Register aur parchi ki jhanjhat khatam—apni dukan ko modern banayein.',
    },
  ];

  void onPageChanged(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void nextPage(BuildContext context) {
    if (_currentIndex < onboardingData.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      goToSignUp(context);
    }
  }

  void goToSignUp(BuildContext context) {
    Navigator.pushReplacementNamed(
      context,
      NavigatorClass.signUpScreenRouteName,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
