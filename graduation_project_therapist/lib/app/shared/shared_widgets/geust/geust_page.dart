import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/view/screens/join_signIn_sheet/build_join_bottom_sheet.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/view/screens/join_signIn_sheet/build_signin_sheet.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class GuestWidget extends StatelessWidget {
  GuestWidget({Key? key}) : super(key: key);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: customColors.secondaryBackGround,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTopSection(),
                _buildBottomSection(context),
              ],
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
            width: 290,
            height: 90,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 50),
        Text(
          'To view or edit your profile, you need to be logged in.'.tr(),
          style: customTextStyle.headlineSmall.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 25),
        Text(
          'Being a registered user allows you to personalize your experience, track your activities, and engage more deeply with our community.'
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
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionButton(
                context,
                text: 'Join',
                onPressed: () =>
                    _showModalBottomSheet(context, const JoinWidget()),
                color: customColors.primaryBackGround,
                textColor: customColors.primaryText,
              ),
              _buildActionButton(
                context,
                text: 'Sign in',
                onPressed: () =>
                    _showModalBottomSheet(context, const SignInWidget()),
                color: customColors.secondaryBackGround,
                textColor: customColors.primaryText,
                borderColor: customColors.primaryBackGround,
              ),
            ],
          ),
        ),
        Text(
          'We\'re looking forward to seeing your profile!'.tr(),
          style: customTextStyle.bodyMedium.copyWith(
            color: customColors.primary,
          ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }

  Widget _buildActionButton(BuildContext context,
      {required String text,
      required VoidCallback onPressed,
      required Color color,
      required Color textColor,
      Color? borderColor}) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
      child: GeneralButtonOptions(
        onPressed: onPressed,
        text: text,
        options: ButtonOptions(
          width: responsiveUtil.screenWidth * 0.35,
          height: 50,
          color: color,
          textStyle: customTextStyle.titleSmall.copyWith(
            color: textColor,
          ),
          borderSide: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Future<void> _showModalBottomSheet(BuildContext context, Widget child) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: false,
      context: context,
      builder: (context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SizedBox(
          height: 700,
          child: child,
        ),
      ),
    );
  }
}
