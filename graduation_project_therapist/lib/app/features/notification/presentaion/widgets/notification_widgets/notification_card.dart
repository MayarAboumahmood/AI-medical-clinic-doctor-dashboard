import 'package:graduation_project_therapist_dashboard/app/core/utils/flutter_flow_util.dart';
import 'package:graduation_project_therapist_dashboard/app/features/notification/data/models/notification_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/notification/presentaion/widgets/notification_widgets/notification_icon.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Widget notificationCard(NotificationModel notificationModel) {
  return Container(
    color: notificationModel.seenType != 1
        ? customColors.primary.withOpacity(0.1)
        : null,
    padding: responsiveUtil.padding(10, 10, 10, 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            notificationIcon(Icons.document_scanner_rounded),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  notificationTitle(notificationModel.title),
                  // Visibility(
                  //     visible: notificationModel.seenType != 1,
                  //     child: notificationDote())
                ],
              ),
              Row(
                children: [
                  Text(
                    notificationModel.relativeDate,
                    style: customTextStyle.bodyMedium.copyWith(
                        fontSize: 14, color: customColors.secondaryText),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        color: customColors.secondaryText,
                        width: 1,
                        height: 25,
                      )),
                  Text(
                    notificationModel.formattedTime,
                    style: customTextStyle.bodyMedium.copyWith(
                        fontSize: 14, color: customColors.secondaryText),
                  ),
                ],
              ),
            ])
          ].divide(SizedBox(
            width: responsiveUtil.scaleWidth(15),
          )),
        ),
        const SizedBox(
          height: 10,
        ),
        notificationSubTitle(notificationModel.description),
        const SizedBox(
          height: 5,
        ),
        Divider(
          color: customColors.secondaryBackGround,
        )
      ],
    ),
  );
}

Widget notificationTitle(String title) {
  return Text(
    title.tr(),
    style: customTextStyle.bodyLarge.copyWith(color: customColors.primary),
  );
}

Widget notificationSubTitle(String supTitle) {
  return Text(
    supTitle.tr(),
    style:
        customTextStyle.bodyMedium.copyWith(color: customColors.secondaryText),
  );
}

SizedBox richedText({required String mainTitle, required String subTitle}) {
  return SizedBox(
    width: responsiveUtil.scaleWidth(280),
    child: RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$mainTitle: ",
            style: customTextStyle.bodyLarge.copyWith(
              color: customColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
              text: subTitle,
              style: customTextStyle.bodySmall
                  .copyWith(fontWeight: FontWeight.w600))
        ],
        style: customTextStyle.bodyLarge,
      ),
    ),
  );
}
