import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/cubit/patient_requests_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/show_date_picker_widget.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class PickDayContainer extends StatefulWidget {
  final void Function(String selectedDate)? whatBlocShouldDoOnTap;
  const PickDayContainer({super.key, required this.whatBlocShouldDoOnTap});

  @override
  State<PickDayContainer> createState() => _PickDayContainerState();
}

class _PickDayContainerState extends State<PickDayContainer> {
  late DateTime selectedDay;
  late PatientRequestsCubit patientRequestsCubit;
  late String selectedDayString;
  @override
  initState() {
    patientRequestsCubit = context.read<PatientRequestsCubit>();
    super.initState();
    selectedDay = DateTime.now();
    selectedDayString = DateFormat('yyyy/MM/dd').format(selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    return pickDayContainer();
  }

  GestureDetector pickDayContainer() {
    return GestureDetector(
      onTap: () {
        buildChooseDate(
          context,
          selectedDay,
          (newDateTime) {
            selectedDay = newDateTime;
            setState(() {
              selectedDayString = DateFormat('yyyy/MM/dd').format(newDateTime);
            });
            widget.whatBlocShouldDoOnTap?.call(selectedDayString);
            navigationService.goBack();
          },
        );
      },
      child: Container(
        width: responsiveUtil.screenWidth * .3,
        decoration: BoxDecoration(
          border: Border.all(
            color: customColors.primary,
            width: 1,
          ),
          color: customColors.primaryBackGround,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Row(
            children: [
              Text(
                'Day'.tr(),
                style: customTextStyle.bodyMedium
                    .copyWith(color: customColors.primary),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                selectedDayString,
                style: customTextStyle.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
