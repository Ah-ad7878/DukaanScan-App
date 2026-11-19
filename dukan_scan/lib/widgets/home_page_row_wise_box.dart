import 'package:dukan_scan/providers/home_screen_provider.dart';
import 'package:dukan_scan/responsive/screen_responsive.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';

class HomePageRowWiseBox extends StatelessWidget {
  final HomeScreenProvider provider;
  const HomePageRowWiseBox({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => provider.changeNavIndex(1),
            child: Container(
              height: ScreenResponsive.getValue(
                context,
                mobile: 100.h,
                tablet: 120.h,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: const Color(0xFFE5A922),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Naya Bill',
                    style: TextStyle(
                      color: const Color(0xFF1E293B),
                      fontSize: ScreenResponsive.getValue(
                        context,
                        mobile: 18.sp,
                        tablet: 22.sp,
                      ),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Scan shuru karein',
                    style: TextStyle(
                      color: const Color(0xFF1E293B).withValues(alpha: 0.8),
                      fontSize: ScreenResponsive.getValue(
                        context,
                        mobile: 12.sp,
                        tablet: 15.sp,
                      ),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        SizedBox(width: 16.w),
        Expanded(
          child: GestureDetector(
            onTap: () => provider.changeNavIndex(2),
            child: Container(
              height: ScreenResponsive.getValue(
                context,
                mobile: 100.h,
                tablet: 120.h,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Products',
                    style: TextStyle(
                      color: const Color(0xFF1E293B),
                      fontSize: ScreenResponsive.getValue(
                        context,
                        mobile: 18.sp,
                        tablet: 22.sp,
                      ),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${provider.totalProductsCounts} items',
                    style: TextStyle(
                      color: const Color(0xFF64748B),
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
            ),
          ),
        ),
      ],
    );
  }
}
