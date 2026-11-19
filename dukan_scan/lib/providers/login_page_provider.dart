import 'package:dukan_scan/navigator/navigator_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_ui/material_ui.dart';

class LoginPageProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isObscure = true;
  String _message = '';

  bool get obscurePassword => _isObscure;
  bool get loading => _isLoading;
  String get message => _message;

  void passwordVisibility() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  Future<void> loginShop(BuildContext context) async {
    final mail = emailController.text.trim();
    final pass = passwordController.text.trim();

    if (mail.isEmpty || pass.isEmpty) {
      showMessage('Email and password dono likhein', context);
    }

    if (!mail.contains('@')) {
      showMessage('shai email address likhein', context);
    }

    try {
      _isLoading = true;
      notifyListeners();

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: mail,
        password: pass,
      );

      _isLoading = false;
      notifyListeners();

      if (context.mounted) {
        showMessage('Login Kamyab', context);
        Navigator.pushNamed(context, NavigatorClass.homeScreenRouteName);
        return;
      }
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      notifyListeners();

      String errorText = 'Login mein masla aaya';
      if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
        errorText = 'Email ya Password ghalat hai';
      } else if (e.code == 'wrong-password') {
        errorText = 'Password ghalat hai';
      } else if (e.code == 'invalid-email') {
        errorText = 'Email format sahi nahi hai';
      }

      if (context.mounted) showMessage(errorText, context);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      if (context.mounted) {
        showMessage('Error: $e', context);
      }
    }
  }

  Future<void> resetpassword(BuildContext context) async {
    final email = emailController.text.trim();

    if (email.isEmpty || !email.contains('@')) {
      showMessage('Pehle apna email address likhein', context);
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      if (context.mounted) {
        showMessage(
          'Password reset link aapke email par bhej diya gaya hai',
          context,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        showMessage(e.message ?? 'Reset email bhejne mein masla aaya', context);
      }
    }
  }

  void showMessage(String text, BuildContext context) {
    _message = text;
    notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
