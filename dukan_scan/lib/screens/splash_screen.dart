import 'package:dukan_scan/providers/splash_screen_provider.dart';
import 'package:dukan_scan/responsive/screen_responsive.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SplashProvider>();
    final bool isLastPage =
        provider.currentIndex == provider.onboardingData.length - 1;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F4EA),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenResponsive.getValue(
                  context,
                  mobile: 20.w,
                  tablet: 32.w,
                ),
                vertical: 12.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0C7A43),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.qr_code_scanner_rounded,
                          color: const Color(0xFFE5A922),
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'DukaanScan',
                        style: TextStyle(
                          fontSize: ScreenResponsive.getValue(
                            context,
                            mobile: 18.sp,
                            tablet: 22.sp,
                          ),
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0C7A43),
                        ),
                      ),
                    ],
                  ),
                  if (!isLastPage)
                    TextButton(
                      onPressed: () => provider.goToSignUp(context),
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: ScreenResponsive.getValue(
                            context,
                            mobile: 14.sp,
                            tablet: 18.sp,
                          ),
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: provider.pageController,
                itemCount: provider.onboardingData.length,
                onPageChanged: provider.onPageChanged,
                itemBuilder: (context, index) {
                  final item = provider.onboardingData[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenResponsive.getValue(
                        context,
                        mobile: 28.w,
                        tablet: 60.w,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: ScreenResponsive.getValue(
                            context,
                            mobile: 250.w,
                            tablet: 320.w,
                          ),
                          height: ScreenResponsive.getValue(
                            context,
                            mobile: 250.w,
                            tablet: 320.w,
                          ),
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF0C7A43)
                                    .withValues(alpha: 0.08),
                                blurRadius: 24,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Lottie.asset(
                            item['animation']!,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: ScreenResponsive.getValue(
                            context,
                            mobile: 36.h,
                            tablet: 44.h,
                          ),
                        ),
                        Text(
                          item['title']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: ScreenResponsive.getValue(
                              context,
                              mobile: 24.sp,
                              tablet: 30.sp,
                            ),
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          item['subtitle']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: ScreenResponsive.getValue(
                              context,
                              mobile: 14.sp,
                              tablet: 18.sp,
                            ),
                            color: const Color(0xFF64748B),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenResponsive.getValue(
                  context,
                  mobile: 24.w,
                  tablet: 48.w,
                ),
                vertical: ScreenResponsive.getValue(
                  context,
                  mobile: 28.h,
                  tablet: 36.h,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(provider.onboardingData.length, (
                      index,
                    ) {
                      final bool isActive = provider.currentIndex == index;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: EdgeInsets.only(right: 8.w),
                        height: 10.h,
                        width: isActive ? 28.w : 10.w,
                        decoration: BoxDecoration(
                          color: isActive
                              ? const Color(0xFF0C7A43)
                              : const Color(0xFFCBD5E1),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    height: ScreenResponsive.getValue(
                      context,
                      mobile: 50.h,
                      tablet: 58.h,
                    ),
                    child: ElevatedButton(
                      onPressed: () => provider.nextPage(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isLastPage
                            ? const Color(0xFFE5A922)
                            : const Color(0xFF0C7A43),
                        foregroundColor: isLastPage
                            ? const Color(0xFF0F172A)
                            : Colors.white,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            isLastPage ? 'Shuru Karein' : 'Next',
                            style: TextStyle(
                              fontSize: ScreenResponsive.getValue(
                                context,
                                mobile: 15.sp,
                                tablet: 18.sp,
                              ),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Icon(Icons.arrow_forward_rounded, size: 20.sp),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
