import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/features/block_and_report/view/widgets/patient_card_option__munie.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/view/widgets/select_time_date_bottomsheet.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_reservations/cubit/patient_reservations_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_reservations/data_source/models/patient_reservation_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/video_call/bloc/video_call_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/show_bottom_sheet.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/validation_functions.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/image_widgets/network_image.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/text_fields/text_field.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

Widget patientReservationCard(
    BuildContext context, PatientReservationModel patientReservationModel) {
  DateTime dateTime = DateTime.parse(patientReservationModel.date);
  String formattedDate = DateFormat('yyyy-MM-dd h:mm a').format(dateTime);
  PatientReservationsCubit patientReservationsCubit =
      context.read<PatientReservationsCubit>();
  var nowTime = DateTime.parse(patientReservationModel.date);
  String formattedDateTime =
      DateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS").format(nowTime);

  bool canEnterTheSession = patientReservationsCubit
      .checkIfSessionIsNear(DateTime.parse(formattedDateTime));

  return Card(
    color: customColors.primaryBackGround,
    elevation: 4,
    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: const EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildUserNameAndImage(patientReservationModel),
              buildOptionsMenu(context, patientReservationModel.patientID,
                  patientReservationModel.patientName)
            ],
          ),
          // expandedDescription(context, patientReservationModel.description,
          //     backGroundColor: Colors.transparent),
          const SizedBox(height: 16),
          Text(
            'Session time: ${formattedDate}',
            style: customTextStyle.bodyMedium,
          ),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              enterSessionButton(
                  context, patientReservationModel, canEnterTheSession),
              const SizedBox(width: 8),
              cancelButton(
                  context, patientReservationModel.id, canEnterTheSession),
            ],
          ),
        ],
      ),
    ),
  );
}

GeneralButtonOptions enterSessionButton(BuildContext context,
    PatientReservationModel patientReservationModel, bool canEnterTheSession) {
  return GeneralButtonOptions(
      text: "Enter session".tr(),
      onPressed: canEnterTheSession
          ? () {
              context.read<VideoCallBloc>().cachedAppointmentId =
                  patientReservationModel.id;
              navigationService.navigateTo(
                videoCallInitPage,
                arguments: {
                  'patientID': patientReservationModel.patientID,
                  'appointmentTime': patientReservationModel.date,
                },
              );
            }
          : () {
              customSnackBar('This session is not available yet', context,
                  isFloating: true);
            },
      options: ButtonOptions(
          color: canEnterTheSession
              ? customColors.primary
              : customColors.completeded,
          textStyle: customTextStyle.bodyMedium.copyWith(color: Colors.white)));
}

GeneralButtonOptions updateButton(
    BuildContext context, PatientReservationModel patientReservationModel) {
  return GeneralButtonOptions(
      text: "Update".tr(),
      onPressed: () async {
        await showBottomSheetWidget(context,
            SelectTimeDateBottomSheet(requestID: patientReservationModel.id));
      },
      options: ButtonOptions(
          color: customColors.primary,
          textStyle: customTextStyle.bodyMedium.copyWith(color: Colors.white)));
}

GestureDetector buildUserNameAndImage(
    PatientReservationModel patientReservationModel) {
  return GestureDetector(
    onTap: () {
      navigationService.navigateTo(userProfilePage,
          arguments: patientReservationModel.patientID);
    },
    child: Row(
      children: [
        Container(
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: getImageNetwork(
                forProfileImage: true,
                url: 'patientReservationModel.userImage',
                width: 65,
                height: 65,
                fit: BoxFit.cover),
          ),
        ),
        const SizedBox(width: 16),
        Text(patientReservationModel.patientName,
            style: customTextStyle.bodyLarge),
      ],
    ),
  );
}

GeneralButtonOptions cancelButton(
    BuildContext context, int reservationID, bool canEnterTheSession) {
  return GeneralButtonOptions(
    text: 'Cancel'.tr(),
    options: ButtonOptions(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: canEnterTheSession ? Colors.grey : customColors.error,
        width: 1,
      ),
      color: customColors.primaryBackGround,
      textStyle: customTextStyle.bodyMedium.copyWith(color: customColors.error),
    ),
    onPressed: canEnterTheSession
        ? () {
            customSnackBar("You can't cancel this session", context);
          }
        : () async {
            await showBottomSheetWidget(context,
                buildCancelPatientRequestBottomSheet(context, reservationID));
          },
  );
}

Widget buildCancelPatientRequestBottomSheet(
    BuildContext context, int reservationID) {
  PatientReservationsCubit patientReservationsCubit =
      context.read<PatientReservationsCubit>();
  String cancelReason = '';
  return BlocListener<PatientReservationsCubit, PatientReservationsState>(
    listener: (context, state) {
      if (state is CancelPatientReservationErrorState ||
          state is PatientReservationCanceledSuccessfullyState) {
        navigationService.goBack();
      }
    },
    child: Container(
      padding: const EdgeInsets.all(20),
      height: responsiveUtil.screenHeight * .32,
      decoration: BoxDecoration(
        color: customColors.primaryBackGround,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Are you sure you want to cancel this reservation?'.tr(),
                style: customTextStyle.bodyMedium),
            const SizedBox(height: 20),
            customTextField(
                validator: (_) {
                  return ValidationFunctions.informationValidation(
                      cancelReason);
                },
                hintText: "If yes tall us why?",
                context: context,
                onChanged: (value) {
                  cancelReason = value!;
                },
                label: 'description'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BlocBuilder<PatientReservationsCubit, PatientReservationsState>(
                  builder: (context, state) {
                    print('ssssssssssssssssss state is: $state');
                    bool isLoading =
                        state is CancelOnPatientReservationLoadingState &&
                            patientReservationsCubit.cahcedReservationID ==
                                reservationID;
                    return ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(customColors.primary),
                      ),
                      onPressed: () {
                        FormState? formState = formKey.currentState;
                        if (formState!.validate()) {
                          formState.save();

                          patientReservationsCubit.cancelOnPatientReservation(
                              reservationID, cancelReason);
                        }
                      },
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'Yes'.tr(),
                              style: customTextStyle.bodyMedium,
                            ),
                    );
                  },
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(customColors.error),
                  ),
                  onPressed: () {
                    // Handle Reject Action
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
      ),
    ),
  );
}
