import 'package:flutter/material.dart';

bool isRTL(BuildContext context) =>
    Directionality.of(context) == TextDirection.rtl;
TextDirection getTextDirection(BuildContext context) {
  return isRTL(context) ? TextDirection.ltr : TextDirection.rtl;
}

TextDirection getLTRTextDirection(BuildContext context) {
  return TextDirection.ltr;
}
