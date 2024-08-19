import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/video_call/bloc/video_call_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/text_fields/text_field.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Widget videoCallReportBottomSheet(BuildContext context, int appointmentId) {
  return BlocListener<VideoCallBloc, VideoCallState>(
    listener: (context, state) {
      if (state is SessionCompletedFromOneSideDoneState ||
          state is VideoCallErrorState) {
        navigationService.goBack();
      }
    },
    child: Container(
      padding: const EdgeInsets.all(20),
      height: responsiveUtil.screenHeight * .6,
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
            descriptionForUser(),
            customTextField(
                context: context,
                controller: context.read<VideoCallBloc>().descriptionController,
                label: 'What did the patient do wrong?'),
            const SizedBox(height: 20),
            reportButtons(context),
          ],
        ),
      ),
    ),
  );
}

Row reportButtons(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      BlocBuilder<VideoCallBloc, VideoCallState>(
        builder: (context, state) {
          bool isLoading = state is SessionCompletedLoadingState;
          return isLoading
              ? Center(
                  child: CircularProgressIndicator(
                  color: customColors.primary,
                ))
              : ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(customColors.primary),
                  ),
                  onPressed: () {
                    if (!isLoading) {
                      //TODO
                    }
                  },
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.white))
                      : Text(
                          'Yes'.tr(),
                          style: customTextStyle.bodyMedium,
                        ),
                );
        },
      ),
      ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(customColors.error),
        ),
        onPressed: () {
          Navigator.pop(context); // Close the bottom sheet
        },
        child: Text(
          'No'.tr(),
          style: customTextStyle.bodyMedium,
        ),
      ),
    ],
  );
}

Column descriptionForUser() {
  return Column(
    children: [
      Text(
        'Message Regarding Reporting During Video Calls'.tr(),
        style: customTextStyle.bodyMedium,
      ),
      const SizedBox(height: 16),
      Text(
        'We want to clarify when you should use the reporting feature during video calls:'
            .tr(),
        style: customTextStyle.bodyMedium,
      ),
      const SizedBox(height: 16),
      Text(
        '• Leaving the Call Without Agreement: If the other person ends the call without mutual agreement, you can report this behavior.'
            .tr(),
        style: customTextStyle.bodyMedium,
      ),
      const SizedBox(height: 8),
      Text(
        '• Inappropriate Behavior: If the other person engages in any improper or inappropriate actions during the call, you have the option to report them.'
            .tr(),
        style: customTextStyle.bodyMedium,
      ),
      const SizedBox(height: 16),
      Text(
          'Your reports help us maintain a safe and respectful environment for everyone.'
              .tr(),
          style: customTextStyle.bodyMedium.copyWith()),
      const SizedBox(height: 20),
    ],
  );
}
