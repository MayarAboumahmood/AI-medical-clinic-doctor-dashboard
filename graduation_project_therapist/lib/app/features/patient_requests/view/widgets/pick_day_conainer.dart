import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/cubit/patient_requests_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/show_date_picker_widget.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class PickDayContainer extends StatefulWidget {
  final void Function(String selectedDate)? whatBlocShouldDoOnTap;
  final double paddingInVertical;
  final double paddingInHorizontal;
  final DatePickType datePickType;

  const PickDayContainer(
      {super.key,
      required this.whatBlocShouldDoOnTap,
      required this.datePickType,
      this.paddingInVertical = 15,
      this.paddingInHorizontal = 10});

  @override
  State<PickDayContainer> createState() => _PickDayContainerState();
}

class _PickDayContainerState extends State<PickDayContainer> {
  late DateTime selectedDay;

  late String selectedDayString;
  @override
  initState() {
    super.initState();
    print('init state in pick day container');

    selectedDay = DateTime.now();
    selectedDayString = DateFormat('yyyy-MM-dd').format(selectedDay);
    context.read<PatientRequestsCubit>().setSelectedDay(selectedDayString);
    String? selectedTime = DateFormat('hh:mm a').format(DateTime.now());
    context.read<PatientRequestsCubit>().setSelectedTime(selectedTime);
  }

  @override
  Widget build(BuildContext context) {
    return pickDayContainer();
  }

  GestureDetector pickDayContainer() {
    return GestureDetector(
      onTap: () {
        buildChooseDate(context, selectedDay, (newDateTime) {
          selectedDay = newDateTime;
          setState(() {
            selectedDayString = DateFormat('yyyy-MM-dd').format(newDateTime);
          });
          widget.whatBlocShouldDoOnTap?.call(selectedDayString);
          navigationService.goBack();
        }, widget.datePickType);
      },
      child: Container(
        width: responsiveUtil.screenWidth * .45,
        decoration: BoxDecoration(
          border: Border.all(
            color: customColors.primary,
            width: 1,
          ),
          color: customColors.primaryBackGround,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: widget.paddingInVertical,
              horizontal: widget.paddingInHorizontal),
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
