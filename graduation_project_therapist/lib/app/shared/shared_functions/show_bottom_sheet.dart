import 'package:flutter/material.dart';

Future<dynamic> showBottomSheetWidget(BuildContext context, Widget child) {
  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (sheetContext) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: child,
          );
        },
      );
    },
  );
}
