import 'dart:async';

import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/video_call/bloc/video_call_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/app_bar_pushing_screens.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:permission_handler/permission_handler.dart';

const appId = '94292e56f62b4ac59f1b5396df053647';

class VideoCallPage extends StatefulWidget {
  final ClientRoleType role = ClientRoleType.clientRoleBroadcaster;

  VideoCallPage({
    super.key,
  });

  @override
  State<VideoCallPage> createState() => VideoCallPageState();
}

class VideoCallPageState extends State<VideoCallPage> {
  final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  bool viewPanel = false;
  bool _isInitialized = false;
  late RtcEngine _engine;
  late VideoCallBloc videoCallBloc;
  Timer? _callTimer;
  String timeMessage = '';
  @override
  void initState() {
    super.initState();
    videoCallBloc = context.read<VideoCallBloc>();
    _handlePermission();
    initialize();

    _startCallTimer();
  }

  void _startCallTimer() {
    _callTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final secondsLeft = 50 - timer.tick;
      if (secondsLeft <= 10) {
        if (mounted) {
          setState(() {
            timeMessage = 'Time left on call: $secondsLeft seconds';
          });
        }
      }
      if (secondsLeft <= 0) {
        timer.cancel();
        if (mounted) {
          _onCallEnd(context); // End the call after 50 seconds
        }
      }
    });
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }

  void _onToggleVideo() {
    setState(() {
      viewPanel = !viewPanel;
    });
    _engine.muteLocalVideoStream(viewPanel);
  }

  void _onCallEnd(BuildContext context) {
    _engine.leaveChannel();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _users.clear();
    _engine.leaveChannel();
    _engine.release();
    _callTimer!.cancel();
    super.dispose();
  }

  Future<void> _handlePermission() async {
    await [Permission.camera, Permission.microphone].request();
  }

  Future<void> initialize() async {
    if (appId.isEmpty) {
      setState(() {
        _infoStrings.add('APP ID is missing, please enter your APP ID');
        _infoStrings.add("Agora Engine is not starting");
      });
      return;
    }

    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(appId: appId));

    await _engine.enableVideo();
    await _engine
        .setChannelProfile(ChannelProfileType.channelProfileLiveBroadcasting);
    await _engine.setClientRole(role: widget.role);
    if (mounted) {
      _addAgoraEventHandlers();
    }
    VideoEncoderConfiguration configuration = const VideoEncoderConfiguration(
      dimensions: VideoDimensions(width: 1080, height: 720),
    );
    await _engine.setVideoEncoderConfiguration(configuration);

    await _engine.joinChannel(
      token: videoCallBloc.token,
      channelId: videoCallBloc.channelName,
      uid: 0,
      options: const ChannelMediaOptions(),
    );

    setState(() {
      _isInitialized = true;
    });
  }

  void _addAgoraEventHandlers() {
    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onError: (err, msg) {
          setState(() {
            final info = 'Error $err: $msg';
            _infoStrings.add(info);
          });
        },
        onJoinChannelSuccess: (connection, elapsed) {
          setState(() {
            final info = 'Join Channel: $connection';
            _infoStrings.add(info);
          });
        },
        onLeaveChannel: (connection, stats) {
          // setState(() {
          final info = 'Leave Channel: $stats';
          _infoStrings.add(info);
          // });
        },
        onUserJoined: (connection, remoteUid, elapsed) {
          setState(() {
            final info = 'User Joined: $remoteUid';
            _infoStrings.add(info);
            _users.add(remoteUid);
          });
        },
        onUserOffline: (connection, remoteUid, reason) {
          setState(() {
            final info = 'User Offline: $remoteUid';
            _infoStrings.add(info);
            _users.remove(remoteUid);
          });
        },
      ),
    );
  }

  Widget _viewRows() {
    final List<StatefulWidget> list = [];
    if (widget.role == ClientRoleType.clientRoleBroadcaster) {
      list.add(AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: _engine,
          canvas: const VideoCanvas(uid: 0),
        ),
      ));
    }
    for (var uid in _users) {
      list.add(AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: uid),
          connection: RtcConnection(channelId: videoCallBloc.channelName),
        ),
      ));
    }
    final views = list;
    return list.length == 1
        ? Column(
            children: [
              Text(
                "Wating for another user to enter the session",
                style: customTextStyle.bodyMedium,
              ),
              Icon(Icons.hourglass_empty_rounded, color: customColors.primary),
              Expanded(child: views[0]),
            ],
          )
        : Stack(
            children: [
              // Add all other elements first
              Column(
                children: List.generate(views.length - 1, (index) {
                  return Expanded(
                    child: views[index + 1],
                  );
                }),
              ),
              // Add the first element last to make sure it's on top
              myCameraView(views),
              Positioned(
                  left: responsiveUtil.screenWidth * .4,
                  child: Text(
                    timeMessage,
                    style: customTextStyle.bodyLarge
                        .copyWith(color: customColors.error),
                  ))
            ],
          );
  }

  double myCameraViewOnTop = 10;
  double myCameraViewOnleft = 10;
  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      myCameraViewOnTop += details.delta.dy;
      myCameraViewOnleft += details.delta.dx;
    });
  }

  Positioned myCameraView(List<StatefulWidget> views) {
    return Positioned(
      top: myCameraViewOnTop,
      left: myCameraViewOnleft,
      child: GestureDetector(
        onPanUpdate: _onDragUpdate,
        child: Container(
          height: 200,
          width: 150,
          alignment: Alignment.topCenter,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10), child: views[0]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.primaryBackGround,
      appBar: appBarPushingScreens('Video Call', isFromScaffold: true),
      body: Center(
        child: Stack(
          children: [
            _isInitialized
                ? _viewRows()
                : Center(
                    child: CircularProgressIndicator(
                    color: customColors.primary,
                  )),
            _toolbar(),
          ],
        ), // Show a loading indicator until initialized
      ),
    );
  }

  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          muteButton(),
          const SizedBox(
            width: 20,
          ),
          callEndButton(),
          const SizedBox(
            width: 20,
          ),
          switchCameraButton(),
          const SizedBox(
            width: 20,
          ),
          muteVideoButton(),
        ],
      ),
    );
  }

  FloatingActionButton muteVideoButton() {
    return FloatingActionButton(
      shape: const CircleBorder(),
      onPressed: () => _onToggleVideo(),
      heroTag: "btn3",
      backgroundColor: viewPanel
          ? customColors.primaryBackGround
          : Colors.black54.withOpacity(0.3),
      child: Icon(
        viewPanel ? Icons.videocam_off : Icons.videocam,
        color: Colors.white,
      ),
    );
  }

  FloatingActionButton switchCameraButton() {
    return FloatingActionButton(
      shape: const CircleBorder(),
      onPressed: _onSwitchCamera,
      heroTag: "btn2",
      backgroundColor: Colors.black54.withOpacity(0.3),
      child: const Icon(Icons.switch_camera, color: Colors.white),
    );
  }

  FloatingActionButton callEndButton() {
    return FloatingActionButton(
      shape: const CircleBorder(),
      onPressed: () => _onCallEnd(context),
      heroTag: "btn1",
      backgroundColor: Colors.redAccent,
      child: const Icon(Icons.call_end, color: Colors.white),
    );
  }

  FloatingActionButton muteButton() {
    return FloatingActionButton(
      shape: const CircleBorder(),
      onPressed: () => _onToggleMute(),
      backgroundColor: muted
          ? customColors.primaryBackGround
          : Colors.black54.withOpacity(0.3),
      child: Icon(
        muted ? Icons.mic_off : Icons.mic,
        color: Colors.white,
      ),
    );
  }
}
