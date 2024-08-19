import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/repo/chat_repo.dart';
import 'package:meta/meta.dart';

part 'video_call_event.dart';
part 'video_call_state.dart';

class VideoCallBloc extends Bloc<VideoCallEvent, VideoCallState> {
  late String token;
  late String channelName;
  int cachedAppointmentId = -10;

  ChatRepositoryImp chatRepositoryImp;
  void setToken(String newToken) {
    token = newToken;
  }

  VideoCallBloc({required this.chatRepositoryImp}) : super(VideoCallInitial()) {
    on<VideoCallEvent>((event, emit) {});
    on<VideoInitEvent>((event, emit) {
      emit(VideoCallInitial());
    });
    on<GetChatInformation>((event, emit) async {
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
  }
}
