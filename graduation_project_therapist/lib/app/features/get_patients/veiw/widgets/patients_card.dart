import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_patients/data_source/models/get_patients_model.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/image_widgets/network_image.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/expanded_description.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Widget patientsCard(BuildContext context, GetPatientsModel getPatientsModel
    ) {
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
          buildTherapistNameAndImage(getPatientsModel),
          const SizedBox(height: 16),
          expandedDescription(
              context, getPatientsModel.specialistProfile.specInfo,
              backGroundColor: Colors.transparent),
          const SizedBox(height: 16),
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
                ],
              ),
            ),
          ),
        ),
      ));
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

GestureDetector buildTherapistNameAndImage(GetPatientsModel getTherapistModel) {
  return GestureDetector(
    onTap: () {
      // navigationService.navigateTo(userProfilePage,
      //     arguments: getTherapistModel.id);
    },
    child: Row(
      children: [
        Container(
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: getImageNetwork(
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
