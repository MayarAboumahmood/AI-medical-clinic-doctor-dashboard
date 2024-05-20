import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/data/model/profile_model.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/build_hero_full_image_page.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/network_image.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

Widget buildImageWithName(String name, BuildContext context) {
  Future<String?> getImagePathFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('user_profile')) return null;

    String userProfileString = prefs.getString('user_profile')!;
    Map<String, dynamic> userJson = json.decode(userProfileString);
    UserData userData = UserData.fromJson(userJson);
    return userData.profilePicture; // Replace 'imagePath' with your actual key
  }

  return Column(
    children: [
      Stack(children: [
        Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: customColors.alternate, // Red border color
                width: 2.0, // Border width
              ),
            ),
            child: Container(
                width: 90,
                height: 90,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: FutureBuilder<String?>(
                  future: getImagePathFromPrefs(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String?> snapshot) {
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
          bottom: 0, // Adjust the position as needed
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
        height: responsiveUtil.scaleHeight(5),
      ),
      Text(
        name,
        style: customTextStyle.bodyLarge.copyWith(
          color: customColors.primary,
          fontSize: 20,
          fontWeight: FontWeight.normal,
        ),
      )
    ],
  );
}
