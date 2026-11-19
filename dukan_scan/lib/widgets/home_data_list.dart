import 'package:dukan_scan/providers/home_screen_provider.dart';
import 'package:dukan_scan/responsive/screen_responsive.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';

class HomeDataList extends StatelessWidget {
  final HomeScreenProvider provider;
  const HomeDataList({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Stock kam ha',
            style: TextStyle(
              color: Colors.black,
              fontWeight: .bold,
              fontSize: ScreenResponsive.getValue(
                context,
                mobile: 16.sp,
                tablet: 22.sp,
              ),
            ),
          ),

          SizedBox(height: 15.h),
          if (provider.lowStockItems.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Center(
                child: Text(
                  'No content',
                  style: TextStyle(
                    fontSize: ScreenResponsive.getValue(
                      context,
                      mobile: 14.sp,
                      tablet: 16.sp,
                    ),
                    color: const Color(0xFF94A3B8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          else
            ...List.generate(provider.lowStockItems.length, (index) {
              final item = provider.lowStockItems[index];
              final bool isLast = index == provider.lowStockItems.length - 1;
              return _buildStockItem(
                context,
                name: item['name'],
                count: '${item['count']} bacha',
                isLast: isLast,
              );
            }),
        ],
      ),
    );
  }
}

Widget _buildStockItem(
  BuildContext context, {
  required String name,
  required String count,
  bool isLast = false,
}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 14.h),
    decoration: BoxDecoration(
      border: isLast
          ? null
          : const Border(
              bottom: BorderSide(color: Color(0xFFF1F5F9), width: 1.2),
            ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: ScreenResponsive.getValue(
                context,
                mobile: 15.sp,
                tablet: 18.sp,
              ),
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          count,
          style: TextStyle(
            fontSize: ScreenResponsive.getValue(
              context,
              mobile: 14.sp,
              tablet: 17.sp,
            ),
            fontWeight: FontWeight.bold,
            color: const Color(0xFFC2410C),
          ),
        ),
      ],
    ),
  );
}
