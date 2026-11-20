import 'package:dukan_scan/providers/home_screen_provider.dart';
import 'package:dukan_scan/responsive/screen_responsive.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';

class HomePageGreenColorContainer extends StatelessWidget {
  final HomeScreenProvider provider;
  const HomePageGreenColorContainer({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        ScreenResponsive.getValue(context, mobile: 20.w, tablet: 28.w),
      ),

      decoration: BoxDecoration(
        color: const Color(0xFF0C7A43),
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E293B).withValues(alpha: 0.1),
            blurRadius: 16,
            spreadRadius: 0,
            offset: const Offset(6, 6),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Aaj kii Sale',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontWeight: .w500,
              fontSize: ScreenResponsive.getValue(
                context,
                mobile: 13.sp,
                tablet: 17.sp,
              ),
            ),
          ),

          SizedBox(height: 6.h),
          Text(
            'Rs ${provider.salseAmount.toStringAsFixed(0)}',
            style: TextStyle(
              color: const Color(0xFFE5A922),
              fontSize: ScreenResponsive.getValue(
                context,
                mobile: 32.sp,
                tablet: 42.sp,
              ),
              fontWeight: FontWeight.w800,
            ),
          ),

          SizedBox(height: 8.h),
          Text(
            '${provider.todayBills} bill · ${provider.salseAmount}',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: ScreenResponsive.getValue(
                context,
                mobile: 13.sp,
                tablet: 16.sp,
              ),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
