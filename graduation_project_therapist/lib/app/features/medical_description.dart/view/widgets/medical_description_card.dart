import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/features/medical_description.dart/data_source/models/all_medical_records_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/medical_description.dart/data_source/models/medical_description_arguments.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Widget medicalDescriptionCard(
    AllMedicalRecordsModel medicalDescriptions, int patientID) {
  String formattedDate = 'Unkown'.tr();
  try {
    formattedDate =
        DateFormat('yyyy-MM-dd hh:mm a').format(medicalDescriptions.createdAt);
  } catch (e) {
    debugPrint('con not reformate the date time.');
  }
  return GestureDetector(
    onTap: () {
      print('the medical record id: ${medicalDescriptions.id}');
      navigationService.navigateTo(medicalDescriptionDetails,
          arguments: MedicalDetailsArgs(
              medicalDescriptionId: medicalDescriptions.id,
              patientID: patientID,
              patientName: medicalDescriptions.patientName));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: SizedBox(
        width: responsiveUtil.screenWidth,
        child: Card(
          elevation: 10,
          color: customColors.primaryBackGround,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${'Patient:'.tr()} ${medicalDescriptions.patientName}',
                  style: customTextStyle.bodyLarge,
                ),
                SizedBox(height: 8), // Add space between texts
                Text(
                  '${'Doctor:'.tr()} ${medicalDescriptions.doctorUsername}',
                  style: customTextStyle.bodyLarge,
                ),
                SizedBox(height: 8), // Add space between texts
                Text(
                  '${'Date:'.tr()} ${formattedDate}',
                  style: customTextStyle.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
