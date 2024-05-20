import 'package:flutter/widgets.dart';

class ResponsiveUtil {
  final BuildContext context;
  late final double screenWidth;
  late final double screenHeight;
  late final Orientation orientation;

  ResponsiveUtil(this.context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    orientation = MediaQuery.of(context).orientation;
  }
  initResponsiveUtil(BuildContext context){
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    orientation = MediaQuery.of(context).orientation;
  }

  // Base design dimensions, adjust as needed
  static const double baseScreenWidth = 393.0; // Base design screen width (e.g., iPhone X)
  static const double baseScreenHeight = 852.0; // Base design screen height (e.g., iPhone X)

  // Scale size based on screen width
  double scaleWidth(double size) => (size * screenWidth) / baseScreenWidth;

  // Scale size based on screen height
  double scaleHeight(double size) => (size * screenHeight) / baseScreenHeight;

  // Get responsive text size
  double textSize(double fontSize) => (fontSize * screenWidth) / baseScreenWidth;

  // Get responsive padding
  EdgeInsets padding(double top, double right, double bottom, double left) {
    return EdgeInsets.fromLTRB(
      scaleWidth(left),
      scaleHeight(top),
      scaleWidth(right),
      scaleHeight(bottom),
    );
  }

}
