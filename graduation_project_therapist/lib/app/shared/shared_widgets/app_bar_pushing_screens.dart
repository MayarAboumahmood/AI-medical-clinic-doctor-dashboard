import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/animation_title.dart';
import '../../../main.dart';

PreferredSize appBarPushingScreens(String title,
    {bool isFromScaffold = false}) {
  double sizeOnheight = isFromScaffold ? 0 : 100;
  return PreferredSize(
    preferredSize: Size.fromHeight(
        kToolbarHeight + sizeOnheight), // Adjust the height as needed
    child: Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black38, offset: Offset(0, 2.0), blurRadius: 4.0)
      ]),
      child: AppBar(
        surfaceTintColor: customColors.primaryBackGround,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: customColors
              .text2, //to change the defalt icon color in the appbar.
        ),
        backgroundColor: customColors.primaryBackGround,
        title: AnimationAppBarTitle(title: title),
        centerTitle: true,
      ),
    ),
  );
}

PreferredSize appBarPushingScreensWithSearch(
    String title, BuildContext context) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(
        kToolbarHeight + 100), // Adjust the height as needed

    child: Column(
      children: [
        Container(
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black38, offset: Offset(0, 2.0), blurRadius: 4.0)
          ]),
          child: AppBar(
            surfaceTintColor: customColors.primaryBackGround,
            backgroundColor: customColors.primaryBackGround,
            title: Text(
              title.tr(),
              style: customTextStyle.bodyMedium.copyWith(
                  color: customColors.primaryText,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            leading: GestureDetector(
                onTap: () {
                  navigationService.goBack();
                },
                child: Icon(
                  Icons.arrow_back_outlined,
                  color: customColors.primaryText,
                  size: 30,
                )),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          height: 70,
          child: TextField(
            cursorColor: customColors.secondaryText,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: customColors
                        .primaryBackGround, // Same color as border to prevent color change on focus
                  ),
                ),
                filled: true,
                fillColor: customColors.secondaryBackGround,
                hintText: 'Search...'.tr(),
                hintStyle: customTextStyle.bodyMedium
                    .copyWith(color: customColors.secondaryText),
                prefixIcon: Icon(
                  Icons.search,
                  color: customColors.secondaryText,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                )),
          ),
        )
      ],
    ),
  );
}
