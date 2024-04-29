import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/view/widgets/pick_time_container.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class SelectTimeDateBottomSheet extends StatelessWidget {
  const SelectTimeDateBottomSheet({super.key});

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
        child:
         Column(
          children: [
            const SizedBox(height: 20,),
              const PickTImeContainer(),
              SizedBox(
              child: Text(
                'Time',
                style: customTextStyle.bodyMedium,
              ),
            ), //TODO implement select time
          ],
        ),
      ),
    );
  }
}
