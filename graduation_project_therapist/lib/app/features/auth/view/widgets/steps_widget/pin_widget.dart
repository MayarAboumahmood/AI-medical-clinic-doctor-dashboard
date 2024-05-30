import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../../main.dart';

Widget otpWidget(BuildContext context, Function(String?)? onCompleted,
    {TextEditingController? pinCodeController}) {
  return SizedBox(
    width: responsiveUtil.screenWidth*.95,
    child: PinCodeTextField(
      autoDisposeControllers: true,
      appContext: context,
      length: 6,
      textStyle: customTextStyle.titleSmall.copyWith(
        color: customColors.primaryText,
      ),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      enableActiveFill: true,
      autoFocus: true,
      enablePinAutofill: true,
      errorTextSpace: 16,
      showCursor: false,
      cursorColor: customColors.primary,
      obscureText: false,
      hintCharacter: '-',
      keyboardType: TextInputType.number,
      pinTheme: PinTheme(
        fieldHeight: 50,
        fieldWidth: 50,
        borderWidth: 2,
        borderRadius: BorderRadius.circular(16),
        shape: PinCodeFieldShape.box,
        activeColor: customColors.primary,
        inactiveColor: customColors.secondaryBackGround,
        selectedColor: customColors.secondaryText,
        activeFillColor: customColors.primary,
        inactiveFillColor: customColors.secondaryBackGround,
        selectedFillColor: customColors.secondaryText,
      ),
      controller: pinCodeController,
      // onChanged: onChanged,
      // onSaved: onSaved,
      onCompleted: onCompleted,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      // validator: _model.pinCodeControllerValidator
      // .asValidator(context),
    ),
  );
}
