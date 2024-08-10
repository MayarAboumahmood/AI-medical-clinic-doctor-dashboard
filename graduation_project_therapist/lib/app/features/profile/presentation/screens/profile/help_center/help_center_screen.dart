import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/screens/profile/help_center/contact_us.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/screens/profile/help_center/faq.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/app_bar_pushing_screens.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {},
      //   label: poweredByMayar(),
      //   backgroundColor: customColors.primaryBackGround,
      //   elevation: 0,
      // ),
      backgroundColor: customColors.primaryBackGround,
      appBar: appBarPushingScreens('Help Center', isFromScaffold: true),
      body: SafeArea(
        top: true,
        child: DefaultTabController(
          length: 2,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: const Alignment(0, 0),
                      child: TabBar(
                        labelColor: customColors.text2,
                        unselectedLabelColor: customColors.secondaryText,
                        labelStyle: customTextStyle.titleSmall.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        dividerColor: Colors.transparent,
                        unselectedLabelStyle: const TextStyle(),
                        indicator: CustomTabIndicator(
                          thickness: 2,
                          color: customColors.primary,
                          width: responsiveUtil.screenWidth * .49,
                        ),
                        tabs: [
                          Tab(
                            text: "FAQ".tr(),
                          ),
                          Tab(
                            text: "Contact Us".tr(),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                        child: TabBarView(
                      children: [FAQ(), ContactUs()],
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTabIndicator extends Decoration {
  final BoxPainter _painter;

  CustomTabIndicator(
      {required Color color, required double width, required double thickness})
      : _painter = _CustomPainter(color, width, thickness);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _painter;
  }
}

class _CustomPainter extends BoxPainter {
  final Paint _paint;
  final double width;

  _CustomPainter(Color color, this.width, double thickness)
      : _paint = Paint()
          ..color = color
          ..strokeWidth = thickness // Set the thickness here
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Offset customOffset = Offset(
        offset.dx + (configuration.size!.width - width) / 2,
        offset.dy + configuration.size!.height - 2);

    canvas.drawLine(customOffset, customOffset.translate(width, 0), _paint);
  }
}
