import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Widget accountChoiceWidget(
    {required String title,
    required IconData icon,
    required Function()? onTap,
    bool isLogout = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        padding: responsiveUtil.padding(0, 15, 0, 15),
        width: double.infinity * .8,
        height: responsiveUtil.scaleHeight(50),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 70,
                color: const Color(0xFC000000),
                offset: Offset(0, responsiveUtil.screenHeight / 1.1),
                spreadRadius: 100,
              )
            ],
            color: customColors.primaryBackGround,
            border: Border.all(color: customColors.secondaryBackGround),
            borderRadius: BorderRadius.circular(12)),
        child: Row(children: [
          SizedBox(
            width: responsiveUtil.scaleWidth(5),
          ),
          Icon(
            icon,
            color: isLogout ? customColors.error : customColors.secondaryText,
            size: 24,
          ),
          SizedBox(
            width: responsiveUtil.scaleWidth(5),
          ),
          Text(
            title,
            style: customTextStyle.bodySmall.copyWith(
                color: isLogout ? customColors.error : customColors.text2),
          ),
          SizedBox(
            width: responsiveUtil.scaleWidth(5),
          ),
          const Spacer(),
          SizedBox(
            width: responsiveUtil.scaleWidth(5),
          ),
          Icon(
            Icons.arrow_forward_ios_outlined,
            color: customColors.secondaryText,
            size: 18,
          ),
        ]),
      ),
    ),
  );
}
