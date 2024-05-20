import 'package:flutter/material.dart';

Future<dynamic> showBottomSheetWidget(BuildContext context, Widget child) {
  // final unfocusNode = FocusNode();
  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    enableDrag: false,
    context: context,
    builder: (sheetContext) {
      return
          child;
       },
  );
}
