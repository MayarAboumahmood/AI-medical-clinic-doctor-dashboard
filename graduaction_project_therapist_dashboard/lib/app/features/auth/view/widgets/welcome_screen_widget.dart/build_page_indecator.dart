import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../../main.dart';

Widget buildPageIndicator(PageController controller) {
  return Align(
    alignment: AlignmentDirectional(
        0.00, responsiveUtil.screenHeight < 660 ? 0.55 : 0.5),
    child: SmoothPageIndicator(
      controller: controller,
      count: 3,
      axisDirection: Axis.horizontal,
      onDotClicked: (i) async {
        await controller.animateToPage(
          i,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      },
      effect: ExpandingDotsEffect(
        expansionFactor: 3,
        spacing: 8,
        radius: 16,
        dotWidth: 5,
        dotHeight: 8,
        dotColor: const Color(0xA9FFFFFF),
        activeDotColor: customColors.info,
        paintStyle: PaintingStyle.fill,
      ),
    ),
  );
}
