import 'package:dukan_scan/navigator/navigator_class.dart';
import 'package:dukan_scan/providers/login_page_provider.dart';
import 'package:dukan_scan/responsive/screen_responsive.dart';
import 'package:dukan_scan/widgets/login_button.dart';
import 'package:dukan_scan/widgets/login_dukaandarr_text.dart';
import 'package:dukan_scan/widgets/login_page_forget_pass_text.dart';
import 'package:dukan_scan/widgets/login_page_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isTablet = ScreenResponsive.isTablet(context);
    final provider = context.watch<LoginPageProvider>();
    return Scaffold(
      backgroundColor: const Color(0xFFF8F4EA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: ScreenResponsive.getValue(
                  context,
                  mobile: 55.h,
                  tablet: 70.h,
                ),
                bottom: ScreenResponsive.getValue(
                  context,
                  mobile: 38.h,
                  tablet: 48.h,
                ),
              ),

              decoration: BoxDecoration(
                color: const Color(0xFF0C7A43),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32.r),
                  bottomRight: Radius.circular(32.r),
                ),
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: ScreenResponsive.getValue(
                      context,
                      mobile: 76.w,
                      tablet: 100.w,
                    ),
                    width: ScreenResponsive.getValue(
                      context,
                      mobile: 76.w,
                      tablet: 100.w,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5A922),
                      borderRadius: BorderRadius.circular(24.r),
                    ),

                    child: Icon(
                      Icons.qr_code_scanner_rounded,
                      size: ScreenResponsive.getValue(
                        context,
                        mobile: 42.sp,
                        tablet: 56.sp,
                      ),
                      color: Colors.black,
                    ),
                  ),

                  Text(
                    'DukaanScan',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: .bold,
                      fontSize: ScreenResponsive.getValue(
                        context,
                        mobile: 28.sp,
                        tablet: 34.sp,
                      ),
                      letterSpacing: 0.5,
                    ),
                  ),

                  SizedBox(height: 10.h),

                  Text(
                    'Dukan ka hisaab,ab scan par',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),

                      fontSize: ScreenResponsive.getValue(
                        context,
                        mobile: 13.sp,
                        tablet: 17.sp,
                      ),
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),

            Center(
              child: Container(
                width: isTablet ? 520.w : double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenResponsive.getValue(
                    context,
                    mobile: 24.w,
                    tablet: 32.w,
                  ),
                  vertical: ScreenResponsive.getValue(
                    context,
                    mobile: 28.h,
                    tablet: 36.h,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LoginDukaandarrText(),
                    SizedBox(height: 20.h),
                    buildLabel(context, 'Email'),
                    buildTextField(
                      context,
                      controller: provider.emailController,
                      hint: 'Amjad1q1q@gmail.com...',
                    ),

                    SizedBox(height: 16.h),
                    buildLabel(context, 'password'),
                    buildTextField(
                      context,
                      controller: provider.passwordController,
                      hint: 'Password darj karein',
                      obscureText: provider.obscurePassword,
                      suffixIcon: IconButton(
                        onPressed: () {
                          provider.passwordVisibility();
                        },
                        icon: Icon(
                          provider.obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),

                    SizedBox(height: 15.h),
                    LoginPageForgetPassText(provider: provider),
                    SizedBox(height: 15.h),
                    LoginButton(provider: provider),

                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Naye Dukaandaar? ',
                          style: TextStyle(
                            color: const Color(0xFF64748B),
                            fontSize: ScreenResponsive.getValue(
                              context,
                              mobile: 15.sp,
                              tablet: 18.sp,
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              NavigatorClass.signUpScreenRouteName,
                            );
                          },
                          child: Text(
                            'Account banayein',
                            style: TextStyle(
                              color: Colors.green.shade900,
                              fontSize: ScreenResponsive.getValue(
                                context,
                                mobile: 15.sp,
                                tablet: 18.sp,
                              ),
                              fontWeight: .bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
