import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_string/app_string.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/bloc/sign_in_cubit/sign_in_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/get_status_request_from_status_code.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/validation_functions.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/cancel_button.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/text_fields/password_textfield.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/text_fields/text_field.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({super.key});

  @override
  State<SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  String? errorMessage; // Variable to hold the error message

  late SignInCubit signInCubit;
  @override
  void initState() {
    super.initState();
    signInCubit = context.read<SignInCubit>();
    signInCubit.passwordtextgController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(listener: (context, state) {
      if (state is SuccessRequest) {
        navigationService.navigationOfAllPagesToName(
            context, bottomNavigationBar);
        Future.delayed(const Duration(seconds: 1), () {
          signInCubit.clearSignInCubit();
        });
        comingFromRegisterOrLogin = true;
      } else if (state is SignInaccountNotverifiedState) {
        customSnackBar('Your account not verified yet', context);
        signInCubit.sendEmailToGetOtp();
      } else if (state is ForgetPasswordSendingEmailSuccessState) {
        navigationService.navigationOfAllPagesToName(context, oTPCodeStep);
      }
    }, builder: (context, state) {
      if (state is SignInErrorRequeistState) {
        errorMessage = getMessageFromStatus(state.statusRequest);
      } else if (state is SignInFailureState) {
        errorMessage = state.errorMessage;
      }
      bool isLoading = state is SignInLoadingState;
      return PopScope(
        onPopInvoked: (popScopePopEvent) {
          isLoading = false;
        },
        child: Container(
            width: double.infinity,
            height: responsiveUtil.screenHeight * .8,
            decoration: BoxDecoration(
              color: customColors.primaryBackGround,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                      child: _BuildBodySignIn(loading: isLoading)),
                  // Conditionally display the error message
                  errorMessage != null
                      ? Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, right: 20),
                          child: Text(
                            errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 300,
                  ),
                ],
              ),
            )),
      );
    });
  }
}

class _BuildBodySignIn extends StatefulWidget {
  final bool loading;

  const _BuildBodySignIn({Key? key, required this.loading}) : super(key: key);

  @override
  State<_BuildBodySignIn> createState() => _BuildBodySignInState();
}

class _BuildBodySignInState extends State<_BuildBodySignIn> {
  bool passwordSecur = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late SignInCubit signInCubit;
  @override
  void initState() {
    super.initState();
    signInCubit = context.read<SignInCubit>();
    signInCubit.passwordtextgController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildCancelButton(context),
          Text(
            AppString.signIn.tr(),
            style: customTextStyle.bodyMedium.copyWith(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: customColors.primaryText),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
            child: Text(
              AppString.welcomBack.tr(),
              style: customTextStyle.bodyMedium,
            ),
          ),
          userEmailtextFeild(context),
          PasswordTextField(
              controller: signInCubit.passwordtextgController,
              label: AppString.enterPassword),
          const SizedBox(
            height: 25,
          ),
          buildforgetPasswordText(),
          const SizedBox(
            height: 25,
          ),
          buildSignInButton(context),
        ],
      ),
    );
  }

  Align buildSignInButton(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0.00, 1.00),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
        child: GeneralButtonOptions(
          onPressed: () async {
            FormState? formdata = formKey.currentState;
            if (formdata!.validate()) {
              formdata.save();
              if (!widget.loading) {
                BlocProvider.of<SignInCubit>(context).sendSignInRequest();
              }
            }
          },
          text: AppString.signIn.tr(),
          loading: widget.loading,
          options: ButtonOptions(
            width: 350,
            height: 45,
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            color: customColors.primary,
            textStyle: customTextStyle.titleSmall.copyWith(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
            borderSide: const BorderSide(
              color: Colors.transparent,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }

  GestureDetector buildforgetPasswordText() {
    return GestureDetector(
      onTap: () {
        navigationService.navigationOfAllPagesToName(
          context,
          forgetPasswordEmail,
        );
      },
      child: Row(
        children: [
          Text(
            'Forget Password? '.tr(),
            style: customTextStyle.bodyMedium
                .copyWith(color: customColors.primary),
          ),
          Text(
            ' Send me a code. '.tr(),
            style: customTextStyle.bodySmall,
          ),
        ],
      ),
    );
  }

  Padding userEmailtextFeild(BuildContext context) {
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
                    return ValidationFunctions.isValidEmail(value ?? '');
                  },
                  context: context,
                  onChanged: (value) {
                    BlocProvider.of<SignInCubit>(context).setUserEmail(value!);
                  },
                  label: AppString.emailAdress.tr())),
        ],
      ),
    );
  }
}
