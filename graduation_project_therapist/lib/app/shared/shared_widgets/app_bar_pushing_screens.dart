import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/animation_title.dart';
import '../../../main.dart';

PreferredSize appBarPushingScreens(String title,
    {bool isFromScaffold = false,
    bool showSearchIcon = false,
    VoidCallback? onSearchIconPressed, Widget optionMenu=const SizedBox()}) {
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
          actions: [
            showSearchIcon
                ? IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: onSearchIconPressed,
                  )
                : const SizedBox(),
                optionMenu
          ]),
    ),
  );
}

PreferredSizeWidget appBarPushingScreensForSearch(
  String title, {
  bool isFromScaffold = false,
  bool isSearching = false,
  TextEditingController? searchController,
  VoidCallback? onSearchIconPressed,
  VoidCallback? onSearchCanceled,
  void Function(String)? onSearchChange,
}) {
  double sizeOnHeight = isFromScaffold ? 0 : 100;
  return PreferredSize(
    preferredSize: Size.fromHeight(kToolbarHeight + sizeOnHeight),
    child: Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black38, offset: Offset(0, 2.0), blurRadius: 4.0)
      ]),
      child: AppBar(
        surfaceTintColor: customColors.primaryBackGround,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: customColors.text2,
        ),
        backgroundColor: customColors.primaryBackGround,
        title: isSearching
            ? TextField(
                onChanged: onSearchChange,
                decoration: InputDecoration(
                  hintText: 'Search...'.tr(),
                  hintStyle: customTextStyle.bodyMedium,
                  border: InputBorder.none,
                ),
                style: customTextStyle.bodyMedium)
            : AnimationAppBarTitle(title: title),
        centerTitle: true,
        actions: isSearching
            ? [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onSearchCanceled,
                ),
              ]
            : [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: onSearchIconPressed,
                ),
              ],
      ),
    ),
  );
}
