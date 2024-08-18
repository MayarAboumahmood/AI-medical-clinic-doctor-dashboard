import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_string/app_string.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/bloc/register_cubit/register_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/bloc/register_cubit/register_state.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/show_date_picker_widget.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/image_widgets/pic_picture_sheet.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/view/widgets/pick_day_conainer.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/get_status_request_from_status_code.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../shared/shared_functions/show_bottom_sheet.dart';

import '../../widgets/steps_widget/app_bar_steps.dart';
import '../../widgets/steps_widget/navigat_button.dart';
import '../../widgets/steps_widget/riched_text.dart';

Uint8List? imageBytes;

bool isLoading = false;

class SelectImageAndDateRegisterStep extends StatelessWidget {
  const SelectImageAndDateRegisterStep({super.key});
  @override
  Widget build(BuildContext context) {
    RegisterCubit registerCubit = context.read<RegisterCubit>();

    return BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
      if (state is RegisterSuccessRequestWithoutOTP) {
        navigationService.navigateTo(oTPCodeStep);
        customSnackBar(
            'We send the otp code to: ${registerCubit.userInfo.userEmail}',
            context);
      } else if (state is RegisterServerErrorRequest) {
        customSnackBar(getMessageFromStatus(state.statusRequest), context);
      } else if (state is RegisterFailureState) {
        customSnackBar(state.errorMessage, context);
      }
    }, builder: (context, state) {
      if (state is RegisterProfilePictureUpdated) {
        imageBytes = state.imageBytes;
      }
      isLoading = state is RegisterLoadingState;
      return Scaffold(
          backgroundColor: customColors.primaryBackGround,
          appBar: buildAppBarWithLineIndicatorincenter(3, context),
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
          richedTextSteps(context, 3),
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
          addImageContainer(context, imageBytes),
          Container(
            alignment: Alignment.center,
            margin:
                EdgeInsets.symmetric(vertical: responsiveUtil.scaleHeight(50)),
            child: InkWell(
              onTap: () async {
                await showBottomSheetWidget(
                    context,
                    buildimageSourcesBottomSheet(context,
                        pickImage: pickImage));
              },
              child: Text(AppString.addCustomPhoto.tr(),
                  textAlign: TextAlign.center,
                  style: customTextStyle.bodyMedium
                      .copyWith(fontWeight: FontWeight.w500)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          PickDayContainer(
            whatBlocShouldDoOnTap: (selectedDate) {
              BlocProvider.of<RegisterCubit>(context)
                  .updateUserInfo(dateOfBirth: selectedDate);
            },
            datePickType: DatePickType.birthDay
          ),
          SizedBox(
            height: responsiveUtil.screenHeight * .035,
          ),
          navigateButton(() async {
            Uint8List? imageList =
                BlocProvider.of<RegisterCubit>(context).selectedImage;
            if (imageList != null) {
              BlocProvider.of<RegisterCubit>(context).sendRegisterRequest();
            } else {
              customSnackBar('You have to choos an image', context);
            }
          }, AppString.continueButton.tr(), isLoading)
        ],
      ),
    );
  }

  Future<void> pickImage(ImageSource source, BuildContext context) async {
    RegisterCubit registerCubit = context.read<RegisterCubit>();
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      final Uint8List imageBytes = await image.readAsBytes();
      registerCubit.setImage(imageBytes, image.name);
    }
  }

  Widget addImageContainer(
    BuildContext context,
    Uint8List? imageBytes,
  ) {
    return GestureDetector(
        onTap: () async {
          await showBottomSheetWidget(context,
              buildimageSourcesBottomSheet(context, pickImage: pickImage));
        },
        child: imageBytes != null
            ? CircleAvatar(
                radius: 60,
                backgroundImage: MemoryImage(imageBytes),
              )
            : Container(
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
              ));
  }
}
