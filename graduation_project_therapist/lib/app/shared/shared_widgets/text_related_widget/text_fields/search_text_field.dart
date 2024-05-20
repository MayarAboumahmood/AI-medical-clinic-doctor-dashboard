import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../main.dart';

TextFormField searchTextField(
    {required String hintText,
    VoidCallback? onFilterTap,
    Key? myTextFieldKey,
    Function(String)? onChanged}) {
  Timer? debounce;

  return TextFormField(
    key: myTextFieldKey,
    onChanged: (value) {
      if (debounce?.isActive ?? false) debounce?.cancel();
      debounce = Timer(const Duration(milliseconds: 300), () {
        onChanged?.call(value);
      });
    },
    cursorColor: customColors.primary,
    autofocus: false,
    obscureText: false,
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: customColors
              .secondaryBackGround, // Same color as border to prevent color change on focus
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: customColors
              .secondaryBackGround, // Same color as border to prevent color change on focus
        ),
      ),

      prefixIcon: Icon(
        Icons.search,
        color: customColors.secondaryText,
        size: 30,
      ),
      labelStyle: customTextStyle.labelMedium.copyWith(
        fontSize: 12,
      ),
      hintText: hintText.tr(),
      hintStyle: customTextStyle.labelMedium.copyWith(
        fontSize: 14,
      ),
      isDense: true, // Important: Reduces extra space within the field
      contentPadding: const EdgeInsets.symmetric(
          vertical: 10, horizontal: 15), // Adjust the padding

      filled: true,
      fillColor: customColors.primaryBackGround,
    ),
    style: customTextStyle.bodyMedium.copyWith(
      fontSize: 12,
    ),
  );
}
