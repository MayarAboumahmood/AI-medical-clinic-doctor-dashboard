import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/view/widgets/select_time_date_bottomsheet.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/show_bottom_sheet.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/choose_time.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class PickTImeContainer extends StatefulWidget {
  const PickTImeContainer({super.key});

  @override
  State<PickTImeContainer> createState() => _PickTImeContainerState();
}

class _PickTImeContainerState extends State<PickTImeContainer> {
  String selectedTime = DateFormat('HH:mm:ss').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return pickTImeContainer(selectedTime);
  }

  GestureDetector pickTImeContainer(String time) {
    return GestureDetector(
      onTap: () async {
        print('ssssssssssssssssssss: skdlfjsdlkfj');
        await showBottomSheetWidget(context, const SelectTimeDateBottomSheet());

        buildChooseTime(context, time, (newDateTime) {
          setState(() {
            selectedTime = newDateTime;
          });
        });
        navigationService.goBack();
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
