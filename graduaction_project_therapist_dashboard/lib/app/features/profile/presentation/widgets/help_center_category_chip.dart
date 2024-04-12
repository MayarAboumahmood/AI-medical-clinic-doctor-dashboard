import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';


typedef CategorySelectionCallback = void Function(String selectedCategory);
//just to rename the void function(string selectedCategory) we use typedef for example :typedef IntList = List<int>;
Widget helpCenterCategoryChip(
    String title, String choosinCategory, CategorySelectionCallback onSelect) {
  bool isSelected = title == choosinCategory;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: GestureDetector(
      onTap: () {
        onSelect(title);
      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isSelected
                  ? customColors.primary
                  : customColors.primaryBackGround,
              border: Border.all(
                color: isSelected
                    ? customColors.primaryBackGround
                    : customColors.primary,
              )),
          child: Padding(
            padding: EdgeInsets.all(isSelected ? 10 : 8.0),
            child: Text(
              title.tr(),
              style: customTextStyle.bodyMedium.copyWith(
                  color: isSelected
                      ? customColors.primaryBackGround
                      : customColors.primary),
            ),
          )),
    ),
  );
}
