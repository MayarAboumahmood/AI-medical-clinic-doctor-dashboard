import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/features/home_page/data_source/models/user_profile_model.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/formate_name.dart';

import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/build_hero_full_image_page.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/image_widgets/network_image.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

Widget buildImageWithName(String name, BuildContext context) {
  Future<String?> getImagePathFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('user_profile')) return null;

    String userProfileString = prefs.getString('user_profile')!;
    Map<String, dynamic> userJson = json.decode(userProfileString);
    UserProfileModel userData = UserProfileModel.fromMap(userJson);
    return userData.photo; // Replace 'imagePath' with your actual key
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      children: [
        Stack(children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: customColors.primary, // Red border color
                  width: 2.0, // Border width
                ),
              ),
              child: Container(
                  width: 120,
                  height: 120,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FutureBuilder<String?>(
                    future: getImagePathFromPrefs(),
                    builder: (BuildContext context,
                        AsyncSnapshot<String?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(); // Or some other placeholder
                      } else if (snapshot.hasData && snapshot.data != null) {
                        String imagePath = snapshot.data!;
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => FullScreenImagePage(
                                    imageName: imagePath, heroTag: imagePath),
                              ),
                            );
                          },
                          child: Hero(
                            tag: imagePath,
                            child: ClipRRect(
                                child: imageLoader(
                                    url: imagePath,
                                    width: responsiveUtil.scaleWidth(80),
                                    height: responsiveUtil.scaleWidth(80),
                                    fit: BoxFit.cover)),
                          ),
                        ); // Or Image.network for online images
                      } else {
                        return const Center(
                          child: Icon(Icons.error),
                        );
                      }
                    },
                  ))),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              padding: responsiveUtil.padding(5, 5, 5, 5),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: customColors.secondaryBackGround),
              child: GestureDetector(
                child: Icon(
                  Icons.edit_outlined,
                  color: customColors.text2,
                  size: 20,
                ),
                onTap: () {
                  navigationService.navigateTo(editProfile);
                },
              ),
            ),
          ),
        ]),
        SizedBox(
          width: responsiveUtil.scaleWidth(6),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formatNameForBackend(name),
                maxLines: 2,
                style: customTextStyle.bodyLarge.copyWith(
                  color: customColors.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                isDoctor ? "Doctor".tr() : "Therapist".tr(),
                maxLines: 2,
                style: customTextStyle.bodyMedium,
              ),
            ],
          ),
        )
      ],
    ),
  );
}
