import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/cubit/patient_requests_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/view/widgets/pick_day_conainer.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/view/widgets/pick_time_container.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/show_date_picker_widget.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class SelectTimeDateBottomSheet extends StatefulWidget {
  const SelectTimeDateBottomSheet({super.key, required this.requestID});
  final int requestID;
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
    return Container(
      width: responsiveUtil.screenWidth,
      height: responsiveUtil.screenHeight * .3,
      decoration: BoxDecoration(
          color: customColors.primaryBackGround,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10))),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const PickTImeContainer(),
            const SizedBox(
              height: 20,
            ),
            PickDayContainer(
                whatBlocShouldDoOnTap: (selectedDate) {
                  patientRequestsCubit.setSelectedDay(selectedDate);
                },
                datePickType: DatePickType.reservationDay),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                cancelButton(context),
                SizedBox(
                  width: responsiveUtil.screenWidth * .1,
                ),
                doneButton(context)
              ],
            )
          ],
        ),
      ),
    );
  }

  GeneralButtonOptions cancelButton(BuildContext context) {
    return GeneralButtonOptions(
      text: 'Cancel'.tr(),
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

  Widget doneButton(BuildContext context) {
    return BlocBuilder<PatientRequestsCubit, PatientRequestsState>(
      builder: (context, state) {
        bool isLoading = state is PatientRequestAcceptLoadingState;
        return GeneralButtonOptions(
          text: 'Done'.tr(),
          loading: isLoading,
          options: ButtonOptions(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: customColors.primary,
              width: 1,
            ),
            color: customColors.primary,
            textStyle: customTextStyle.bodyMedium,
          ),
          onPressed: () async {
            navigationService.goBack();
            patientRequestsCubit.acceptPatientRequest(widget.requestID);
          },
        );
      },
    );
  }
}
