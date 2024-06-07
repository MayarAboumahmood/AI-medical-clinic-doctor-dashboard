import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_string/app_string.dart';
import 'package:graduation_project_therapist_dashboard/app/core/utils/flutter_flow_util.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/bloc/profile_state.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/check_if_rtl.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/validation_functions.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/text_fields/text_field.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

import '../bloc/profile_event.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool _isOldPasswordWrong = false;

  bool passwordSecur1 = false;
  bool passwordSecur2 = false;
  bool passwordSecur3 = false;
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _retypeNewPasswordController =
      TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    BlocProvider.of<ProfileBloc>(context).add(const ChangePasswordInitEvent());
    super.initState();
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _retypeNewPasswordController.dispose();
    super.dispose();
  }

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (popScopePopEvent) async {
        BlocProvider.of<ProfileBloc>(context)
            .add(const ChangePasswordInitEvent());
      },
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is PasswordEditedState) {
            Future.delayed(const Duration(milliseconds: 400), () {
              navigationService.goBack();
              customSnackBar('your password has been changed'.tr(), context,
                  isFloating: true);
            });
          } else if (state is ServerErrorRequest) {
            customSnackBar(state.errorMessage, context);
          }
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: customColors.primaryBackGround,
            body: Form(
              key: globalKey,
              child: SingleChildScrollView(
                child: Column(
                    children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                        alignment: isRTL(context)
                            ? Alignment.topRight
                            : Alignment.topLeft,
                        child: Text('Change password'.tr(),
                            style: customTextStyle.headlineLarge.copyWith(
                                color: customColors.secondaryText,
                                fontWeight: FontWeight.normal))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      AppString.changePasswordTitle.tr(),
                      style: customTextStyle.bodyMedium.copyWith(
                          color: customColors.secondaryText,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  passwordTextField(context, 'Current Password',
                      _currentPasswordController, _isOldPasswordWrong, 1),
                  passwordTextField(context, 'New Password',
                      _newPasswordController, false, 2),
                  passwordTextField(context, 'Re-type new Password',
                      _retypeNewPasswordController, false, 3),
                  const SizedBox(
                    height: 350,
                  ),
                  BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                    isLoading = state is LoadingRequest;
                    
                    return saveButton(context);
                  }),
                  const SizedBox(
                    height: 30,
                  )
                ].divide(const SizedBox(
                  height: 10,
                ))),
              ),
            ),
          ),
        ),
      ),
    );
  }

  GeneralButtonOptions saveButton(BuildContext context) {
    return GeneralButtonOptions(
        onPressed: () {
          FormState? formState = globalKey.currentState;
          isLoading
              ? () {}
              : {
                  if (formState!.validate())
                    {
                      formState.save(),
                      BlocProvider.of<ProfileBloc>(context)
                          .add(ResetPasswordEvent(
                        newPassword: _newPasswordController.text,
                        oldPassword: _currentPasswordController.text,
                      ))
                    }
                };
        },
        text: 'Save'.tr(),
        loading: isLoading,
        options: ButtonOptions(
          width: 150,
          height: 45,
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
          borderRadius: BorderRadius.circular(10),
        ));
  }

  Padding passwordTextField(BuildContext context, String label,
      TextEditingController controller, bool isError, int type) {
    String? errorMessage = isError && label == 'Current Password'
        ? 'The old password is not correct'.tr()
        : null;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: customTextField(
          validator: (value) {
            if (type == 3 /*'Re-type new Password'*/) {
              return ValidationFunctions.isNewPasswordEqualreType(
                  value!, _newPasswordController.text);
            } else if (isError && type == 1) {
              errorMessage = 'The old password is not correct'.tr();
              return null;
            }

            return null;
          },
          textInputType: TextInputType.visiblePassword,
          errorText: errorMessage,
          controller: controller,
          context: context,
          isPassWordInVisible: type == 1
              ? passwordSecur1
              : type == 2
                  ? passwordSecur2
                  : passwordSecur3,
          suffixIcon: GestureDetector(
            onTap: () {
           
              setState(() {
                type == 1
                    ? passwordSecur1 = !passwordSecur1
                    : type == 2
                        ? passwordSecur2 = !passwordSecur2
                        : passwordSecur3 = !passwordSecur3;
              });
            },
            child: Icon(
              type == 1
                  ? passwordSecur1
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined
                  : type == 2
                      ? passwordSecur2
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined
                      : passwordSecur3
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
              color: customColors.secondaryText,
              size: 18,
            ),
          ),
          borderSideColor:
              isError && label == 'Current Password' ? Colors.red : null,
          label: label.tr()),
    );
  }
}
