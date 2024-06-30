import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/features/medical_description.dart/data_source/models/all_medical_records_model.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Widget medicalDescriptionCard(AllMedicalRecordsModel medicalDescriptions) {
  return GestureDetector(
    onTap: () {
      print('the medical record id: ${medicalDescriptions.id}');
      navigationService.navigateTo(medicalDescriptionDetails,
          arguments: medicalDescriptions.id);
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Card(
        color: customColors.primaryBackGround,
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${'Patient:'.tr()} ${medicalDescriptions.patientName}',
                style: customTextStyle.bodyLarge,
              ),
              Text(
                '${'Doctor:'.tr()} ${medicalDescriptions.doctorUsername}',
                style: customTextStyle.bodyLarge,
              ),
            ],
          ),
          trailing: Text(
            '${'Date:'.tr()} ${medicalDescriptions.createdAt}',
            style: customTextStyle.bodyLarge,
          ),
        ),
      ),
    ),
  );
}
