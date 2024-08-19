import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_images/app_images.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/bloc/sign_in_cubit/sign_in_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

import '../../../../../core/constants/app_string/app_string.dart';
import '../../widgets/steps_widget/navigat_button.dart';
import '../../widgets/steps_widget/pin_widget.dart';

class ForgetPasswordOTP extends StatelessWidget {
  const ForgetPasswordOTP({super.key});
  @override
  Widget build(BuildContext context) {
    SignInCubit signInCubit = context.read<SignInCubit>();

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          signInCubit.resetSignInCubit();

          Navigator.pushNamedAndRemoveUntil(
            context,
            welcomeScreen,
            (route) => false,
          );
        }
      },
      child: BlocConsumer<SignInCubit, SignInState>(listener: (context, state) {
        if (state is ForgetPasswordSendingEmailSuccessState) {
          customSnackBar(
              '${'we send the new OTP code to:'.tr()} ${signInCubit.userEmail}',
              context,
              isFloating: true);
        }
      }, builder: (context, state) {
        final userEmail = signInCubit.userEmail; // Access the phone number

        final isLoading = state is SignInLoadingState;
        return Scaffold(
            backgroundColor: customColors.primaryBackGround,
            // appBar: buildAppBarWithLineIndicatorincenter(1, context),
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildForgetPasswordOTPBody(
                      context, isLoading, userEmail, signInCubit)
                ],
              ),
            ));
      }),
    );
  }
}

Widget buildForgetPasswordOTPBody(BuildContext context, isloading,
    String userEmail, SignInCubit signInCubit) {
  TextEditingController? pinCodeController = TextEditingController();
  pinCodeController.text = signInCubit.otpCode;
  return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(20, 48, 20, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Verify your number'.tr(),
          style: customTextStyle.bodyLarge,
        ),
        Padding(
          padding: responsiveUtil.padding(10, 12, 0, 0),
          child: Text(
            "${'we send the OTP code to:'.tr()} $userEmail",
            textAlign: TextAlign.center,
            style: customTextStyle.bodyMedium.copyWith(
              fontFamily: 'Readex Pro',
              fontSize: 14,
              letterSpacing: 0.2,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Padding(
          padding: responsiveUtil.padding(50, 0, 0, 0),
          child: Image.asset(
            AppImages.otpImage,
            height: 180,
            fit: BoxFit.contain,
          ),
        ),
        // .animateOnPageLoad(
        //     animationsMap['imageOnPageLoadAnimation']!),
        const SizedBox(
          height: 100,
        ),
        otpWidget(context, (value) {
          signInCubit.pinUpdated(newOTPCode: value!);
        }, pinCodeController: pinCodeController),
        GestureDetector(
          onTap: () {
            if (signInCubit.userEmail.trim() != '') {
              signInCubit.sendEmailToGetOtp();
            } else {
              Navigator.pushNamedAndRemoveUntil(
                context,
                forgetPasswordEmail,
                (route) => false,
              );
            }
          },
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
            child: Text(
              AppString.sendNewCode.tr(),
              style: customTextStyle.bodyMedium.copyWith(
                // fontFamily: 'Readex Pro',
                color: customColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        navigateButton(() {
          Navigator.pushNamedAndRemoveUntil(
            context,
            forgetPasswordResetPassword,
            (route) => false,
          );
        }, AppString.continueButton.tr(), isloading)
      ],
    ),
  );
}
