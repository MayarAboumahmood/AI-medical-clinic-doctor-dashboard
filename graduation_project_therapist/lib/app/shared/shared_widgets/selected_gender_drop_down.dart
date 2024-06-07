import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/validation_functions.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Widget selectGenderDropDown(
    String? selectedGender, void Function(String?) onChanged,
    {bool shouldActiviteValidation = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 5,
    ),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: customColors.secondaryBackGround)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: DropdownButtonFormField<String>(
            validator: (value) {
              if (!shouldActiviteValidation) {
                return null;
              }
              return ValidationFunctions.dropDownValidation(value);
            },
            value: selectedGender,
            decoration: InputDecoration(
              hintStyle: customTextStyle.bodyMedium.copyWith(
                  color: customColors.primaryText,
                  fontWeight: FontWeight.w400,
                  fontSize: 12),
              labelStyle: customTextStyle.bodyMedium.copyWith(
                color: customColors.primary,
                fontSize: 12,
              ),
              labelText: 'Gender:'.tr(),
              border: InputBorder.none,
            ),
            dropdownColor: customColors.primaryBackGround,
            items: genderOptions.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value.tr(),
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

List<String> genderOptions = [
  'male'.tr(),
  'female'.tr()
]; // List of gender options
