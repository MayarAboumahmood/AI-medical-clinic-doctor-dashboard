import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_string/app_string.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/bloc/profile_event.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:image_picker/image_picker.dart';

Widget buildimageSourcesBottomSheetForEditProfile(BuildContext context) {
  return Container(
    color: customColors.secondaryBackGround,
    height: responsiveUtil.screenHeight*.35,
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
              title: AppString.gallery,
              onPress: () {
                BlocProvider.of<ProfileBloc>(context).add(
                    const SetPictureProfileEditeProfile(
                        imageSource: ImageSource.gallery));
                navigationService.goBack();
              }),
          const SizedBox(
            height: 15,
          ),
          choosePhotoSource(
              context: context,
              title: AppString.camera,
              onPress: () {
                BlocProvider.of<ProfileBloc>(context).add(
                    const SetPictureProfileEditeProfile(
                        imageSource: ImageSource.camera));
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
          title.tr(),
          style: customTextStyle.bodyMedium.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: customColors.primaryText),
        ),
      ),
    ),
  );
}
