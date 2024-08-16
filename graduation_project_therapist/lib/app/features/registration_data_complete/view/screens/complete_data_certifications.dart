import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/view/widgets/steps_widget/navigat_button.dart';
import 'package:graduation_project_therapist_dashboard/app/features/home_page/data_source/models/user_status_enum.dart';
import 'package:graduation_project_therapist_dashboard/app/features/registration_data_complete/cubit/registration_data_complete_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/registration_data_complete/view/widgets/pic_pichter_bottom_sheet_complete_certifications.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/show_bottom_sheet.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class CompleteCertificationsPage extends StatelessWidget {
  const CompleteCertificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationDataCompleteCubit,
        RegistrationDataCompleteState>(
      listener: (context, state) {
        print('state in the complete data register: $state');
        if (state is RegistrationDataCompleteDoneSuccseflyState) {
          navigationService.navigationOfAllPagesToName(
              context, bottomNavigationBar);
          customSnackBar(
              'we recived your requiest, we will let you know the result soon',
              context,
              isFloating: true);
          userStatus = UserStatusEnum.pending;
        } else if (state is RegistrationDataCompleteFailureState) {
          customSnackBar(state.errorMessage, context);
        }
      },
      child: Scaffold(
          backgroundColor: customColors.primaryBackGround,
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [buildCompleteYourCertificationsBody(context)],
            ),
          )),
    );
  }

  Widget buildCompleteYourCertificationsBody(BuildContext context) {
    RegistrationDataCompleteCubit registrationDataCompleteCubit =
        context.read<RegistrationDataCompleteCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: responsiveUtil.screenHeight * .04,
          horizontal: responsiveUtil.screenWidth * .04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: responsiveUtil.padding(
                responsiveUtil.screenWidth * .012, 0, 0, 0),
            child: Text(
              'Add the Certifications That only the admin can see'.tr(),
              textAlign: TextAlign.center,
              style: customTextStyle.bodyMedium.copyWith(
                fontSize: 14,
                letterSpacing: 0.2,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          SizedBox(
            height: responsiveUtil.screenHeight * .05,
          ),
          blocSelectorListViewOfImages(context),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () async {
              await showBottomSheetWidget(
                context,
                buildimageSourcesBottomSheetCompleteCertifications(context),
              );
            },
            child: Text(
              'Add Certifications images'.tr(),
              style: customTextStyle.bodyMedium,
            ),
          ),
          SizedBox(
            height: responsiveUtil.screenHeight * .3,
          ),
          BlocBuilder<RegistrationDataCompleteCubit,
              RegistrationDataCompleteState>(
            builder: (context, state) {
              final bool isLoading =
                  state is RegistrationDataCompleteLoadingState;

              return navigateButton(() {
                if (registrationDataCompleteCubit
                    .certificationImages.isNotEmpty) {
                  registrationDataCompleteCubit.submitteUserData();
                } else {
                  customSnackBar(
                      'Opps! You have to add certifications', context);
                }
              }, "submite".tr(), isLoading);
            },
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  BlocBuilder<RegistrationDataCompleteCubit, RegistrationDataCompleteState>
      blocSelectorListViewOfImages(BuildContext context) {
    RegistrationDataCompleteCubit registrationDataCompleteCubit =
        context.read<RegistrationDataCompleteCubit>();
    return BlocBuilder<RegistrationDataCompleteCubit,
        RegistrationDataCompleteState>(
      builder: (context, state) {
        List<Uint8List> certificationImages = [];
        if (state is RegistrationDataCompleteImagesUpdated) {
          certificationImages = state.certificationImages;
        }
        if (certificationImages.isNotEmpty) {
          return listviewOfImages(certificationImages);
        } else if (registrationDataCompleteCubit
            .certificationImages.isNotEmpty) {
          return listviewOfImages(
              registrationDataCompleteCubit.certificationImages);
        } else {
          // Returning an empty widget when there are no images.
          return const SizedBox();
        }
      },
    );
  }

  SizedBox listviewOfImages(List<Uint8List> certificationImages) {
    return SizedBox(
      height: responsiveUtil.screenHeight * .2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: certificationImages.length,
        itemBuilder: (context, index) {
          final imagePath = certificationImages[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.memory(imagePath, width: 100, height: 100),
          );
        },
      ),
    );
  }
}
