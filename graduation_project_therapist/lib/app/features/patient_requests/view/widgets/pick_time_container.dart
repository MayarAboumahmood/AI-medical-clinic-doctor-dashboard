import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/cubit/patient_requests_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/choose_time.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class PickTImeContainer extends StatefulWidget {
  const PickTImeContainer({super.key});

  @override
  State<PickTImeContainer> createState() => _PickTImeContainerState();
}

class _PickTImeContainerState extends State<PickTImeContainer> {
  late PatientRequestsCubit patientRequestsCubit;
  late String selectedTime;
  @override
  initState() {
    super.initState();
    patientRequestsCubit = context.read<PatientRequestsCubit>();
    selectedTime = DateFormat('hh:mm a').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return pickTImeContainer(selectedTime);
  }

  GestureDetector pickTImeContainer(String time) {
    return GestureDetector(
      onTap: () {
        buildChooseTime(context, time, (newDateTime) {
          patientRequestsCubit.setSelectedTime(newDateTime);
          setState(() {
            selectedTime = newDateTime;
          });
          navigationService.goBack();
        });
      },
      child: Container(
        width: responsiveUtil.screenWidth * .32,
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
                'Time'.tr(),
                style: customTextStyle.bodyMedium
                    .copyWith(color: customColors.primary),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                time,
                style: customTextStyle.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
