import 'package:easy_localization/easy_localization.dart';

int getGenderIntFromString(String gender) {
  if (gender == 'male'.tr() || gender == 'Male'.tr()) {
    return 1;
  } else {
    return 2;
  }
}
