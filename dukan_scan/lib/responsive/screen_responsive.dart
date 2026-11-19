import 'package:material_ui/material_ui.dart';

class ScreenResponsive {
  static bool isMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width < 600;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= 600;
  }

  static double getValue(
    BuildContext context, {
    required double mobile,
    required double tablet,
  }) {
    if (MediaQuery.of(context).size.width >= 600) {
      return tablet;
    } else {
      return mobile;
    }
  }
}
