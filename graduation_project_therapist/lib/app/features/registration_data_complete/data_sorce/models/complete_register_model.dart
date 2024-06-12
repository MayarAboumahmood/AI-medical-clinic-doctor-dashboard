import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';

class CompleteRegisterModel {
  String? selectedCity;
  List<String> selectedMedicalSpecialty;
  String? locationInfo;
  List<Uint8List?> certificationImages;
  LatLng? userLatLng;
  String? clinicName;

  CompleteRegisterModel({
    this.selectedCity,
    required this.selectedMedicalSpecialty,
    this.locationInfo,
    required this.certificationImages,
    this.userLatLng,
    this.clinicName,
  });

  // Convert a CompleteRegisterModel object into a Map object
  Map<String, dynamic> toJson() {
    return {
      'cityId': selectedCity,
      'selectedMedicalSpecialty': selectedMedicalSpecialty,
      'locationInfo': locationInfo,
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
    default:
      return ''; // Return empty string if specialty ID is not found
  }
}

String f = What.d.name;

enum What {
  apple('1'),
  d('2');

  final String value;
  const What(this.value);

  String ff() {
    return 'what';
  }
}
