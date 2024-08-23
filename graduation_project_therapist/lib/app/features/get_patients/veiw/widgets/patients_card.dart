import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/features/block_and_report/bloc/block_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/block_and_report/view/widgets/patient_card_option__munie.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_patients/data_source/models/get_patients_model.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/image_widgets/network_image.dart';

import 'package:graduation_project_therapist_dashboard/main.dart';

Widget patientsCard(BuildContext context, GetPatientsModel getPatientsModel,
    {bool isFromBlock = false, String date = 'Unkown'}) {
  return Card(
    color: customColors.primaryBackGround,
    elevation: 4,
    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildPatientNameAndImage(context, getPatientsModel, isFromBlock,date),
        const SizedBox(height: 20),
      ],
    ),
  );
}

Widget removeEmploymentBottomSheet(
    BuildContext context, String employeeName, int therapistId) {
  return SizedBox(
      height: responsiveUtil.screenHeight * .22,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
                color: customColors.primaryBackGround,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                )),
            height: responsiveUtil.screenHeight * .22,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Container(
                      height: 3,
                      width: 40,
                      color: customColors.secondaryBackGround,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                      child: Text(
                    'Are you sure you want to remove $employeeName?'.tr(),
                    style: customTextStyle.bodyLarge
                        .copyWith(fontWeight: FontWeight.w700),
                  )),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ));
}

GeneralButtonOptions cancelLogOutButton(BuildContext context) {
  return GeneralButtonOptions(
    text: 'Cancel'.tr(),
    onPressed: () {
      navigationService.goBack();
    },
    options: ButtonOptions(
      height: 40,
      color: customColors.primaryBackGround,
      textStyle:
          customTextStyle.titleSmall.copyWith(color: customColors.primaryText),
      borderSide: BorderSide(
        color: customColors.primary,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
  );
}

GestureDetector buildPatientNameAndImage(
    BuildContext context, GetPatientsModel patientsModel, bool isFromBlock,String date) {
  return GestureDetector(
    onTap: () {
      navigationService.navigateTo(userProfilePage,
          arguments: patientsModel.id);
    },
    child: Column(
      children: [
        Row(
          children: [
            Container(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: getImageNetwork(
                    forProfileImage: true,
                    url: 'patientsModel.photo',
                    width: 65,
                    height: 65,
                    fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 16),
            Text(patientsModel.name, style: customTextStyle.bodyLarge),
            const Spacer(),
            isFromBlock
                ? const SizedBox()
                : buildOptionsMenu(
                    context, patientsModel.id, patientsModel.name),
          ],
        ),
        Visibility(visible: isFromBlock, child: Text("${'Date'.tr()}: $date")),
        enterChatButton1(context, patientsModel, isFromBlock),
      ],
    ),
  );
}

Row optionMenu(BuildContext context, GetPatientsModel patientsModel) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      buildOptionsMenu(context, patientsModel.id, patientsModel.name),
    ],
  );
}

Widget enterChatButton1(
    BuildContext context, GetPatientsModel patientsModel, bool isFromBlock) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      enterChatUnBlockButton(isFromBlock, patientsModel, context),
      const SizedBox(
        height: 5,
      )
    ],
  );
}

GeneralButtonOptions enterChatUnBlockButton(
    bool isFromBlock, GetPatientsModel patientsModel, BuildContext context) {
  return GeneralButtonOptions(
    text: isFromBlock ? "Unblock Patient" : 'Enter Chat',
    onPressed: isFromBlock
        ? () {
            context.read<BlockBloc>().add(UnBlocPatientEvent(
                patientId: patientsModel.id,
                blockedPatientName: patientsModel.name));
          }
        : () {
            navigationService.navigateTo(chatInitPage,
                arguments: patientsModel.id);
          },
    options: ButtonOptions(
        textStyle: customTextStyle.bodyMedium, color: customColors.primary),
  );
}
