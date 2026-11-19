import 'package:dukan_scan/responsive/screen_responsive.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';

Widget buildLabel(BuildContext context, String text) {
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
        color: const Color(0xFF64748B),
      ),
    ),
  );
}

Widget buildTextField(
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
      color: const Color(0xFF1E293B),
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
