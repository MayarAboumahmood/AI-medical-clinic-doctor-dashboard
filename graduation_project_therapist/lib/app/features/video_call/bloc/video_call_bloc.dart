import 'dart:async';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/repo/chat_repo.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:screenshot/screenshot.dart';

part 'video_call_event.dart';
part 'video_call_state.dart';

class VideoCallBloc extends Bloc<VideoCallEvent, VideoCallState> {
  late String token;
  late String channelName;
  int cachedAppointmentId = -10;

  String? cachedAppointmentStartTime;
  TextEditingController videoCallReportDescriptionController =
      TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();

  void startAppointmentTimer(String dateTimeString, BuildContext context) {
    DateTime appointmentTime;
    try {
      print('appointment time string: ${dateTimeString}');
      print('not time string: ${dateTimeString}');
      appointmentTime = DateTime.parse(dateTimeString);
    } catch (e) {
      print('Error parsing date: $e');
      appointmentTime = DateTime.now();
    }

    Timer.periodic(Duration(seconds: 1), (timer) {
      DateTime now = DateTime.now();
      Duration difference = appointmentTime.difference(now);
      print('Current time: $now');
      print('Difference: $difference');

      if (difference.inMinutes >= 30) {
        customSnackBar('The session is over. You are free to leave.', context,
            backgroundColor: customColors.primary, duration: 7);
        print('The session is over. You are free to leave.');

        timer.cancel();
      }
    });
  }

  ChatRepositoryImp chatRepositoryImp;
  void setToken(String newToken) {
    token = newToken;
  }

  Future<Uint8List?> takeScreenshotAndReturnImage(
      ScreenshotController screenshotController) async {
    try {
      // Capture the screenshot
      final Uint8List? image = await screenshotController.capture();

      if (image != null) {
        print('Screenshot taken!: ${image.length}');
        return image;
      } else {
        print('Failed to capture screenshot.');
      }
    } catch (e) {
      print('Error taking screenshot: $e');
    }

    return null;
  }

  Uint8List resizeImage(Uint8List imageBytes, int width, int height) {
    // Decode the image
    img.Image? image = img.decodeImage(imageBytes);

    if (image == null) {
      throw Exception('Unable to decode image.');
    }

    // Resize the image
    img.Image resizedImage =
        img.copyResize(image, width: width, height: height);

    // Encode the image back to bytes
    return Uint8List.fromList(img.encodeJpg(resizedImage));
  }

  VideoCallBloc({required this.chatRepositoryImp}) : super(VideoCallInitial()) {
    on<VideoCallEvent>((event, emit) {});
    on<VideoInitEvent>((event, emit) {
      emit(VideoCallInitial());
    });
    on<GetChatInformation>((event, emit) async {
      cachedAppointmentStartTime = event.appointmentTime;
      final getData =
          await chatRepositoryImp.getChatInformation(event.patientID);
      getData.fold((l) => emit(VideoCallErrorState(error: l)), (chatInfoModel) {
        channelName = chatInfoModel.data.channelName;
        token = chatInfoModel.data.token;
        // bool isReady = chatInfoModel.data.
        emit(GotVideoInfoState());
      });
    });
    on<SendCompleteSessionEvent>((event, emit) async {
      emit(SessionCompletedLoadingState());

      final getData =
          await chatRepositoryImp.sendCompleteSession(event.appointmentId);
      getData.fold((l) => emit(VideoCallErrorState(error: l)), (done) {
        emit(SessionCompletedFromOneSideDoneState());
      });
    });
    on<CheckIfSessionCompletedEvent>((event, emit) async {
      emit(CheckIfSessionCompletedLoadingtState());

      final getData =
          await chatRepositoryImp.checkIfSessionComplete(event.appointmentId);
      getData.fold((l) => emit(VideoCallErrorState(error: l)), (done) {
        emit(SessionIsCompletedState(status: done));
      });
    });
    on<ReportVideoCallEvent>((event, emit) async {
      emit(ReportingVideoCallLoadingtState());
      Uint8List? pic = await takeScreenshotAndReturnImage(screenshotController);
      if (pic != null) {
        Uint8List imageWithLowerResulation = resizeImage(
          pic,
          400,
          700,
        );
        final getData = await chatRepositoryImp.reportVideoCall(
            event.appointmentId,
            videoCallReportDescriptionController.text,
            imageWithLowerResulation);
        getData.fold((l) => emit(VideoCallReportingErrorState(errorMessage: l)),
            (done) {
          emit(ReportingVideoCallCompletedState());
        });
      } else {
        emit(VideoCallReportingErrorState(
            errorMessage: 'Something want wrong, try again'));
      }
    });
  }
}
