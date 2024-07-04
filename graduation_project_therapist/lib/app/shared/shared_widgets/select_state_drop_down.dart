import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/validation_functions.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Padding selectCityDropDown(
    String? selectedCity, void Function(String?)? onChanged,
    {bool shouldActiviteValidation = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: customColors.secondaryBackGround)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: DropdownButtonFormField<String>(
            validator: (value) {
              if (!shouldActiviteValidation) {
                return null;
              }
              return ValidationFunctions.dropDownValidation(value);
            },
            value: selectedCity,
            decoration: InputDecoration(
              hintText: 'City'.tr(),
              hintStyle: customTextStyle.bodyMedium.copyWith(
                  color: customColors.primaryText,
                  fontWeight: FontWeight.w400,
                  fontSize: 12),
              labelStyle: customTextStyle.bodyMedium.copyWith(
                color: customColors.primary,
                fontSize: 12,
              ),
              labelText: 'City:'.tr(),
              border: InputBorder.none,
            ),
            dropdownColor: customColors.primaryBackGround,
            items: citiesList.map<DropdownMenuItem<String>>((String city) {
              return DropdownMenuItem<String>(
                value: city,
                child: Text(
                  city.tr(),
                  style: customTextStyle.bodySmall
                      .copyWith(color: customColors.primaryText),
                ),
              );
            }).toList(),
            onChanged: onChanged),
      ),
    ),
  );
}

List<String> citiesList = [
  'Damascus'.tr(),
  'Homs'.tr(),
  'Latakia'.tr(),
  'Aleppo'.tr(),
  'Tartus'.tr(),
  'As-suwayda'.tr(),
  'Hama'.tr(),
  'Idlib'.tr(),
  'Deir ez-Zor'.tr(),
  'Raqqa'.tr(),
  'Daraa'.tr(),
  'Al-Hasakah'.tr(),
  'Qamishli'.tr(),
];
int getCityId(String cityName) {
  switch (cityName) {
    case 'Damascus':
    case 'دمشق':
      return 1;
    case 'Homs':
    case 'حمص':
      return 3;
    case 'Latakia':
    case 'اللاذقية':
      return 4;
    case 'Aleppo':
    case 'حلب':
      return 2;
    case 'Tartus':
    case 'طرطوس':
      return 10;
    case 'As-suwayda':
    case 'السويداء':
      return 14;
    case 'Hama':
    case 'حماة':
      return 5;
    case 'Idlib':
    case 'ادلب':
      return 8;
    case 'Deir ez-Zor':
    case 'دير الزور':
      return 6;
    case 'Raqqa':
    case 'الرقة':
      return 7;
    case 'Daraa':
    case 'درعا':
      return 9;
    case 'Al-Hasakah':
    case 'الحسكة':
      return 12;
    case 'Qamishli':
    case 'قامشلي':
      return 13;
    case 'reief-Demaschk':
      return 15;
    default:
      return -1; // Return -1 if city not found
  }
}

String getCityName(int cityId) {
  switch (cityId) {
    case 1:
      return 'Damascus'.tr();
    case 3:
      return 'Homs'.tr();
    case 4:
      return 'Latakia'.tr();
    case 2:
      return 'Aleppo'.tr();
    case 10:
      return 'Tartus'.tr();
    case 14:
      return 'As-suwayda'.tr();
    case 5:
      return 'Hama'.tr();
    case 8:
      return 'Idlib'.tr();
    case 6:
      return 'Deir ez-Zor'.tr();
    case 7:
      return 'Raqqa'.tr();
    case 9:
      return 'Daraa'.tr();
    case 11:
      return 'Al-Hasakah'.tr();
    case 12:
      return 'Qamishli'.tr();
    case 13:
      return 'Jablah'.tr();
    case 15:
      return 'reief-Demaschk'.tr();
    default:
      return ''; // Return empty string if city ID is not found
  }
}
