import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/view/widgets/welcome_screen_widget.dart/build_buttons.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

import '../../widgets/welcome_screen_widget.dart/build_language_icon.dart';
import '../../widgets/welcome_screen_widget.dart/build_logo.dart';
import '../../widgets/welcome_screen_widget.dart/build_page_indecator.dart';
import '../../widgets/welcome_screen_widget.dart/build_page_view.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final PageController controller =
      PageController(viewportFraction: 1, keepPage: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: customColors.primaryBackGround,
        body: _buildPageBody(context));
  }

  Widget _buildPageBody(BuildContext context) {
    return Stack(
      children: [
        buildPageView(context, controller),
        buildLogo(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
              child: Stack(
            children: [
              buildPageIndicator(controller),
              buildLanguageIcon(context),
              buildButtons(context)
            ],
          )),
        ),
      ],
    );
  }
}
