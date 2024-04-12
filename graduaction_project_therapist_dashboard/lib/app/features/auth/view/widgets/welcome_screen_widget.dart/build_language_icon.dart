import 'package:flutter/material.dart';

import '../../../../../../main.dart';
import 'language_widget.dart';

// ... other imports ...

Widget buildLanguageIcon(BuildContext context) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: PopupMenuButton<String>(
        color: Colors.transparent,
        icon: Icon(
          Icons.language_sharp,
          color: customColors.info,
          size: 24,
        ),
        onSelected: (String result) {},
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: "0",
            child: LanguageSelector(),
          ),
        ],
      ),
    ),
  );
}
