import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Padding selectCityDropDown(
    String? selectedCity, void Function(String?)? onChanged) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: customColors.secondaryBackGround)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: DropdownButtonFormField<String>(
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
      return 2;
    case 'Latakia':
    case 'اللاذقية':
      return 3;
    case 'Aleppo':
    case 'حلب':
      return 4;
    case 'Tartus':
    case 'طرطوس':
      return 5;
    case 'As-suwayda':
    case 'السويداء':
      return 6;
    case 'Hama':
    case 'حماة':
      return 7;
    case 'Idlib':
    case 'ادلب':
      return 8;
    case 'Deir ez-Zor':
    case 'دير الزور':
      return 9;
    case 'Raqqa':
    case 'الرقة':
      return 10;
    case 'Daraa':
    case 'درعا':
      return 11;
    case 'Al-Hasakah':
    case 'الحسكة':
      return 12;
    case 'Qamishli':
    case 'قامشلي':
      return 13;
    default:
      return -1; // Return -1 if city not found
  }
}
String getCityName(int cityId) {
  switch (cityId) {
    case 1:
      return 'Damascus'.tr();
    case 2:
      return 'Homs'.tr();
    case 3:
      return 'Latakia'.tr();
    case 4:
      return 'Aleppo'.tr();
    case 5:
      return 'Tartus'.tr();
    case 6:
      return 'As-suwayda'.tr();
    case 7:
      return 'Hama'.tr();
    case 8:
      return 'Idlib'.tr();
    case 9:
      return 'Deir ez-Zor'.tr();
    case 10:
      return 'Raqqa'.tr();
    case 11:
      return 'Daraa'.tr();
    case 12:
      return 'Al-Hasakah'.tr();
    case 13:
      return 'Qamishli'.tr();
    default:
      return ''; // Return empty string if city ID is not found
  }
}
