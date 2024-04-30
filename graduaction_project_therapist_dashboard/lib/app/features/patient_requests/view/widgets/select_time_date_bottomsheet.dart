import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/cubit/patient_requests_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/view/widgets/pick_day_conainer.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/view/widgets/pick_time_container.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class SelectTimeDateBottomSheet extends StatefulWidget {
  const SelectTimeDateBottomSheet({super.key});

  @override
  State<SelectTimeDateBottomSheet> createState() =>
      _SelectTimeDateBottomSheetState();
}

class _SelectTimeDateBottomSheetState extends State<SelectTimeDateBottomSheet> {
  late PatientRequestsCubit patientRequestsCubit;
  @override
  initState() {
    patientRequestsCubit = context.read<PatientRequestsCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientRequestsCubit, PatientRequestsState>(
      listener: (context, state) {
    if(state is PatientRequestApprovedSuccessfullyState){
      customSnackBar('session confirmed Successfully', context);
    }
      },
      child: Container(
        width: responsiveUtil.screenWidth,
        height: responsiveUtil.screenHeight * .3,
        decoration: BoxDecoration(
            color: customColors.primaryBackGround,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10))),
        child: const SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              PickTImeContainer(),
              SizedBox(
                height: 20,
              ),
              PickDayContainer(),
            ],
          ),
        ),
      ),
    );
  }

  GeneralButtonOptions rejectButton(BuildContext context) {
    return GeneralButtonOptions(
      text: 'Reject'.tr(),
      options: ButtonOptions(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: customColors.error,
          width: 1,
        ),
        color: customColors.primaryBackGround,
        textStyle:
            customTextStyle.bodyMedium.copyWith(color: customColors.error),
      ),
      onPressed: () async {
        navigationService.goBack();
      },
    );
  }

  GeneralButtonOptions doneButton(BuildContext context) {
    return GeneralButtonOptions(
      text: 'Done'.tr(),
      options: ButtonOptions(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: customColors.error,
          width: 1,
        ),
        color: customColors.primaryBackGround,
        textStyle:
            customTextStyle.bodyMedium.copyWith(color: customColors.error),
      ),
      onPressed: () async {
        navigationService.goBack();
        patientRequestsCubit.approveOnPatientRequest();
      },
    );
  }
}
