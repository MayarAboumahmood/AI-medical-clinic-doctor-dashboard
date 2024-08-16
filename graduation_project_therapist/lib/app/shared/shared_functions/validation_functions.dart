import 'package:easy_localization/easy_localization.dart';

import '../../core/constants/app_string/app_string.dart';

class ValidationFunctions {
  static String? nameValidation(String? value) {
    if (value!.length < 3) {
      return AppString.validationName.tr();
    }
    return null;
  }

  static String? specializationValidation(List<String>? value) {
    if (value!.isEmpty) {
      return AppString.listValidationEmpty.tr();
    }
    return null;
  }

  static String? dropDownValidation(String? value) {
    if (value == null) {
      return AppString.validationDropDownEmpty.tr();
    } else if (value.isEmpty) {
      return AppString.validationDropDownEmpty.tr();
    }
    return null;
  }

  static String? informationValidation(String? value) {
    if (value == null) {
      return AppString.validationEmpty.tr();
    } else if (value.isEmpty) {
      return AppString.validationEmpty.tr();
    } else if (value.length < 6) {
      return AppString.validationInfo.tr();
    }
    return null;
  }

  static String? informationValidationThatCanBeEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    } else if (value.length < 6) {
      return AppString.validationInfo.tr();
    }
    return null;
  }

  static String? isValidEmail(String? input) {
    final RegExp regex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    if (!regex.hasMatch(input ?? '')) {
      return AppString.validationEmail.tr();
    }
    return null;
  }

  static String? isValidAmountOfMoney(String? value) {
    if (value == null || value.isEmpty) {
      return AppString.validationAmountOfMoney.tr();
    }

    final amount = double.tryParse(value);
    if (amount == null || amount <= 0) {
      return AppString.validationAmountOfMoney.tr();
    }

    return null;
  }

  static String? isStrongPassword(String input) {
    final RegExp regex = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d).{8,}$',
    );
    if (input.isEmpty) {
      return 'The password field can\'t be empty!'.tr();
    } else if (input.length < 8) {
      return AppString.validatLenghtPassword.tr();
    } else if (!regex.hasMatch(input)) {
      return AppString.validatStrongPassword.tr();
    }
    return null;
  }

  static String? isValidSyrianPhoneNumber(String? input) {
    if (input == null) {
      return AppString.validationphoneLong.tr();
    } else if (input.length != 10) {
      return AppString.validationphoneLong.tr();
    } else if (input[0] != '0' || input[1] != '9') {
      return AppString.validationphonefirstTwoNumber.tr();
    }
    return null;
  }

  static String? isValidSyrianPhoneNumberWith963(String? input) {
    if (input == null) {
      return AppString.validationphoneLong963.tr();
    } else if (input[0] != '9' || input[1] != '6' || input[2] != '3') {
      return AppString.validationphonefirstThreeNumber.tr();
    } else if (input.length != 12) {
      return AppString.validationphoneLong963.tr();
    }
    return null;
  }

  static String? validateSyrianPhoneNumber(String? input) {
    if (input == null) {
      return AppString.validationphoneLong.tr();
    } else if (input.startsWith('09') && input.length == 10) {
      // Valid case for numbers starting with '09' and 10 digits long
      return null;
    } else if (input.startsWith('963') && input.length == 12) {
      // Valid case for numbers starting with '963' and 12 digits long
      return null;
    } else if (input.startsWith('9') && input.length == 9) {
      // Valid case for numbers starting with '9' and 9 digits long
      return null;
    } else if (input.length == 10 || input.length == 9) {
      // Specific error for length but not starting correctly
      return AppString.validationphonefirstTwoNumber.tr();
    } else if (input.length == 12) {
      // Specific error for length but not starting correctly with '963'
      return AppString.validationphonefirstThreeNumber.tr();
    } else {
      // Generic error for incorrect length
      return AppString.validationphoneLong.tr();
    }
  }

  static String? isNewPasswordEqualreType(
    String reTypePassword,
    String newPassowrd,
  ) {
    if (newPassowrd != reTypePassword) {
      return AppString.validationPassowrdNotMatched.tr();
    }
    return isStrongPassword(reTypePassword);
  }
}
