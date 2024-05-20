import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'video_call_event.dart';
part 'video_call_state.dart';

class VideoCallBloc extends Bloc<VideoCallEvent, VideoCallState> {
  VideoCallBloc() : super(VideoCallInitial()) {
    on<VideoCallEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

}
