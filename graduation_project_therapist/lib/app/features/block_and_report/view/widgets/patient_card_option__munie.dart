import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/features/block_and_report/view/widgets/confirm_block_buttonsheet.dart';
import 'package:graduation_project_therapist_dashboard/app/features/block_and_report/view/widgets/report_patient_buttonsheet.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/check_if_rtl.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/show_bottom_sheet.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Widget buildOptionsMenu(
    BuildContext context, int patientID, String patientName) {
  return Padding(
    padding: isRTL(context)
        ? const EdgeInsets.only(bottom: 20, right: 20)
        : const EdgeInsets.only(bottom: 20, left: 20),
    child: PopupMenuButton<String>(
      color: customColors.secondaryBackGround,
      icon: CircleAvatar(
          backgroundColor: customColors.primary,
          child: Icon(
            Icons.more_vert,
            color: customColors.primaryText,
          )),
      onSelected: (value) async {
        if (value == 'block') {
          await showBottomSheetWidget(
              context,
              showConfirmBlockBottomSheet(
                context,
                patientID,
                patientName,
              ));
        } else if (value == 'Report') {
          await showBottomSheetWidget(
              context,
              ReportPatientBottomSheet(
                patientID: patientID,
                patientName: patientName,
              ));
        } else if (value == 'profile') {
          navigationService.navigateTo(userProfilePage, arguments: patientID);
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: 'profile',
            child: patientOptionText('View user profile'),
          ),
          PopupMenuItem<String>(
            value: 'Report',
            child: patientOptionText('Report this patient'),
          ),
          PopupMenuItem<String>(
            value: 'block',
            child: patientOptionText('Block this patient'),
          ),
          // Add more options here if needed
        ];
      },
    ),
  );
}

Widget buildAppbarOptionsMenu(
    BuildContext context, int patientID, String patientName,int medicalDescriptionId) {
  return PopupMenuButton<String>(
    color: customColors.secondaryBackGround,
    icon: CircleAvatar(
        backgroundColor: customColors.primary,
        child: Icon(
          Icons.more_vert,
          color: customColors.primaryText,
        )),
    onSelected: (value) async {
      if (value == 'Report') {
        await showBottomSheetWidget(
            context,
            ReportPatientBottomSheet(
              patientID: patientID,
              patientName: patientName,
              medicalDescriptionId: medicalDescriptionId,
            ));
      } else if (value == 'profile') {
        navigationService.navigateTo(userProfilePage, arguments: patientID);
      }
    },
    itemBuilder: (BuildContext context) {
      return [
        PopupMenuItem<String>(
          value: 'profile',
          child: patientOptionText('View user profile'),
        ),
        PopupMenuItem<String>(
          value: 'Report',
          child: patientOptionText('Report this medical record'),
        ),
      ];
    },
  );
}

Text patientOptionText(String title) => Text(
      title.tr(),
      style: customTextStyle.bodyMedium,
    );
