import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';

class CompleteRegisterModel {
  String? selectedCity;
  List<String> selectedMedicalSpecialty;
  String studiesInfo;
  String? locationInfo;
  String specialtyInfo;
  List<Uint8List?> certificationImages;
  LatLng? userLatLng;
  String? clinicName;

  CompleteRegisterModel({
    this.selectedCity,
    required this.selectedMedicalSpecialty,
    required this.studiesInfo,
    this.locationInfo,
    required this.specialtyInfo,
    required this.certificationImages,
    this.userLatLng,
    this.clinicName,
  });

  // Convert a CompleteRegisterModel object into a Map object
  Map<String, dynamic> toJson() {
    return {
      'cityId': selectedCity,
      'selectedMedicalSpecialty': selectedMedicalSpecialty,
      'studiesInfo': studiesInfo,
      'locationInfo': locationInfo,
      'specialtyInfo': specialtyInfo,
      'certificationImages': certificationImages,
      'clinicName': clinicName,
      'userLatLng': userLatLng != null
          ? {
              'latitude': userLatLng!.latitude,
              'longitude': userLatLng!.longitude
            }
          : null,
    };
  }
}

List<String> medicalSpecialties = [
  'Anesthesiology'.tr(),
  'Cardiology'.tr(),
  'Dermatology'.tr(),
  'Endocrinology'.tr(),
  'Gastroenterology'.tr(),
  'Hematology'.tr(),
  'Infectious Disease'.tr(),
  'Nephrology'.tr(),
  'Neurology'.tr(),
  'Obstetrics & Gynecology'.tr(),
  'Oncology'.tr(),
  'Ophthalmology'.tr(),
  'Orthopedics'.tr(),
  'Otolaryngology (ENT)'.tr(),
  'Pediatrics'.tr(),
  'Psychiatry'.tr(),
  'Pulmonology'.tr(),
  'Radiology'.tr(),
  'Rheumatology'.tr(),
  'Urology'.tr(),
];

int getSpecialtyId(String specialtyName) {
  switch (specialtyName) {
    case 'Anesthesiology':
      return 1;
    case 'Cardiology':
      return 2;
    case 'Dermatology':
      return 3;
    case 'Endocrinology':
      return 4;
    case 'Gastroenterology':
      return 5;
    case 'Hematology':
      return 6;
    case 'Infectious Disease':
      return 7;
    case 'Nephrology':
      return 8;
    case 'Neurology':
      return 9;
    case 'Obstetrics & Gynecology':
      return 10;
    case 'Oncology':
      return 11;
    case 'Ophthalmology':
      return 12;
    case 'Orthopedics':
      return 13;
    case 'Otolaryngology (ENT)':
      return 14;
    case 'Pediatrics':
      return 15;
    case 'Psychiatry':
      return 16;
    case 'Pulmonology':
      return 17;
    case 'Radiology':
      return 18;
    case 'Rheumatology':
      return 19;
    case 'Urology':
      return 20;
    default:
      return -1; // Return -1 if specialty not found
  }
}

String getSpecialtyName(int specialtyId) {
  switch (specialtyId) {
    case 1:
      return 'Anesthesiology';
    case 2:
      return 'Cardiology';
    case 3:
      return 'Dermatology';
    case 4:
      return 'Endocrinology';
    case 5:
      return 'Gastroenterology';
    case 6:
      return 'Hematology';
    case 7:
      return 'Infectious Disease';
    case 8:
      return 'Nephrology';
    case 9:
      return 'Neurology';
    case 10:
      return 'Obstetrics & Gynecology';
    case 11:
      return 'Oncology';
    case 12:
      return 'Ophthalmology';
    case 13:
      return 'Orthopedics';
    case 14:
      return 'Otolaryngology (ENT)';
    case 15:
      return 'Pediatrics';
    case 16:
      return 'Psychiatry';
    case 17:
      return 'Pulmonology';
    case 18:
      return 'Radiology';
    case 19:
      return 'Rheumatology';
    case 20:
      return 'Urology';
    default:
      return ''; // Return empty string if specialty ID is not found
  }
}
