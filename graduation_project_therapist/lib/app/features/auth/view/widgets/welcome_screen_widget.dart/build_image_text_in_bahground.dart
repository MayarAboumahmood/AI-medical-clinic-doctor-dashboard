import 'package:flutter/material.dart';
import '../../../../../core/constants/colors/app_colors.dart';

import '../../../../../../main.dart';

Widget buildTextAndImageInBackGround(
    {required BuildContext context,
    required String title,
    required String smallTitle,
    required String imagePath}) {
  return Stack(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          imagePath,
          width: double.infinity,
          height: responsiveUtil.screenHeight,
          fit: BoxFit.cover,
        ),
      ),
      Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: AppColors.shadow,
              offset: Offset(0, 2),
            )
          ],
        ),
      ),

      Align(
        alignment: const AlignmentDirectional(0.00, 0.40),
        child: Container(
          alignment: Alignment.center,
          height: responsiveUtil.screenHeight * .2,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                title,
                style: customTextStyle.headlineSmall.copyWith(
                    color: customColors.info,
                    fontWeight: FontWeight.w400,
                    fontSize: 25),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(smallTitle,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  // overflow: ,
                  style: customTextStyle.bodyMedium.copyWith(
                      color: customColors.info,
                      fontWeight: FontWeight.w300,
                      fontSize: 18)),
            ],
          ),
        ),
      ),
      //shadow from the bottom
      Container(
        width: responsiveUtil.screenWidth,
        height: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 70,
              color: const Color(0xFC000000),
              offset: Offset(0, responsiveUtil.screenHeight / 1.1),
              spreadRadius: 100,
            )
          ],
        ),
      ),

      Align(
        alignment: const AlignmentDirectional(0, 1),
        child: Container(
          width: double.infinity,
          height: responsiveUtil.screenHeight * 1,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 70,
                color: const Color(0xF3000000),
                offset: Offset(0, -responsiveUtil.screenHeight / 1.1),
                spreadRadius: 100,
              )
            ],
          ),
        ),
      ),
    ],
  );
}
