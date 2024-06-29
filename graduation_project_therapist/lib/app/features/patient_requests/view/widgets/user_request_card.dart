import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/data_source/models/user_request_model.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/expanded_description.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Widget userRequestCard(
    BuildContext context, PatientRequestModel patientRequestModel) {
  return Card(
    color: customColors.primaryBackGround,
    elevation: 4,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // CircleAvatar(
              //   radius: 24,
              //   backgroundImage: NetworkImage('patientRequestModel.userImage'),
              // ),
              // const SizedBox(width: 16),
              Text(patientRequestModel.patientName,
                  style: customTextStyle.bodyLarge),
            ],
          ),
          const SizedBox(height: 16),
          expandedDescription(context, patientRequestModel.description,
              backGroundColor: customColors.secondaryBackGround),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GeneralButtonOptions(
                  text: "Accept".tr(),
                  onPressed: () {},
                  options: ButtonOptions(
                      color: customColors.primary,
                      textStyle: customTextStyle.bodyMedium
                          .copyWith(color: Colors.white))),
              const SizedBox(width: 8),
              rejectButton(),
            ],
          ),
        ],
      ),
    ),
  );
}

GeneralButtonOptions rejectButton() {
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
    onPressed: () {
      navigationService.goBack(); // Just close the dialog
    },
  );
}
