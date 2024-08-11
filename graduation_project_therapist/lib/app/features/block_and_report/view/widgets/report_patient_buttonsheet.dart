import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/block_and_report/bloc/block_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/validation_functions.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/text_fields/text_field.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class ReportPatientBottomSheet extends StatefulWidget {
  final int patientID;
  final String patientName;

  const ReportPatientBottomSheet({
    required this.patientID,
    required this.patientName,
    Key? key,
  }) : super(key: key);

  @override
  _ReportPatientBottomSheetState createState() =>
      _ReportPatientBottomSheetState();
}

class _ReportPatientBottomSheetState extends State<ReportPatientBottomSheet> {
  String description = '';

  @override
  Widget build(BuildContext context) {
    BlockBloc blockBlock = context.read<BlockBloc>();

    return Container(
      padding: const EdgeInsets.all(20),
      height: responsiveUtil.screenHeight * .3,
      decoration: BoxDecoration(
        color: customColors.primaryBackGround,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('why do you want to report ${widget.patientName}?'.tr(),
                style: customTextStyle.bodyMedium),
            const SizedBox(height: 20),
            descriptionTextField(context),
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
                        print('ssssssssssssssssssssssss: $description');
                        blockBlock.add(ReportPatientEvent(
                            patientId: widget.patientID,
                            description: description));
                        navigationService.goBack();
                      },
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white))
                          : Text(
                              'Submit'.tr(),
                              style: customTextStyle.bodyMedium,
                            ),
                    );
                  },
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(customColors.error),
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Close the bottom sheet
                  },
                  child: Text(
                    'Cancel'.tr(),
                    style: customTextStyle.bodyMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget descriptionTextField(BuildContext context) {
    return customTextField(
        textInputType: TextInputType.emailAddress,
        validator: (value) {
          return ValidationFunctions.isValidEmail(value!);
        },
        context: context,
        onChanged: (value) {
          description = value ?? '';
        },
        hintText: 'Report'.tr(),
        label: 'tell us what is wrong'.tr());
  }
}
