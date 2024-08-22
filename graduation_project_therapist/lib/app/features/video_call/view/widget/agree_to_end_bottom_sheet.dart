import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/video_call/bloc/video_call_bloc.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

Widget agreeToEndCallBottomSheet(BuildContext context, int appointmentId) {
  return BlocListener<VideoCallBloc, VideoCallState>(
    listener: (context, state) {
      if (state is SessionCompletedFromOneSideDoneState ||
          state is VideoCallErrorState) {
        navigationService.goBack();
      }
    },
    child: Container(
      padding: const EdgeInsets.all(20),
      height: responsiveUtil.screenHeight * .25,
      decoration: BoxDecoration(
        color: customColors.primaryBackGround,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'Are you sure you want to agree to end this call? Once both parties agree, the session cannot be reported, and either party can leave the call at any time.'
                  .tr(),
              style: customTextStyle.bodyMedium),
          const SizedBox(height: 20),
          Row(
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

                              context.read<VideoCallBloc>().add(
                                  SendCompleteSessionEvent(
                                      appointmentId: appointmentId));
                            }
                          },
                          child: isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.white))
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
          ),
        ],
      ),
    ),
  );
}
