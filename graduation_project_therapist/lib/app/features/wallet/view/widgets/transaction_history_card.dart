import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/wallet/data_source/models/wallet_history_model.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/image_widgets/network_image.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/expanded_description.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Widget transactionHistoryCard(
    BuildContext context, WalletHistoryModel walletHistory) {
  if (walletHistory.status == 'done') {
    print(
        'ssssssssssssssssss:${walletHistory.withdrawSpecialistTransaction!.withdrawSpecialistApprovement!.description}');
  }
  return Container(
    width: responsiveUtil.screenWidth,
    decoration: BoxDecoration(
      border: Border.all(color: customColors.primary),
      color: customColors.secondaryBackGround,
      borderRadius: BorderRadius.circular(8),
    ),
    margin: const EdgeInsets.symmetric(
      vertical: 8.0,
    ),
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${'Date:'.tr()} ${walletHistory.date}',
            style: customTextStyle.bodyMedium,
          ),
          const SizedBox(height: 8.0),
          Text(
            '${'Amount:'.tr()} ${walletHistory.amount}',
            style: customTextStyle.bodyMedium,
          ),
          const SizedBox(height: 8.0),
          Text(
            '${'Status:'.tr()} ${walletHistory.status}',
            style: customTextStyle.bodyMedium,
          ),
          const SizedBox(height: 8.0),
          walletHistory.withdrawSpecialistTransaction
                      ?.withdrawSpecialistApprovement?.description !=
                  null
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${'description'.tr()}: ',
                      style: customTextStyle.bodyMedium,
                    ),
                    expandedDescription(
                        context,
                        textStyle: customTextStyle.bodyMedium,
                        width: responsiveUtil.screenWidth * .65,
                        walletHistory.withdrawSpecialistTransaction!
                            .withdrawSpecialistApprovement!.description,
                        backGroundColor: Colors.transparent),
                  ],
                )
              : const SizedBox(),
          const SizedBox(height: 8.0),
          // Display image if available
          if (walletHistory.withdrawSpecialistTransaction
                  ?.withdrawSpecialistApprovement?.url !=
              null)
            Column(
              children: [
                const SizedBox(height: 8.0),
                Text(
                  'Transaction Proof:'.tr(),
                  style: customTextStyle.bodyMedium,
                ),
                const SizedBox(height: 8.0),
                getImageNetwork(
                  height: responsiveUtil.screenHeight * 0.2,
                  width: responsiveUtil.screenWidth,
                  url: walletHistory.withdrawSpecialistTransaction!
                      .withdrawSpecialistApprovement!.url,
                  fit: BoxFit.cover,
                ),
              ],
            ),
        ],
      ),
    ),
  );
}
