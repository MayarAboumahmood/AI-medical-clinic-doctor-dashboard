import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_blocs/language_bloc.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

import '../../../../../core/constants/colors/app_colors.dart';

class Language {
  final String name;
  final String languageCode;
  final String imageName;
  Language(this.name, this.languageCode, this.imageName);
}

// ignore: use_key_in_widget_constructors
class LanguageSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: responsiveUtil.scaleHeight(100),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              // color: customColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: dropDown(context),
          ),
        ],
      ),
    );
  }
}

Widget dropDown(BuildContext context) {
  String currentLanguage =
      sharedPreferences?.getString('language_code') ?? 'en';
  List<Language> languages = [
    Language('English', 'en', 'assets/images/united kindom flag.png'),
    Language('العربية', 'ar', 'assets/images/arab language flag.webp'),
  ];
  Language selectedLanguage =
      currentLanguage == 'ar' ? languages[1] : languages[0];
  return SizedBox(
    height: 40,
    child: DropdownButtonHideUnderline(
      child: DropdownButton2<Language>(
        isExpanded: true,
        hint: hintText(selectedLanguage),
        value: selectedLanguage,
        iconStyleData: IconStyleData(
            iconEnabledColor: AppColors.info,
            icon: Container(
              height: 40,
              color: customColors.primaryBackGround,
              child: Icon(
                Icons.arrow_drop_down,
                color: customColors.info,
              ),
            )),
        onChanged: (Language? newValue) {
          final languageBloc = BlocProvider.of<LanguageBloc>(context);
          if (newValue!.name == 'English') {
            // if (comingFromRegisterOrLogin) {
            context.setLocale(const Locale('en')); // <-- Change the locale
            // }
            languageBloc.add(LanguageSelected(const Locale('en')));
            sharedPreferences!.setString('language_code', 'en');
          } else {
            // if (comingFromRegisterOrLogin) {
            context.setLocale(const Locale('ar')); // <-- Change the locale
            // }

            sharedPreferences!.setString('language_code', 'ar');
            languageBloc.add(LanguageSelected(const Locale('ar')));
            sharedPreferences!.setString('language_code', 'ar');
          }
          Navigator.pop(context);
        },
        items: languages.map<DropdownMenuItem<Language>>((Language language) {
          return langaugeChangeItems(language);
        }).toList(),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: customColors.primaryBackGround,
          ),
        ),
      ),
    ),
  );
}

Text hintText(Language selectedLanguage) {
  return Text(
    selectedLanguage.name.toString(),
    style: const TextStyle(
      color: AppColors.info, // your theme color here
      fontWeight: FontWeight.normal,
      fontSize: 13,
    ),
  );
}

DropdownMenuItem<Language> langaugeChangeItems(Language language) {
  return DropdownMenuItem<Language>(
    value: language,
    child: Container(
      color: customColors.primaryBackGround,
      constraints: const BoxConstraints(),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: 30,
                    height: 25,
                    child: Image.asset(language.imageName)),
              ),
              Text(
                language.name,
                style: TextStyle(
                  color: customColors.primaryText, // your theme color here
                  fontWeight: FontWeight.normal,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
