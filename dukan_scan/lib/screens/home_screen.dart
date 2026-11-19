import 'package:dukan_scan/providers/home_screen_provider.dart';
import 'package:dukan_scan/responsive/screen_responsive.dart';
import 'package:dukan_scan/screens/hisaab_screen.dart';
import 'package:dukan_scan/screens/product_screen.dart';
import 'package:dukan_scan/screens/scan_screen.dart';
import 'package:dukan_scan/widgets/home_data_list.dart';
import 'package:dukan_scan/widgets/home_page_green_color_container.dart';
import 'package:dukan_scan/widgets/home_page_row_wise_box.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isTablet = ScreenResponsive.isTablet(context);
    final provider = context.watch<HomeScreenProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F4EA),

      body: IndexedStack(
        index: provider.navIndexes,
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  width: isTablet ? 520.w : double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenResponsive.getValue(
                      context,
                      mobile: 20.w,
                      tablet: 32.w,
                    ),
                    vertical: ScreenResponsive.getValue(
                      context,
                      mobile: 16.h,
                      tablet: 24.h,
                    ),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Aslam O Alikum',
                        style: TextStyle(
                          color: const Color(0xFF64748B),
                          fontSize: ScreenResponsive.getValue(
                            context,
                            mobile: 14.sp,
                            tablet: 18.sp,
                          ),
                        ),
                      ),

                      SizedBox(height: 2.h),
                      Text(
                        provider.shopName,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: .bold,
                          fontSize: ScreenResponsive.getValue(
                            context,
                            mobile: 22.sp,
                            tablet: 26.sp,
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),
                      HomePageGreenColorContainer(provider: provider),
                      SizedBox(height: 16.h),
                      HomePageRowWiseBox(provider: provider),
                      SizedBox(height: 17.h),
                      HomeDataList(provider: provider),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const ScanScreen(),
          const ProductScreen(),
          const HisaabScreen(),
        ],
      ),

      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE2E8F0), width: 1)),
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavItem(
                context,
                provider: provider,
                index: 0,
                label: 'Home',
                icon: Icons.home_rounded,
              ),

              _buildBottomNavItem(
                context,
                provider: provider,
                index: 1,
                label: 'scan',
                icon: Icons.qr_code_scanner_outlined,
              ),

              _buildBottomNavItem(
                context,
                provider: provider,
                index: 2,
                label: 'products',
                icon: Icons.shopping_bag_outlined,
              ),

              _buildBottomNavItem(
                context,
                provider: provider,
                index: 3,
                label: 'Hisaab',
                icon: Icons.history_edu_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildBottomNavItem(
  BuildContext context, {
  required HomeScreenProvider provider,
  required int index,
  required String label,
  required IconData icon,
}) {
  final bool isActive = provider.navIndexes == index;
  final color = isActive ? const Color(0xFF0C7A43) : const Color(0xFF64748B);

  return InkWell(
    onTap: () => provider.changeNavIndex(index),
    child: Padding(
      padding: EdgeInsets.all(4.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: ScreenResponsive.getValue(
              context,
              mobile: 24.sp,
              tablet: 28.sp,
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            label,
            style: TextStyle(
              fontSize: ScreenResponsive.getValue(
                context,
                mobile: 11.sp,
                tablet: 14.sp,
              ),
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    ),
  );
}
