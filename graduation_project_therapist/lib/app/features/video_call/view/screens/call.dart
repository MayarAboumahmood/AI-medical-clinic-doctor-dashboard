import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/app_bar_pushing_screens.dart';

class VideoCallPage extends StatefulWidget {
  const VideoCallPage({super.key});

  @override
  VideoCallPageState createState() => VideoCallPageState();
}

class VideoCallPageState extends State<VideoCallPage> {
  late final AgoraClient _client;

  static const appId = '94292e56f62b4ac59f1b5396df053647';
  static const token =
      '007eJxTYFD7t/2B0L9al52evtf39grOkFVu36iU5Tkv8tTyuuSSvnkKDJYmRpZGqaZmaWZGSSaJyaaWaYZJpsaWZilpBqbGZibmt3sS0xoCGRlC1X4xMzJAIIjPzlCSWlxiaGTMwAAAuEUgCg==';

  @override
  void initState() {
    super.initState();
    _client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: appId,
        channelName: 'your-channel-name',
        tempToken: token, 
      ),
      enabledPermission: [
        Permission.camera,
        Permission.microphone,
      ],
    );

    _initializeAgora();
  }

  Future<void> _initializeAgora() async {
    await _client.initialize();
  }

  @override
  void dispose() {
    _client.sessionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPushingScreens('Video Call', isFromScaffold: true),
      body: SafeArea(
        child: Stack(
          children: [
            AgoraVideoViewer(
              client: _client,
              layoutType: Layout.floating,
              showNumberOfUsers: true,
            ),
            AgoraVideoButtons(
              client: _client,
            ),
          ],
        ),
      ),
    );
  }
}
