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
  'Behavioral Therapy'.tr(),
  'Cognitive Behavioral Therapy'.tr(),
  'Family Therapy'.tr(),
  'Group Therapy'.tr(),
  'Marriage and Family Therapy'.tr(),
  'Psychotherapy'.tr(),
  'Psychoanalysis'.tr(),
  'Psychiatric Nursing'.tr(),
  'Mental Health Counseling'.tr(),
];
String getSpecialtyString(int therapyId) {
  switch (therapyId) {
    case 1:
      return 'Behavioral Therapy';
    case 2:
      return 'Cognitive Behavioral Therapy';
    case 3:
      return 'Family Therapy';
    case 4:
      return 'Group Therapy';
    case 5:
      return 'Marriage and Family Therapy';
    case 6:
      return 'Psychotherapy';
    case 7:
      return 'Psychoanalysis';
    case 8:
      return 'Psychiatric Nursing';
    case 9:
      return 'Mental Health Counseling';
    default:
      return ''; // Return empty string if therapy ID is not found
  }
}

int getSpecialtyId(String therapyId) {
  switch (therapyId) {
    case 'Behavioral Therapy':
      return 10;
    case 'Cognitive Behavioral Therapy':
      return 11;
    case 'Family Therapy':
      return 12;
    case 'Group Therapy':
      return 13;
    case 'Marriage and Family Therapy':
      return 14;
    case 'Psychotherapy':
      return 15;
    case 'Psychoanalysis':
      return 16;
    case 'Psychiatric Nursing':
      return 17;
    case 'Mental Health Counseling':
      return 18;
    default:
      return -1; // Return empty string if therapy ID is not found
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
