import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/features/video_call/bloc/video_call_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class VideoCallInitPage extends StatefulWidget {
  const VideoCallInitPage({super.key});

  @override
  State<VideoCallInitPage> createState() => _VideoCallInitPageState();
}

class _VideoCallInitPageState extends State<VideoCallInitPage> {
  late VideoCallBloc videoCallBloc;
  bool firstTimeDidChange = true;

  @override
  void initState() {
    super.initState();

    videoCallBloc = context.read<VideoCallBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    firstTimeDidChange = true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (firstTimeDidChange) {
      firstTimeDidChange = false;
      final arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      final int patientID = arguments['patientID'] as int? ?? -1;
      final String appointmentTimeString =
          arguments['appointmentTime'] as String;
      videoCallBloc.cachedPatientID = patientID;

      videoCallBloc.add(GetChatInformation(
          patientID: patientID, appointmentTime: appointmentTimeString));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) => {
        videoCallBloc.add(VideoInitEvent()),
        firstTimeDidChange = true,
      },
      child: BlocListener<VideoCallBloc, VideoCallState>(
        listener: (context, state) {
          if (state is GotVideoInfoState) {
            navigationService.replaceWith(videoCallPage);
          } else if (state is VideoCallErrorState) {
            customSnackBar(state.error, context);
            navigationService.goBack();
          }
        },
        child: Scaffold(
          backgroundColor: customColors.primaryBackGround,
          body: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Text('preparing the video call'.tr(),
                  style: customTextStyle.bodyLarge),
              Expanded(
                  child: Center(
                child: CircularProgressIndicator(
                  color: customColors.primary,
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
