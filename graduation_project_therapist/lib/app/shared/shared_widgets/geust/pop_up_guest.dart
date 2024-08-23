import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/view/screens/join_signIn_sheet/build_join_bottom_sheet.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/view/screens/join_signIn_sheet/build_signin_sheet.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class GuestPopupWidget extends StatelessWidget {
  const GuestPopupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0, 0),
      child: Container(
        width: responsiveUtil.screenWidth * .9,
        height: 300,
        decoration: BoxDecoration(
          color: customColors.secondaryBackGround,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/SMHC icon.png',
                  width: responsiveUtil.screenWidth * .7,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(-1, -1),
                    child: Text(
                      'To access this feature, you need to be a part of our community!'
                          .tr(),
                      textAlign: TextAlign.start,
                      style: customTextStyle.headlineSmall.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                      child: GeneralButtonOptions(
                        onPressed: () async {
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            enableDrag: false,
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: MediaQuery.viewInsetsOf(context),
                                child: const SizedBox(
                                  height: 700,
                                  child: JoinWidget(),
                                ),
                              );
                            },
                          );
                        },
                        text: 'Join'.tr(),
                        options: ButtonOptions(
                          height: 50,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              24, 0, 24, 0),
                          color: customColors.primaryBackGround,
                          textStyle: customTextStyle.titleSmall.copyWith(
                            color: customColors.primaryText,
                          ),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                      child: GeneralButtonOptions(
                        onPressed: () async {
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            enableDrag: false,
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: MediaQuery.viewInsetsOf(context),
                                child: const SizedBox(
                                  height: 700,
                                  child: SignInWidget(),
                                ),
                              );
                            },
                          );
                        },
                        text: 'Sign in'.tr(),
                        options: ButtonOptions(
                          height: 50,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              24, 0, 24, 0),
                          color: customColors.secondaryBackGround,
                          textStyle: customTextStyle.titleSmall.copyWith(
                            color: customColors.primaryText,
                          ),
                          borderSide: BorderSide(
                            color: customColors.primaryBackGround,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                child: Text(
                  'We\'re excited to have you onboard!'.tr(),
                  textAlign: TextAlign.start,
                  style: customTextStyle.bodyMedium.copyWith(
                    color: customColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showGuestDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        alignment: Alignment.center,
        backgroundColor: Colors.red,
        contentPadding: EdgeInsets.zero, // Removes default padding
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20)), // Removes default rounded corners
        children: const <Widget>[
          GuestPopupWidget(),
        ],
      );
    },
  );
}
