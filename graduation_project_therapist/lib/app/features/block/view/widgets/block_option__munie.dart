import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/features/block/bloc/block_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/show_bottom_sheet.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Widget buildOptionsMenu(
    BuildContext context, int patientID, String patientName) {
  return PopupMenuButton<String>(
    color: customColors.secondaryBackGround,
    icon: CircleAvatar(
        backgroundColor: customColors.primary,
        child: Icon(
          Icons.more_vert,
          color: customColors.primaryText,
        )),
    onSelected: (value) async {
      if (value == 'block') {
        await showBottomSheetWidget(
            context,
            showConfirmBlockBottomSheet(
              context,
              patientID,
              patientName,
            ));
      } else if (value == 'profile') {
        navigationService.navigateTo(userProfilePage,
            arguments: patientID);
      }
    },
    itemBuilder: (BuildContext context) {
      return [
        PopupMenuItem<String>(
          value: 'profile',
          child: patientOptionText('View user profile'),
        ),
        PopupMenuItem<String>(
          value: 'block',
          child: patientOptionText('Block this patient'),
        ),
        // Add more options here if needed
      ];
    },
  );
}

Widget showConfirmBlockBottomSheet(
    BuildContext context, int patientID, String patientName) {
  BlockBloc blockBlock = context.read<BlockBloc>();
  return Container(
    padding: const EdgeInsets.all(20),
    height: 160,
    decoration: BoxDecoration(
      color: customColors.primaryBackGround,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Are you sure you want to Block $patientName?'.tr(),
            style: customTextStyle.bodyMedium),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BlocBuilder<BlockBloc, BlockState>(
              builder: (context, state) {
                bool isLoading = state is BlocedPatientLoadingState;
                return ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(customColors.primary),
                  ),
                  onPressed: () {
                    blockBlock.add(BlockPatientEvent(patientId: patientID));
                    navigationService.goBack();
                  },
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.white))
                      : Text(
                          'Yes'.tr(),
                          style: customTextStyle.bodyMedium,
                        ),
                );
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(customColors.error),
              ),
              onPressed: () {
                Navigator.pop(context); // Close the bottom sheet
              },
              child: Text(
                'No'.tr(),
                style: customTextStyle.bodyMedium,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}


Text patientOptionText(String title) => Text(
      title.tr(),
      style: customTextStyle.bodyMedium,
    );
