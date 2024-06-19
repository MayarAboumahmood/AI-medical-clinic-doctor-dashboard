import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

RefreshIndicator customRefreshIndicator(
    Future<void> Function() onRefresh, Widget child) {
  return RefreshIndicator(
      backgroundColor: customColors.secondaryBackGround,
      color: customColors.primary,
      onRefresh: onRefresh,
      child: child);
}
