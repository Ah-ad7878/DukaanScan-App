import 'package:dukan_scan/providers/signup_screen_provider.dart';
import 'package:dukan_scan/responsive/screen_responsive.dart';
import 'package:dukan_scan/widgets/signup_page_last_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SignupScreenProvider>();
    final bool isTablet = ScreenResponsive.isTablet(context);

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
                  mobile: 50.h,
                  tablet: 60.h,
                ),
                left: ScreenResponsive.getValue(
                  context,
                  mobile: 24.w,
                  tablet: 40.w,
                ),
                right: ScreenResponsive.getValue(
                  context,
                  mobile: 24.w,
                  tablet: 40.w,
                ),
                bottom: ScreenResponsive.getValue(
                  context,
                  mobile: 32.h,
                  tablet: 40.h,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Apni Dukan Shuru Karein',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: .bold,
                      fontSize: ScreenResponsive.getValue(
                        context,
                        mobile: 26.sp,
                        tablet: 31.sp,
                      ),
                    ),
                  ),

                  SizedBox(height: 6.h),
                  Text(
                    '1 Minute mein account tayyar',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
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
                    mobile: 24.h,
                    tablet: 30.h,
                  ),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel(context, 'Dukan ka naam'),
                    _buildTextField(
                      context,
                      controller: provider.dukanName,
                      hint: 'e.g. Rehmant General Store',
                    ),

                    SizedBox(height: 16.h),
                    _buildLabel(context, 'Malik Ka naam'),
                    _buildTextField(
                      context,
                      controller: provider.ownerName,
                      hint: 'ApKa poora naam',
                    ),

                    SizedBox(height: 16.h),
                    _buildLabel(context, 'Email'),
                    _buildTextField(
                      context,
                      controller: provider.email,
                      hint: 'Enter Email here...',
                    ),

                    SizedBox(height: 16.h),
                    _buildLabel(context, 'Shehar'),
                    _buildTextField(
                      context,
                      controller: provider.cityName,
                      hint: 'e.g. Bahawalpur',
                    ),

                    SizedBox(height: 16.h),
                    _buildLabel(context, 'Password'),
                    _buildTextField(
                      context,
                      controller: provider.password,
                      hint: 'password here of lenght 6..',
                    ),

                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        SizedBox(
                          width: 24.w,
                          height: 24.h,
                          child: Checkbox(
                            activeColor: const Color(0xFF0C7A43),
                            value: provider.termsAccepted,
                            onChanged: provider.toggleTerms,
                          ),
                        ),

                        SizedBox(width: 10.w),
                        Text(
                          'Main sharaait se ittefaq karta hoon',
                          style: TextStyle(
                            fontSize: ScreenResponsive.getValue(
                              context,
                              mobile: 13.sp,
                              tablet: 16.sp,
                            ),
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 15.h),
                    SizedBox(
                      width: double.infinity,
                      height: ScreenResponsive.getValue(
                        context,
                        mobile: 52.h,
                        tablet: 60.h,
                      ),

                      child: ElevatedButton(
                        onPressed: provider.loading
                            ? null
                            : () => provider.registerShop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE5A922),
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(14.r),
                          ),
                        ),
                        child: provider.loading
                            ? SizedBox(
                                width: 24.w,
                                height: 24.h,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.black,
                                ),
                              )
                            : Text(
                                'Account Banayein',
                                style: TextStyle(
                                  fontSize: ScreenResponsive.getValue(
                                    context,
                                    mobile: 16.sp,
                                    tablet: 20.sp,
                                  ),

                                  fontWeight: .bold,
                                ),
                              ),
                      ),
                    ),

                    SizedBox(height: 18.h),
                    const LatText(),
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

Widget _buildTextField(
  BuildContext context, {
  required TextEditingController controller,
  required String hint,
  TextInputType keyboardType = TextInputType.text,
  bool obscureText = false,
  Widget? suffixIcon,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    obscureText: obscureText,
    style: TextStyle(
      fontSize: ScreenResponsive.getValue(
        context,
        mobile: 14.sp,
        tablet: 17.sp,
      ),
      color: const Color(0xFF0F172A),
    ),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: const Color(0xFF94A3B8),
        fontSize: ScreenResponsive.getValue(
          context,
          mobile: 14.sp,
          tablet: 17.sp,
        ),
      ),
      filled: true,
      fillColor: Colors.white,
      suffixIcon: suffixIcon,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: ScreenResponsive.getValue(
          context,
          mobile: 14.h,
          tablet: 18.h,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: Color(0xFF0C7A43), width: 1.5),
      ),
    ),
  );
}

Widget _buildLabel(BuildContext context, String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6.h),
    child: Text(
      text,
      style: TextStyle(
        fontSize: ScreenResponsive.getValue(
          context,
          mobile: 13.sp,
          tablet: 16.sp,
        ),
        fontWeight: FontWeight.w600,
        color: const Color(0xFF1E293B),
      ),
    ),
  );
}
