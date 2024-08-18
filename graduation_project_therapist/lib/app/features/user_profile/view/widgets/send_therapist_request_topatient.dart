import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/cubit/get_all_therapist_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/view/widgets/choose_time.dart';
import 'package:graduation_project_therapist_dashboard/app/features/user_profile/cubit/user_profile_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/show_date_picker_widget.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/text_fields/text_field.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

void therapistRequestToPatientDialog(BuildContext context, int patientID) {
  GetAllTherapistCubit getAllTherapistCubit =
      context.read<GetAllTherapistCubit>();
  getAllTherapistCubit.getMyTherapist(patientID);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: customColors.primaryBackGround,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const ChooseDateWidget(),
                  const SizedBox(
                    height: 10,
                  ),
                  const ChooseTimeWidget(),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: customTextField(
                        context: context,
                        label: 'Description',
                        onChanged: (description) {
                          context.read<UserProfileCubit>().description =
                              description!;
                        }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GeneralButtonOptions(
                      text: 'Send request',
                      onPressed: () {
                        context
                            .read<UserProfileCubit>()
                            .therapistRequestToPateint(
                              patientID,
                            );
                        navigationService.goBack();
                      },
                      options: ButtonOptions(
                          color: customColors.primary,
                          textStyle: customTextStyle.bodyMedium))
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

class ChooseDateWidget extends StatefulWidget {
  const ChooseDateWidget({
    super.key,
  });

  @override
  ChooseDateWidgetState createState() => ChooseDateWidgetState();
}

class ChooseDateWidgetState extends State<ChooseDateWidget> {
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: GestureDetector(
          onTap: () {
            buildChooseDate(context, dateTime, (newDateTime) {
              setState(() {
                dateTime = newDateTime;
              });
              context.read<UserProfileCubit>().date =
                  DateFormat('yyyy-MM-dd').format(dateTime);
              navigationService.goBack();
            }, DatePickType.reservationDay);
          },
          child: Container(
            height: 50,
            width: responsiveUtil.screenWidth,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: customColors.secondaryBackGround)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text(
                      'Date: '.tr(),
                      style: customTextStyle.bodyMedium.copyWith(
                        color: customColors.primaryText,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      DateFormat('yyyy-MM-dd').format(dateTime),
                      style: customTextStyle.bodyMedium.copyWith(
                        color: customColors.primary,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.date_range,
                      color: customColors.primaryText,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChooseTimeWidget extends StatefulWidget {
  const ChooseTimeWidget({
    super.key,
  });

  @override
  ChooseTimeWidgetState createState() => ChooseTimeWidgetState();
}

class ChooseTimeWidgetState extends State<ChooseTimeWidget> {
  String time = DateFormat("h:mm a").format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: GestureDetector(
          onTap: () {
            buildChooseTime(
              context,
              time,
              (newTime) {
                setState(() {
                  time = newTime;
                });
                context.read<UserProfileCubit>().time = time;

                navigationService.goBack();
              },
            );
          },
          child: Container(
            height: 50,
            width: responsiveUtil.screenWidth,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: customColors.secondaryBackGround)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text(
                      'Time: '.tr(),
                      style: customTextStyle.bodyMedium.copyWith(
                        color: customColors.primaryText,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      time,
                      style: customTextStyle.bodyMedium.copyWith(
                        color: customColors.primary,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.date_range,
                      color: customColors.primaryText,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
