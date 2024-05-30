import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_string/app_string.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/bloc/sign_in_cubit/sign_in_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/get_status_request_from_status_code.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/text_fields/text_field.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

import '../../../../../core/constants/app_images/app_images.dart';
import '../../../../../shared/shared_functions/validation_functions.dart';
import '../../widgets/steps_widget/navigat_button.dart';

// ignore: must_be_immutable
class ForgetPasswordResetPassword extends StatefulWidget {
  const ForgetPasswordResetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordResetPassword> createState() => _Step2PageState();
}

class _Step2PageState extends State<ForgetPasswordResetPassword> {
  late SignInCubit signInCubit;

  @override
  initState() {
    super.initState();
    signInCubit = context.read<SignInCubit>();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool passwordSecur = true;
  bool passwordSecurReWrite = true;
  String errorMessage = '';
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return buildResetPasswordBody();
  }

  PopScope buildResetPasswordBody() {
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
      child: signInCubitConsumer(),
    );
  }

  BlocConsumer<SignInCubit, SignInState> signInCubitConsumer() {
    return BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state is SuccessRequest) {
          customSnackBar('Your password changed successful', context,
              isFloating: true);
          Navigator.pushNamedAndRemoveUntil(
            context,
            welcomeScreen,
            (route) => false,
          );
        } else if (state is SignInErrorRequeistState) {
          customSnackBar(getMessageFromStatus(state.statusRequest), context,
              isFloating: true);
        } else if (state is SignInFailureState) {
          customSnackBar(state.errorMessage, context, isFloating: true);
        }
      },
      builder: (context, state) {
        isLoading = state is SignInLoadingState;
        return forgetPasswordChangePasswordBody(context);
      },
    );
  }

  Scaffold forgetPasswordChangePasswordBody(BuildContext context) {
    return Scaffold(
        backgroundColor: customColors.primaryBackGround,
        body: SingleChildScrollView(
          child: buildChangePassword(context),
        ));
  }

  Widget buildChangePassword(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 48, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          buildResetYourPasswordText(),
          buildEnterStrongPasswordText(),
          buildPasswordImage(),
          // .animateOnPageLoad(
          //     animationsMap['imageOnPageLoadAnimation']!),
          const SizedBox(
            height: 100,
          ),
          Form(
            key: formKey,
            child: SizedBox(
              width: 300,
              child: Column(
                children: [
                  buildPasswordTextField(context),
                  const SizedBox(
                    height: 10,
                  ),
                  buildReenterPasswordTextFeild(context),
                  buildErrorMessageIfPasswordNotEqualReSetPassword()
                ],
              ),
            ),
          ),
          navigateButton(() {
            setErrorMessage();
            FormState? formdata = formKey.currentState;
            if (formdata!.validate()) {
              formdata.save();
              if (!currentPasswordNotEqualReset) {
                signInCubit
                    .forgetPasswordChangePassword(newPasswordController.text);
              }
            }
          }, 'Done'.tr(), isLoading)
        ],
      ),
    );
  }

  Padding buildResetYourPasswordText() {
    return Padding(
      padding: responsiveUtil.padding(10, 12, 0, 0),
      child: Text(
        'Reset your password'.tr(),
        textAlign: TextAlign.center,
        style: customTextStyle.bodyMedium.copyWith(
          fontFamily: 'Readex Pro',
          fontSize: 18,
          letterSpacing: 0.2,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Visibility buildErrorMessageIfPasswordNotEqualReSetPassword() {
    return Visibility(
        visible: errorMessage != '',
        child: Text(
          errorMessage,
          style: customTextStyle.bodySmall
              .copyWith(color: const Color.fromARGB(255, 255, 0, 0)),
        ));
  }

  Widget buildReenterPasswordTextFeild(BuildContext context) {
    return customTextField(
        textInputType: TextInputType.visiblePassword,
        validator: (value) {
          return ValidationFunctions.isStrongPassword(value!);
        },
        isPassWordInVisible: passwordSecurReWrite,
        context: context,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              passwordSecurReWrite = !passwordSecurReWrite;
            });
          },
          child: Icon(
            passwordSecurReWrite
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: customColors.secondaryText,
            size: 18,
          ),
        ),
        controller: confirmPasswordController,
        label: 'Confirm the new password'.tr());
  }

  Widget buildPasswordTextField(BuildContext context) {
    return customTextField(
        textInputType: TextInputType.visiblePassword,
        validator: (value) {
          return ValidationFunctions.isStrongPassword(value!);
        },
        context: context,
        isPassWordInVisible: passwordSecur,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              passwordSecur = !passwordSecur;
            });
          },
          child: Icon(
            passwordSecur
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: customColors.secondaryText,
            size: 18,
          ),
        ),
        controller: newPasswordController,
        label: 'Enter new password'.tr());
  }

  Padding buildPasswordImage() {
    return Padding(
      padding: responsiveUtil.padding(50, 0, 0, 0),
      child: Image.asset(
        AppImages.passwordImage,
        height: 180,
        fit: BoxFit.contain,
      ),
    );
  }

  Padding buildEnterStrongPasswordText() {
    return Padding(
      padding: responsiveUtil.padding(10, 12, 0, 0),
      child: Text(
        AppString.enterStrongPassword.tr(),
        textAlign: TextAlign.center,
        style: customTextStyle.bodyMedium.copyWith(
          fontFamily: 'Readex Pro',
          fontSize: 14,
          letterSpacing: 0.2,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  void setErrorMessage() {
    if (currentPasswordNotEqualReset) {
      setState(() {
        errorMessage = 'The password does not match the reset password.'.tr();
      });
    } else {
      setState(() {
        errorMessage = '';
      });
    }
  }

  bool get currentPasswordNotEqualReset =>
      confirmPasswordController.text != newPasswordController.text;
}
