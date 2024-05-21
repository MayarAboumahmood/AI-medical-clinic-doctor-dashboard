import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/app_string/app_string.dart';

Widget buildimageSourcesBottomSheet(BuildContext context,
    {required Future<void> Function(ImageSource source, BuildContext context)
        pickImage}) {
  return Container(
    color: customColors.secondaryBackGround,
    height: responsiveUtil.screenHeight * .35,
    child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          choosePhotoSource(
            context: context,
            title: AppString.chooseSource.tr(),
            textColor: customColors.secondaryText,
          ),
          const SizedBox(
            height: 15,
          ),
          choosePhotoSource(
              context: context,
              title: AppString.gallery.tr(),
              onPress: () {
                pickImage(ImageSource.gallery, context);

                navigationService.goBack();
              }),
          const SizedBox(
            height: 15,
          ),
          choosePhotoSource(
              context: context,
              title: AppString.camera.tr(),
              onPress: () {
                pickImage(ImageSource.camera, context);
                navigationService.goBack();
              })
        ]),
  );
}

Widget choosePhotoSource(
    {required BuildContext context,
    required String title,
    Color? textColor,
    Function()? onPress}) {
  return Container(
    width: double.infinity,
    height: 50,
    decoration: BoxDecoration(
      color: customColors.secondaryBackGround,
    ),
    child: Center(
      child: InkWell(
        onTap: onPress,
        child: Text(
          title,
          style: customTextStyle.bodyMedium.copyWith(
              fontFamily: 'Readex Pro',
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: customColors.primaryText),
        ),
      ),
    ),
  );
}
