import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/view/screens/join_signIn_sheet/build_signin_sheet.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import '../../../../../core/constants/app_string/app_string.dart';
import '../../../../../shared/shared_functions/show_bottom_sheet.dart';
import '../../screens/join_signIn_sheet/build_join_bottom_sheet.dart';

Widget buildButtons(BuildContext context) {
  return Align(
    alignment: AlignmentDirectional(
        0.00, responsiveUtil.screenHeight < 660 ? 1.3 : 1.2),
    child: SizedBox(
      height: 200,
      child: Column(
        // mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: responsiveUtil.scaleHeight(100),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GeneralButtonOptions(
                  onPressed: () async {
                    await showBottomSheetWidget(
                      context,
                      const JoinWidget(),
                    );
                  },
                  text: "Join".tr(),
                  options: ButtonOptions(
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    height: responsiveUtil.scaleHeight(50),
                    color: customColors.info,
                    textStyle: customTextStyle.titleSmall
                        .copyWith(color: Colors.black),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                GeneralButtonOptions(
                  onPressed: () async {
                    await showBottomSheetWidget(context, const SignInWidget());
                  },
                  text: AppString.signIn.tr(),
                  options: ButtonOptions(
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    height: responsiveUtil.scaleHeight(50),
                    color: Colors.transparent,
                    textStyle: customTextStyle.titleSmall,
                    borderSide: BorderSide(
                      color: customColors.info,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                )
              ],
            ),
          ),
          _buildContinueAsGuest(context)
        ],
      ),
    ),
  );
}

Widget _buildContinueAsGuest(BuildContext context) {
  return InkWell(
    onTap: () async {
      navigationService.navigateTo(bottomNavigationBar);
      isGuest = true;
    },
    splashColor: Colors.transparent,
    focusColor: Colors.transparent,
    hoverColor: Colors.transparent,
    highlightColor: Colors.transparent,
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppString.continueAsGuest.tr(),
          style: customTextStyle.bodyMedium.copyWith(
            color: customColors.info,
            fontSize: 16,
          ),
        ),
        Icon(
          Icons.arrow_right_alt,
          color: customColors.info,
          size: 24,
        ),
      ],
    ),
  );
}
