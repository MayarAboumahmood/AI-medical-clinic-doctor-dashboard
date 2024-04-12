import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Widget buildAboutEventSection(BuildContext context, String description) {
  // Check if description length is greater than 40 characters
  if (description.length > 40) {
    // Use ExpandablePanel for longer descriptions
    return _buildExpandableDescription(context, description);
  } else {
    // For shorter descriptions, display normally without ExpandablePanel
    return _buildNormalDescription(context, description);
  }
}

Widget _buildNormalDescription(BuildContext context, String description) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: responsiveUtil.screenWidth,
        decoration: const BoxDecoration(),
        child: Text(
          description,
          style: customTextStyle.bodyMedium.copyWith(
            color: customColors.secondaryText,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}

Widget _buildExpandableDescription(BuildContext context, String description) {
  int endIndex = description.length < 60 ? description.length : 60;
  return Container(
    decoration: BoxDecoration(
      color: customColors.primaryBackGround,
    ),
    child: ExpandableNotifier(
      child: ExpandablePanel(
        collapsed: Container(
          width: responsiveUtil.screenWidth,
          decoration: const BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                '${description.substring(0, endIndex)}...',
                style: customTextStyle.bodyMedium.copyWith(
                  color: customColors.secondaryText,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-1.00, -1.00),
                child: Text(
                  "See more".tr(),
                  style: customTextStyle.bodyMedium.copyWith(
                    color: customColors.secondaryText,
                    decoration: TextDecoration.underline,
                    decorationColor: customColors.secondaryText,
                  ),
                ),
              ),
            ],
          ),
        ),
        expanded: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              description,
              style: customTextStyle.bodyMedium.copyWith(
                color: customColors.secondaryText,
                fontWeight: FontWeight.w500,
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-1.00, 0.00),
              child: Text(
                "See less".tr(),
                style: customTextStyle.bodyMedium.copyWith(
                  color: customColors.secondaryText,
                  decoration: TextDecoration.underline,
                  decorationColor: customColors.secondaryText,
                ),
              ),
            ),
          ],
        ),
        theme: ExpandableThemeData(
          tapHeaderToExpand: false,
          tapBodyToExpand: true,
          tapBodyToCollapse: true,
          headerAlignment: ExpandablePanelHeaderAlignment.center,
          hasIcon: true,
          iconColor: customColors.secondaryText,
        ),
      ),
    ),
  );
}
