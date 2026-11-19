import 'package:dukan_scan/providers/login_page_provider.dart';
import 'package:dukan_scan/responsive/screen_responsive.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';

class LoginButton extends StatelessWidget {
  final LoginPageProvider provider;
  const LoginButton({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: ScreenResponsive.getValue(context, mobile: 52.h, tablet: 60.h),
      child: ElevatedButton(
        onPressed: () {
          provider.loginShop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0C7A43),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
        child: provider.loading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
            : Text(
                'Login',
                style: TextStyle(
                  fontSize: ScreenResponsive.getValue(
                    context,
                    mobile: 16.sp,
                    tablet: 20.sp,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
