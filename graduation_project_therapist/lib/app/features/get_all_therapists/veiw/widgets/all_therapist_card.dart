import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/cubit/get_all_therapist_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/cubit/get_all_therapist_state.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/data_source/models/get_therapists_model.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/show_bottom_sheet.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/image_widgets/network_image.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/expanded_description.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Widget allTherapistCard(BuildContext context,
    GetTherapistModel getTherapistModel, bool isGetAllTherapist) {
  GetAllTherapistCubit getAllTherapistCubit =
      context.read<GetAllTherapistCubit>();
  print(
      'ssssssssssssssssssssssssssssssssssss: employmentRequests: ${getTherapistModel.employmentRequests}');
  return Card(
    color: customColors.primaryBackGround,
    elevation: 4,
    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTherapistNameAndImage(getTherapistModel),
          const SizedBox(height: 16),
          expandedDescription(
              context, getTherapistModel.specialistProfile.specInfo,
              backGroundColor: Colors.transparent),
          const SizedBox(height: 16),
          Row(
            children: [
              BlocBuilder<GetAllTherapistCubit, GetAllTherapistState>(
                builder: (context, state) {
                  int therapistId = getAllTherapistCubit.therapistId ?? -10;
                  bool shouldShowAssignButton =
                      getTherapistModel.employmentRequests;
                  bool isLoading = isGetAllTherapist
                      ? (state is AssignTherapistLoadingState) &&
                          (therapistId == getTherapistModel.id)
                      : (state is RemoveTherapistLoadingState) &&
                          (therapistId == getTherapistModel.id);

                  return shouldShowAssignButton
                      ? Text('Padding'.tr(), style: customTextStyle.bodyMedium)
                      : GeneralButtonOptions(
                          text:
                              isGetAllTherapist ? "Assign".tr() : 'Remove'.tr(),
                          onPressed: () {
                            if (isGetAllTherapist) {
                              getAllTherapistCubit
                                  .assignTherapist(getTherapistModel.id);
                            } else {
                              showBottomSheetWidget(
                                  context,
                                  removeEmploymentBottomSheet(
                                      context,
                                      getTherapistModel
                                          .specialistProfile.fullName,
                                      getTherapistModel.id));
                            }
                          },
                          loading: isLoading,
                          options: ButtonOptions(
                              color: isGetAllTherapist
                                  ? (getTherapistModel.employmentRequests
                                      ? customColors.primary
                                      : customColors.accent1)
                                  : customColors.error,
                              textStyle: customTextStyle.bodyMedium
                                  .copyWith(color: Colors.white)));
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget removeEmploymentBottomSheet(
    BuildContext context, String employeeName, int therapistId) {
  return SizedBox(
      height: responsiveUtil.screenHeight * .22,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
                color: customColors.primaryBackGround,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                )),
            height: responsiveUtil.screenHeight * .22,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Container(
                      height: 3,
                      width: 40,
                      color: customColors.secondaryBackGround,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                      child: Text(
                    'Are you sure you want to remove $employeeName?'.tr(),
                    style: customTextStyle.bodyLarge
                        .copyWith(fontWeight: FontWeight.w700),
                  )),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      cancelLogOutButton(context),
                      const SizedBox(
                        width: 30,
                      ),
                      removeEmployeeButton(context, therapistId),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ));
}

Widget removeEmployeeButton(BuildContext context, int therapistId) {
  GetAllTherapistCubit getAllTherapistCubit =
      context.read<GetAllTherapistCubit>();

  return BlocBuilder<GetAllTherapistCubit, GetAllTherapistState>(
    builder: (context, state) {
      int localTherapistId = getAllTherapistCubit.therapistId ?? -10;

      bool isLoading = (state is RemoveTherapistLoadingState) &&
          (localTherapistId == therapistId);
      return GeneralButtonOptions(
        text: 'Yes, remove this therapist'.tr(),
        onPressed: () {
          getAllTherapistCubit.removeTherapist(therapistId);
        },
        loading: isLoading,
        options: ButtonOptions(
          height: 40,
          color: customColors.error,
          textStyle: customTextStyle.titleSmall.copyWith(color: Colors.white),
          borderSide: BorderSide(
            color: customColors.error,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      );
    },
  );
}

GeneralButtonOptions cancelLogOutButton(BuildContext context) {
  return GeneralButtonOptions(
    text: 'Cancel'.tr(),
    onPressed: () {
      navigationService.goBack();
    },
    options: ButtonOptions(
      height: 40,
      color: customColors.primaryBackGround,
      textStyle:
          customTextStyle.titleSmall.copyWith(color: customColors.primaryText),
      borderSide: BorderSide(
        color: customColors.primary,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
  );
}

GestureDetector buildTherapistNameAndImage(
    GetTherapistModel getTherapistModel) {
  return GestureDetector(
    onTap: () {},
    child: Row(
      children: [
        Container(
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: getImageNetwork(
                forProfileImage: true,
                url: getTherapistModel.specialistProfile.photo,
                width: 65,
                height: 65,
                fit: BoxFit.cover),
          ),
        ),
        const SizedBox(width: 16),
        Text(getTherapistModel.specialistProfile.fullName,
            style: customTextStyle.bodyLarge),
      ],
    ),
  );
}
