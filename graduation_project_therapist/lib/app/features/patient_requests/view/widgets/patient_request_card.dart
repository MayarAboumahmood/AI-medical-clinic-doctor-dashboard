import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/data_source/models/user_request_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/view/screens/patient_requests_page.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/view/widgets/select_time_date_bottomsheet.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/show_bottom_sheet.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/image_widgets/network_image.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/expanded_description.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Widget patientRequestCard(
    BuildContext context, PatientRequestModel patientRequestModel) {
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
          buildUserNameAndImage(patientRequestModel),
          const SizedBox(height: 16),
          expandedDescription(context, patientRequestModel.userInfo,
              backGroundColor: Colors.transparent),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GeneralButtonOptions(
                  text: "Accept".tr(),
                  onPressed: () async {
                    await showBottomSheetWidget(
                        context,
                        SelectTimeDateBottomSheet(
                            requestID: patientRequestModel.id));
                  },
                  options: ButtonOptions(
                      color: customColors.primary,
                      textStyle: customTextStyle.bodyMedium
                          .copyWith(color: Colors.white))),
              const SizedBox(width: 8),
              rejectButton(context, patientRequestModel.id),
            ],
          ),
        ],
      ),
    ),
  );
}

GestureDetector buildUserNameAndImage(PatientRequestModel patientRequestModel) {
  return GestureDetector(
    onTap: () {
      navigationService.navigateTo(userProfilePage,
          arguments: patientRequestModel.id);
    },
    child: Row(
      children: [
        Container(
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: getImageNetwork(
                url: patientRequestModel.userImage,
                width: 65,
                height: 65,
                fit: BoxFit.cover),
          ),
        ),
        const SizedBox(width: 16),
        Text(patientRequestModel.userName, style: customTextStyle.bodyLarge),
      ],
    ),
  );
}

GeneralButtonOptions rejectButton(BuildContext context, int requestID) {
  return GeneralButtonOptions(
    text: 'Reject'.tr(),
    options: ButtonOptions(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: customColors.error,
        width: 1,
      ),
      color: customColors.primaryBackGround,
      textStyle: customTextStyle.bodyMedium.copyWith(color: customColors.error),
    ),
    onPressed: () async {
      await showBottomSheetWidget(
          context, buildRejectPatientRequestBottomSheet(context, requestID));
    },
  );
}

Widget buildRejectPatientRequestBottomSheet(
    BuildContext context, int requestID) {
  return Container(
    padding: const EdgeInsets.all(20),
    height: 160,
    decoration: BoxDecoration(
      color: customColors.primaryBackGround,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Are you sure you want to reject this request?'.tr(),
            style: customTextStyle.bodyMedium),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(customColors.primary),
              ),
              onPressed: () {
                patientRequestsCubit.rejectPatientRequest(requestID);
                navigationService.goBack();
              },
              child: Text(
                'Yes'.tr(),
                style: customTextStyle.bodyMedium,
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(customColors.error),
              ),
              onPressed: () {
                // Handle Reject Action
                Navigator.pop(context); // Close the bottom sheet
              },
              child: Text(
                'No'.tr(),
                style: customTextStyle.bodyMedium,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
