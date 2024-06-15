import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/wallet/data_source/models/wallet_history_model.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Widget transactionHistoryCard(
    BuildContext context, WalletHistoryModel walletHistory) {
  return Container(
    width: responsiveUtil.screenWidth,
    decoration: BoxDecoration(
        border: Border.all(color: customColors.primary),
        color: customColors.secondaryBackGround,
        borderRadius: BorderRadius.circular(8)),
    margin: const EdgeInsets.symmetric(
      vertical: 8.0,
    ),
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date: ${walletHistory.date}',
            style: customTextStyle.bodyMedium,
          ),
          const SizedBox(height: 8.0),
          Text(
            'Amount: ${walletHistory.amount}',
            style: customTextStyle.bodyMedium,
          ),
          const SizedBox(height: 8.0),
          Text(
            'Status: ${walletHistory.status}',
            style: customTextStyle.bodyMedium,
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    ),
  );
}
