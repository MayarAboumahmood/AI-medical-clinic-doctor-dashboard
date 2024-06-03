import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_images/app_images.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_string/app_string.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/view/widgets/steps_widget/navigat_button.dart';
import 'package:graduation_project_therapist_dashboard/app/features/registration_data_complete/cubit/registration_data_complete_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/registration_data_complete/data_sorce/models/complete_register_model.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/validation_functions.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/select_state_drop_down.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/text_fields/text_field.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class CompleteDataPage extends StatefulWidget {
  const CompleteDataPage({super.key});

  @override
  State<CompleteDataPage> createState() => _CompleteDataPageState();
}

class _CompleteDataPageState extends State<CompleteDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: customColors.primaryBackGround,
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [buildCompleteYourDataBody(context)],
          ),
        ));
  }

  Widget buildCompleteYourDataBody(BuildContext context) {
    RegistrationDataCompleteCubit registrationDataCompleteCubit =
        context.read<RegistrationDataCompleteCubit>();

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: responsiveUtil.screenHeight * .04,
          horizontal: responsiveUtil.screenWidth * .04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: responsiveUtil.padding(
                responsiveUtil.screenWidth * .012, 0, 0, 0),
            child: Text(
              "${'Complete your data to become active in the system'.tr()} ",
              textAlign: TextAlign.center,
              style: customTextStyle.bodyMedium.copyWith(
                fontSize: 14,
                letterSpacing: 0.2,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          completeDataImage(),
          SizedBox(
            height: responsiveUtil.screenHeight * .05,
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                selectCityDropDown(registrationDataCompleteCubit.selectedState,
                    (String? newValue) {
                  setState(() {
                    registrationDataCompleteCubit.selectedState = newValue;
                  });
                }),
                locationInfoTextField(context),
                clinicNameTextField(context),
                studiesInfoTextField(context),
                specializationInfoTextField(context),
                const SizedBox(
                  height: 10,
                ),
                multiSelectedSpeciality(context),
                navigateButton(() {
                  FormState? formdata = formKey.currentState;
                  if (formdata!.validate()) {
                    formdata.save();
                    navigationService.navigateTo(selectLocationMapPage);
                  }
                }, AppString.continueButton.tr(), false),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  MultiSelectDialogField<String> multiSelectedSpeciality(BuildContext context) {
    RegistrationDataCompleteCubit registrationDataCompleteCubit =
        context.read<RegistrationDataCompleteCubit>();
    return MultiSelectDialogField(
      buttonIcon: Icon(Icons.arrow_drop_down_circle_outlined,
          color: customColors.primaryText),
      confirmText: Text(
        'Confirm',
        style: customTextStyle.bodyMedium.copyWith(color: customColors.primary),
      ),
      items: medicalSpecialties.map((e) => MultiSelectItem(e, e)).toList(),
      listType: MultiSelectListType.LIST,
      backgroundColor: customColors.primaryBackGround,
      title: Text(
        'choose your specialization',
        style: customTextStyle.titleMedium,
      ),
      closeSearchIcon: Icon(
        Icons.close,
        color: customColors.primaryText,
      ),
      isDismissible: true,
      searchIcon: Icon(
        Icons.search,
        color: customColors.primaryText,
      ),
      separateSelectedItems: true,
      unselectedColor: customColors.secondaryText,
      validator: (listOfSpecialization) {
        return ValidationFunctions.specializationValidation(
            listOfSpecialization);
      },
      cancelText: Text(
        'cancel',
        style: customTextStyle.bodyMedium,
      ),
      searchHint: 'Search on your Specialization',
      searchHintStyle: customTextStyle.bodyMedium,
      checkColor: Colors.white,
      buttonText: Text(
        'choose your specialization',
        style: customTextStyle.bodyMedium,
      ),
      selectedColor: customColors.primary,
      searchTextStyle: customTextStyle.bodyMedium,
      selectedItemsTextStyle: customTextStyle.bodyMedium,
      itemsTextStyle: customTextStyle.bodyMedium,
      searchable: true,
      onConfirm: (values) {
        registrationDataCompleteCubit.updateSelectedMedicalSpecialty(values);
      },
      onSaved: (values) {
        registrationDataCompleteCubit.updateSelectedMedicalSpecialty(values!);
      },
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: customColors.secondaryBackGround),
          color: customColors.secondaryBackGround),
    );
  }

  Padding locationInfoTextField(BuildContext context) {
    RegistrationDataCompleteCubit registrationDataCompleteCubit =
        context.read<RegistrationDataCompleteCubit>();
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: customTextField(
                  textInputType: TextInputType.text,
                  validator: (value) {
                    return ValidationFunctions.informationValidation(value!);
                  },
                  context: context,
                  onSaved: (value) {
                    registrationDataCompleteCubit.updateLocationInfo(value);
                  },
                  label: "Location Information".tr()))
        ],
      ),
    );
  }

  Padding clinicNameTextField(BuildContext context) {
    RegistrationDataCompleteCubit registrationDataCompleteCubit =
        context.read<RegistrationDataCompleteCubit>();
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: customTextField(
                  textInputType: TextInputType.text,
                  validator: (value) {
                    return ValidationFunctions.informationValidation(value!);
                  },
                  context: context,
                  onSaved: (value) {
                    registrationDataCompleteCubit.updateClinicName(value);
                  },
                  label: "Clinic name".tr()))
        ],
      ),
    );
  }

  Padding studiesInfoTextField(BuildContext context) {
    RegistrationDataCompleteCubit registrationDataCompleteCubit =
        context.read<RegistrationDataCompleteCubit>();

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: customTextField(
                  textInputType: TextInputType.text,
                  validator: (value) {
                    return ValidationFunctions.informationValidation(value!);
                  },
                  context: context,
                  onSaved: (value) {
                    registrationDataCompleteCubit.updateStudiesInfo(value);
                  },
                  label: "Studies Information".tr()))
        ],
      ),
    );
  }

  Padding specializationInfoTextField(BuildContext context) {
    RegistrationDataCompleteCubit registrationDataCompleteCubit =
        context.read<RegistrationDataCompleteCubit>();

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: customTextField(
                  textInputType: TextInputType.text,
                  validator: (value) {
                    return ValidationFunctions.informationValidation(value!);
                  },
                  context: context,
                  onSaved: (value) {
                    registrationDataCompleteCubit.updateSpecialtyInfo(value);
                  },
                  label: "Specialization Information".tr()))
        ],
      ),
    );
  }

  Padding completeDataImage() {
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
