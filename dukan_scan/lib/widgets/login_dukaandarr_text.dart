import 'package:dukan_scan/responsive/screen_responsive.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';

class LoginDukaandarrText extends StatelessWidget {
  const LoginDukaandarrText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Dukaandaar Login',
      style: TextStyle(
        color: Colors.black,
        fontWeight: .bold,
        fontSize: ScreenResponsive.getValue(
          context,
          mobile: 22.sp,
          tablet: 26.sp,
        ),
      ),
    );
  }
}
