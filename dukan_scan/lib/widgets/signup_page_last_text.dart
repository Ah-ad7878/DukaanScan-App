import 'package:dukan_scan/navigator/navigator_class.dart';
import 'package:dukan_scan/responsive/screen_responsive.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';

class LatText extends StatelessWidget {
  const LatText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Pehle se account hai? ',
          style: TextStyle(
            fontSize: ScreenResponsive.getValue(
              context,
              mobile: 14.sp,
              tablet: 17.sp,
            ),

            color: const Color(0xFF475569),
          ),
        ),

        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, NavigatorClass.loginScreenRouteName);
          },
          child: Text(
            'Login',
            style: TextStyle(
              color: const Color(0xFF0C7A43),
              fontWeight: .bold,
              fontSize: ScreenResponsive.getValue(
                context,
                mobile: 14.sp,
                tablet: 17.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
