import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/bloc/register_cubit/register_cubit.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/constants/app_string/app_string.dart';

Widget buildimageSourcesBottomSheet(BuildContext context) {
  return Container(
    color: customColors.secondaryBackGround,
    height: responsiveUtil.scaleHeight(200),
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
                pickImage(ImageSource.camera,context); 
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

Future<void> pickImage(ImageSource source, BuildContext context) async {
  final ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(source: source);
  if (image != null) {
    final Uint8List imageBytes = await image.readAsBytes();
    BlocProvider.of<RegisterCubit>(context).setImage(imageBytes);
  }
}
