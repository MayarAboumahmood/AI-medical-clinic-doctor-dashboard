import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_images/app_images.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/bloc/register_cubit/register_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/bloc/register_cubit/register_state.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/view/widgets/steps_widget/app_bar_steps.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/view/widgets/steps_widget/riched_text.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/get_status_request_from_status_code.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/validation_functions.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/text_fields/password_textfield.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import '../../../../../core/constants/app_string/app_string.dart';
import '../../widgets/steps_widget/navigat_button.dart';

class PasswordStepPage extends StatefulWidget {
  const PasswordStepPage({super.key});

  @override
  State<PasswordStepPage> createState() => _PasswordStepPageState();
}

class _PasswordStepPageState extends State<PasswordStepPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool passwordSecurFirst = true;
  bool passwordSecurSecond = true;
  late RegisterCubit registerCubit;
  @override
  void initState() {
    super.initState();
    registerCubit = context.read<RegisterCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
        listener: (ccontext, state) {
          if (state is RegisterSuccessRequestWithoutOTP) {
            navigationService.navigateTo(selectImageRegisterStep);
            comingFromRegisterOrLogin = true;
          } else if (state is RegisterValidationErrorRequest) {
            customSnackBar('Check your inputs', context);
          } else if (state is RegisterServerErrorRequest) {
            customSnackBar(getMessageFromStatus(state.statusRequest), context);
          }
        },
        child: Scaffold(
            backgroundColor: customColors.primaryBackGround,
            appBar: buildAppBarWithLineIndicatorincenter(2, context),
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [buildPasswordStep2Body()],
              ),
            )));
  }

  Widget buildPasswordStep2Body() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: responsiveUtil.screenHeight * .04,
          horizontal: responsiveUtil.screenWidth * .04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          richedTextSteps(context, 2),
          Padding(
            padding: responsiveUtil.padding(
                responsiveUtil.screenWidth * .012, 0, 0, 0),
            child: Text(
              "${'Set your password'.tr()} ",
              textAlign: TextAlign.center,
              style: customTextStyle.bodyMedium.copyWith(
                fontSize: 14,
                letterSpacing: 0.2,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Padding(
            padding: responsiveUtil.padding(
                responsiveUtil.screenWidth * .012, 0, 0, 0),
            child: Text(
              AppString.changePasswordTitle.tr(),
              textAlign: TextAlign.center,
              style: customTextStyle.bodyMedium.copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          changePasswordImage(),
          SizedBox(
            height: responsiveUtil.screenHeight * .05,
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                PasswordTextField(
                  controller: registerCubit.passwordtextgController,
                  label: "Current Password",
                ),
                PasswordTextField(
                  controller: registerCubit.retypePasswordtextController,
                  label: "Re-type new Password",
                  validator: (value) {
                    return ValidationFunctions.isNewPasswordEqualreType(
                        registerCubit.passwordtextgController.text,
                        registerCubit.retypePasswordtextController.text);
                  },
                ),
                BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    final bool isLoading = state is RegisterLoadingState;
                    return navigateButton(() {
                      FormState? formdata = formKey.currentState;
                      if (formdata!.validate()) {
                        formdata.save();
                        navigationService.navigateTo(selectImageRegisterStep);
                      }
                    }, AppString.continueButton.tr(), isLoading);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding changePasswordImage() {
    return Padding(
      padding:
          responsiveUtil.padding(responsiveUtil.screenHeight * .05, 0, 0, 0),
      child: Image.asset(
        AppImages.otpImage,
        height: 180,
        fit: BoxFit.contain,
      ),
    );
  }
}
