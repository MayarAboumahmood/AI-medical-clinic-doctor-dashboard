import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

// ignore: must_be_immutable
class AnimationAppBarTitle extends StatelessWidget {
  late AnimationController aController;
  late Animation<double> animationForA;
  String title;
  AnimationAppBarTitle({
    Key? key,
    required this.title,
  }) : super(key: key);
  double theNumber = 1;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      builder: (BuildContext context, double theValForTheTween, child) {
        return Opacity(
          opacity: theValForTheTween,
          child: Padding(
            padding: EdgeInsets.only(top: theValForTheTween * 20, bottom: 20),
            child: child,
          ),
        );
      },
      tween: Tween<double>(begin: 0, end: theNumber),
      duration: const Duration(seconds: 1),
      child: Text(
        title.tr(),
        style: customTextStyle.bodyMedium.copyWith(
            color: customColors.primary,
            fontSize: 22,
            fontWeight: FontWeight.bold),
      ),
      onEnd: () {
        theNumber == 1 ? 0 : 1;
      },
    );
  }
}
