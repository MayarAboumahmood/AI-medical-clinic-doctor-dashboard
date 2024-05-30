import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_images/app_images.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/bloc/sign_in_cubit/sign_in_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/validation_functions.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/text_fields/text_field.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

import '../../../../../core/constants/app_string/app_string.dart';

import '../../widgets/steps_widget/navigat_button.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();
String? email;
late bool isLoading;

class ForgetPasswordEmail extends StatelessWidget {
  const ForgetPasswordEmail({super.key});

  @override
  Widget build(BuildContext context) {
    SignInCubit signInCubit = context.read<SignInCubit>();
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        signInCubit.resetSignInCubit();
        Navigator.pushNamedAndRemoveUntil(
          context,
          welcomeScreen,
          (route) => false,
        );
      },
      child:
          BlocConsumer<SignInCubit, SignInState>(listener: (ccontext, state) {
        if (state is SignInFailureState) {
          customSnackBar(state.errorMessage, context, isFloating: true);
        } else if (state is ForgetPasswordSendingEmailSuccessState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            forgetPasswordOTP,
            (route) => false,
          );
          customSnackBar(
              '${'we send the OTP code to:'.tr()} ${signInCubit.userEmail}',
              context,
              isFloating: true);
        }
      }, builder: (context, state) {
        isLoading = state is SignInLoadingState;
        if (state is SignInSendingOtpCodeLoadingState ||
            state is SignInErrorRequeistState) {
          return Center(
            child: CircularProgressIndicator(color: customColors.primary),
          );
        }
        return Scaffold(
            backgroundColor: customColors.primaryBackGround,
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildForgetPasswordemailBody(context, formKey, isLoading)
                ],
              ),
            ));
      }),
    );
  }
}

Widget buildForgetPasswordemailBody(
    BuildContext context, GlobalKey<FormState> formKey, bool isLoading) {
  SignInCubit signInCubit = context.read<SignInCubit>();
  return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(20, 48, 20, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'First step'.tr(),
          style: customTextStyle.bodyLarge,
        ),
        Padding(
          padding: responsiveUtil.padding(10, 12, 0, 0),
          child: Text(
            'enter Your email address'.tr(),
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
            AppImages.emailImage,
            height: 180,
            fit: BoxFit.contain,
          ),
        ),
        // .animateOnPageLoad(
        //     animationsMap['imageOnPageLoadAnimation']!),
        SizedBox(
          height: responsiveUtil.screenHeight * .115,
        ),
        Form(
          key: formKey,
          child: SizedBox(
            width: 300,
            child: customTextField(
                textInputType: TextInputType.emailAddress,
                validator: (value) {
                  return ValidationFunctions.isValidEmail(value!);
                },
                context: context,
                onSaved: (value) {
                  signInCubit.userEmail = value ?? '';
                },
                label: 'Email'.tr()),
          ),
        ),
        navigateButton(() {
          FormState? formdata = formKey.currentState;
          if (formdata!.validate()) {
            formdata.save();
            signInCubit.sendEmailToGetOtp();
          }
        }, AppString.continueButton.tr(), isLoading)
      ],
    ),
  );
}
