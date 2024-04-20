import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_images/app_images.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/bloc/register_cubit/register_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/view/widgets/steps_widget/app_bar_steps.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/view/widgets/steps_widget/riched_text.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/get_status_request_from_status_code.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/validation_functions.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_fields/text_field.dart';
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
  String password = '';
  String reTypePassword = '';
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
          if (state is RegisterSuccessRequest) {
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
            appBar: buildAppBarWithLineIndicatorincenter(3, context),
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
          richedTextSteps(context, 3),
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
                passwordTextField(),
                reTypePasswordTextField(),
                BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    final bool isLoading = state is RegisterLoadingRequest;
                    return navigateButton(() {
                      FormState? formdata = formKey.currentState;
                      if (formdata!.validate()) {
                        formdata.save();
                        registerCubit.sendRegisterRequest();
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

  Padding passwordTextField() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: customTextField(
                  textInputType: TextInputType.emailAddress,
                  validator: (value) {
                    return ValidationFunctions.isStrongPassword(value!);
                  },
                  onChanged: (value) {
                    password = value!;
                  },
                  context: context,
                  onSaved: (value) {
                    registerCubit.updateUserInfo(password: value ?? '');
                  },
                  label: "Current Password".tr()))
        ],
      ),
    );
  }

  Padding reTypePasswordTextField() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: customTextField(
                  textInputType: TextInputType.emailAddress,
                  validator: (value) {
                    return ValidationFunctions.isNewPasswordEqualreType(
                        password, reTypePassword);
                  },
                  context: context,
                  onChanged: (value) {
                    reTypePassword = value!;
                  },
                  onSaved: (value) {
                    context
                        .read<RegisterCubit>()
                        .updateUserInfo(password: value ?? '');
                  },
                  label: "Re-type new Password".tr()))
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
