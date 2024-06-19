import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_string/app_string.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/bloc/register_cubit/register_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/bloc/register_cubit/register_state.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/bloc/sign_in_cubit/sign_in_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/view/widgets/join_signIn_screen/term_privacy.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/format_the_syrain_number.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/get_status_request_from_status_code.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/validation_functions.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/cancel_button.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/selected_gender_drop_down.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/text_fields/text_field.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class JoinWidget extends StatefulWidget {
  const JoinWidget({super.key});

  @override
  State<JoinWidget> createState() => _JoinWidgetState();
}

class _JoinWidgetState extends State<JoinWidget> {
  String? errorMessage;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late RegisterCubit registerCubit;
  bool isTermsAccepted = false;
  void toggleTermsCheckbox() {
    setState(() {
      isTermsAccepted = !isTermsAccepted;
    });
  }

  @override
  void initState() {
    super.initState();
    registerCubit = context.read<RegisterCubit>();
    registerCubit.passwordtextgController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return buildRegisterBlocConsumer();
  }

  BlocConsumer<RegisterCubit, RegisterState> buildRegisterBlocConsumer() {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is SuccessRequest) {
          navigationService.navigateTo(oTPCodeStep);
        } else if (state is RegisterPhoneNumberNotVerifiedState) {
          navigationService.navigateTo(oTPCodeStep);
        }
      },
      builder: (context, state) {
        if (state is RegisterValidationErrorRequest) {
          errorMessage = getMessageFromStatus(state.statusRequest);
        }
        bool isLoading = state is RegisterLoadingState;
        return buildRegisterBottomSheetBody(isLoading, context, state);
      },
    );
  }

  PopScope buildRegisterBottomSheetBody(
      bool isLoading, BuildContext context, RegisterState state) {
    return PopScope(
      onPopInvoked: (popScopePopEvent) {
        isLoading = false;
      },
      child: SingleChildScrollView(
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
                          const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                      child: _buildBodyJoin(context, isLoading, state)),
                  errorMessage != null
                      ? Padding(
                          padding: const EdgeInsets.only(
                              top: 10, right: 20, left: 20),
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
      ),
    );
  }

  Widget _buildBodyJoin(BuildContext context, bool loading, state) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildCancelButton(context),
          joinTextWidget(),
          joinOurCommintyTextWidget(),
          firstLastNameTextFieldRow(),
          emailTextField(),
          phoneNumberTextField(),
          const SizedBox(
            height: 20,
          ),
          selectSpecialtyDropDown(),
          const SizedBox(
            height: 15,
          ),
          selectGenderDropDown(
            registerCubit.getSelectedGender(),
            (String? newValue) {
              setState(() {});
              registerCubit.setGender(newValue!);
            },
          ),
          byJoiningOurTimeTextWidget(),
          buildTermPrivacy(isTermsAccepted, toggleTermsCheckbox, context),
          buildJoinButton(
            loading,
          ),
        ],
      ),
    );
  }

  Padding byJoiningOurTimeTextWidget() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 10),
      child: Text(
        AppString.byjoining.tr(),
        style: customTextStyle.bodyMedium.copyWith(
          color: customColors.secondaryText,
          fontSize: 10,
        ),
      ),
    );
  }

  Padding emailTextField() {
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
                    return ValidationFunctions.isValidEmail(value!);
                  },
                  context: context,
                  onSaved: (value) {
                    context
                        .read<RegisterCubit>()
                        .updateUserInfo(userEmail: value ?? '');
                  },
                  label: AppString.emailAdress.tr()))
        ],
      ),
    );
  }

  Padding phoneNumberTextField() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: customTextField(
                  textInputType: TextInputType.phone,
                  validator: (value) {
                    return ValidationFunctions.validateSyrianPhoneNumber(
                        value!);
                  },
                  context: context,
                  onSaved: (value) {
                    registerCubit.updateUserInfo(
                        phoneNumber:
                            formatSyrianPhoneNumberForMakeItStartWIth09(
                                value ?? ''));
                  },
                  label: AppString.mobilePhone.tr()))
        ],
      ),
    );
  }

  Padding firstLastNameTextFieldRow() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: customTextField(
                  textInputType: TextInputType.name,
                  validator: (value) {
                    return ValidationFunctions.nameValidation(value);
                  },
                  context: context,
                  onSaved: (value) {
                    BlocProvider.of<RegisterCubit>(context)
                        .updateUserInfo(firstName: value!);
                  },
                  label: AppString.firstName.tr())),
          const SizedBox(width: 5),
          Expanded(
              child: customTextField(
                  textInputType: TextInputType.name,
                  validator: (value) {
                    return ValidationFunctions.nameValidation(value);
                  },
                  context: context,
                  onSaved: (value) {
                    BlocProvider.of<RegisterCubit>(context)
                        .updateUserInfo(lastName: value!);
                  },
                  label: AppString.lastName.tr())),
        ],
      ),
    );
  }

  Padding joinOurCommintyTextWidget() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
      child: Text(
        AppString.joinUs.tr(),
        style: customTextStyle.bodyMedium,
      ),
    );
  }

  Text joinTextWidget() {
    return Text(
      'Join'.tr(),
      style: customTextStyle.bodyMedium.copyWith(
          fontSize: 25,
          fontWeight: FontWeight.w600,
          color: customColors.primaryText),
    );
  }

  Align buildJoinButton(bool loading) {
    return Align(
      alignment: const AlignmentDirectional(0.00, 1.00),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
        child: GeneralButtonOptions(
          loading: loading,
          onPressed: () async {
            FormState? formdata = formKey.currentState;
            if (isTermsAccepted) {
              if (formdata!.validate()) {
                formdata.save();
                if (!loading) {
                  navigationService.navigateTo(passwordStepPage);
                }
              }
            }
          },
          text: 'Join'.tr(),
          options: ButtonOptions(
            width: 350,
            height: 45,
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            color: isTermsAccepted
                ? customColors.primary
                : customColors.completeded,
            textStyle: customTextStyle.titleSmall.copyWith(
              color: Colors.white,
              fontSize: 16,
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

  Padding selectSpecialtyDropDown() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: customColors.secondaryBackGround)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: DropdownButtonFormField<String>(
            validator: (value) {
              return ValidationFunctions.dropDownValidation(value);
            },
            value: registerCubit.getRoleByID(),
            decoration: InputDecoration(
              hintStyle: customTextStyle.bodyMedium.copyWith(
                  color: customColors.primaryText,
                  fontWeight: FontWeight.w400,
                  fontSize: 12),
              labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: customColors.primary,
                    fontSize: 12,
                  ),
              labelText: 'Specialty:'.tr(),
              border: InputBorder.none,
            ),
            dropdownColor: customColors.primaryBackGround,
            items: specialtyList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value.tr(),
                  style: customTextStyle.bodySmall
                      .copyWith(color: customColors.primaryText),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                registerCubit.setRoleID(newValue!);
              });
            },
          ),
        ),
      ),
    );
  }

  List<String> specialtyList = ['Doctor'.tr(), 'Therapist'.tr()];
}
