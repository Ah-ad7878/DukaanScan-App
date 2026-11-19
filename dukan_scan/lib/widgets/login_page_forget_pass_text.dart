import 'package:dukan_scan/providers/login_page_provider.dart';
import 'package:dukan_scan/responsive/screen_responsive.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';

class LoginPageForgetPassText extends StatelessWidget {
  final LoginPageProvider provider;

  const LoginPageForgetPassText({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .centerRight,
      child: GestureDetector(
        onTap: () => provider.resetpassword(context),
        child: Text(
          'password Bhool gaye?',
          style: TextStyle(
            color: const Color(0xFF056434),
            fontSize: ScreenResponsive.getValue(
              context,
              mobile: 13.sp,
              tablet: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}
