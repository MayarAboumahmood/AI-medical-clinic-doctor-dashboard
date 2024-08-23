import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/screens/profile/profile_screen.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/show_bottom_sheet.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class YourDataNotCompletedYetPage extends StatelessWidget {
  YourDataNotCompletedYetPage({Key? key}) : super(key: key);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: customColors.secondaryBackGround,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: responsiveUtil.screenWidth,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTopSection(),
                  _buildBottomSection(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/images/SMHC icon.png',
            width: 150,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 50),
        Text(
          "Complete Your Profile to Get Started".tr(),
          style: customTextStyle.headlineSmall.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 25),
        Text(
          "Unlock the Full Functionality of the System by Completing Your Profile. Until Then, Access to System Features Is Limited."
              .tr(),
          style: customTextStyle.bodyMedium.copyWith(
            color: customColors.secondaryText,
            fontSize: 14,
          ),
          textAlign: TextAlign.start,
        ),
      ],
    );
  }

  Widget _buildBottomSection(BuildContext context) {
    return Column(
      children: [
        Text(
          "We're looking forward for you!".tr(),
          style: customTextStyle.bodyMedium.copyWith(
            color: customColors.primary,
          ),
          textAlign: TextAlign.start,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 30),
          child: completeDataButton(),
        ),
        const SizedBox(
          height: 100,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 30),
          child: GestureDetector(
              onTap: () {
                showBottomSheetWidget(context, logOutBottomSheet(context));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: customColors.primary),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Log Out'.tr(),
                    style: customTextStyle.bodyMedium,
                  ),
                ),
              )),
        ),
      ],
    );
  }

  GeneralButtonOptions completeDataButton() {
    return GeneralButtonOptions(
      onPressed: () async {
        navigationService.navigateTo(completeDataPage);
      },
      text: 'Complete my data'.tr(),
      options: ButtonOptions(
        width: 350,
        height: 45,
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        color: customColors.primary,
        textStyle: customTextStyle.titleSmall.copyWith(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        borderSide: const BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}
