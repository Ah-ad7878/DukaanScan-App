import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukan_scan/navigator/navigator_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_ui/material_ui.dart';

class SignupScreenProvider extends ChangeNotifier {
  //controller
  final TextEditingController dukanName = TextEditingController();
  final TextEditingController ownerName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController cityName = TextEditingController();
  final TextEditingController password = TextEditingController();

  //variables
  bool _isObscure = true;
  bool _isTermAccepted = true;
  bool _isLoading = false;
  String _message = '';

  //getter
  bool get obscurePassword => _isObscure;
  bool get termsAccepted => _isTermAccepted;
  bool get loading => _isLoading;
  String get message => _message;

  void toggleTerms(bool? value) {
    _isTermAccepted = value ?? false;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  void _showMessage(BuildContext context, String text) {
    _message = text;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  //register Function
  Future<void> registerShop(BuildContext context) async {
    final shopName = dukanName.text.trim();
    final malikName = ownerName.text.trim();
    final emailAddress = email.text.trim();
    final city = cityName.text.trim();
    final pass = password.text.trim();

    //error message
    if (shopName.isEmpty ||
        malikName.isEmpty ||
        emailAddress.isEmpty ||
        city.isEmpty) {
      _showMessage(context, 'Fill all the fileds');
      return;
    }

    if (!emailAddress.contains('@')) {
      _showMessage(context, 'Enter a valid email address');
      return;
    }

    if (pass.length < 6) {
      _showMessage(context, 'Password must be at least 6 characters');
      return;
    }

    if (!_isTermAccepted) {
      _showMessage(context, 'Please accept terms and conditions');
      return;
    }

    try {
      _isLoading = true;
      notifyListeners();

      //check email and pass
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emailAddress, password: pass);

      final String uid = userCredential.user!.uid;
      //send data to firestore
      await FirebaseFirestore.instance.collection('shop').doc(uid).set({
        'uid': uid,
        'ShopName': shopName,
        'ownerName': malikName,
        'email': emailAddress,
        'city': city,
        'createdAt': FieldValue.serverTimestamp(),
      });

      _isLoading = false;
      notifyListeners();

      //after account created
      if (context.mounted) {
        _showMessage(context, 'Account created successfully!');
        Navigator.pushNamedAndRemoveUntil(
          context,
          NavigatorClass.homeScreenRouteName,
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      notifyListeners();

      String errorText = 'Registration failed';
      if (e.code == 'email-already-in-use') {
        errorText = 'This email is already registered';
      } else if (e.code == 'invalid-email') {
        errorText = 'Invalid email format';
      } else if (e.code == 'weak-password') {
        errorText = 'Password is too weak';
      }

      if (context.mounted) _showMessage(context, errorText);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      if (context.mounted) _showMessage(context, 'Error: $e');
    }
  }

  @override
  void dispose() {
    dukanName.dispose();
    ownerName.dispose();
    email.dispose();
    cityName.dispose();
    password.dispose();
    super.dispose();
    super.dispose();
  }
}
