import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';

Widget buildFilterChip(
  BuildContext context, {
  required String label,
  required bool isSelected,
  bool isAlertChip = false,
  required VoidCallback onTap,
}) {
  Color bgColor = Colors.white;
  Color textColor = const Color(0xFF475569);
  Color borderColor = const Color(0xFFE2E8F0);

  if (isSelected) {
    bgColor = isAlertChip ? const Color(0xFFB91C1C) : const Color(0xFF0C7A43);
    textColor = Colors.white;
    borderColor = bgColor;
  } else if (isAlertChip) {
    textColor = const Color(0xFFB91C1C);
    borderColor = const Color(0xFFFECACA);
  }

  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(22.r),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: borderColor, width: 1.2),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    ),
  );
}
