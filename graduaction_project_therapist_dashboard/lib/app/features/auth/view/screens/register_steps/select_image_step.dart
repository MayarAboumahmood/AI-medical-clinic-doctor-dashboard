import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_string/app_string.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/bloc/register_cubit/register_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/view/widgets/steps_widget/pic_picture_sheet.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

import '../../../../../shared/shared_functions/show_bottom_sheet.dart';

import '../../widgets/steps_widget/app_bar_steps.dart';
import '../../widgets/steps_widget/navigat_button.dart';
import '../../widgets/steps_widget/riched_text.dart';

Uint8List? imageBytes;

class SelectImageRegisterStep extends StatelessWidget {
  const SelectImageRegisterStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
        listener: (ccontext, state) {},
        builder: (context, state) {
          if (state is RegisterProfilePictureUpdated) {
            imageBytes = state.imageBytes;
          }

          return Scaffold(
              backgroundColor: customColors.primaryBackGround,
              appBar: buildAppBarWithLineIndicatorincenter(4, context),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [buildSelectImageBody(context, imageBytes)],
                ),
              ));
        });
  }

  Widget buildSelectImageBody(context, pictureProfile) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: responsiveUtil.screenHeight * .04,
          horizontal: responsiveUtil.screenWidth * .04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          richedTextSteps(context, 4),
          Padding(
            padding: EdgeInsets.only(top: responsiveUtil.screenWidth * .08),
            child: Text(
              AppString.profilePicture.tr(),
              textAlign: TextAlign.center,
              style: customTextStyle.bodyMedium.copyWith(
                fontSize: 14,
                letterSpacing: 0.2,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          addImageContainer(imageBytes),
          Container(
            alignment: Alignment.center,
            margin:
                EdgeInsets.symmetric(vertical: responsiveUtil.scaleHeight(50)),
            child: InkWell(
              onTap: () async {
                await showBottomSheetWidget(
                    context, buildimageSourcesBottomSheet(context));
              },
              child: Text(AppString.addCustomPhoto.tr(),
                  textAlign: TextAlign.center,
                  style: customTextStyle.bodyMedium
                      .copyWith(fontWeight: FontWeight.w500)),
            ),
          ),
          SizedBox(
            height: responsiveUtil.screenHeight * .055,
          ),
          navigateButton(() async {
            Uint8List? imageList =
                BlocProvider.of<RegisterCubit>(context).selectedImage;
            if (imageList != null) {
              navigationService.navigateTo(bottomNavigationBar);
            } else {
              customSnackBar('You have to choos an image', context);
            }
          }, AppString.continueButton.tr(), false)
        ],
      ),
    );
  }

  Widget addImageContainer(Uint8List? imageBytes) {
    if (imageBytes != null) {
      return CircleAvatar(
        radius: 60,
        backgroundImage: MemoryImage(imageBytes),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: customColors.primary)),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Icon(
            size: 45,
            Icons.add_a_photo,
            color: customColors.secondaryBackGround,
          ),
        ),
      );
    }
  }
}
