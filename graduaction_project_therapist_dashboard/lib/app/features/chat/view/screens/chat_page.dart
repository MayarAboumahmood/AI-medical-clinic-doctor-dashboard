import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/bloc/chat_bloc_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/bloc/chat_bloc_event.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/bloc/chat_bloc_state.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/app_bar_pushing_screens.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.primaryBackGround,
      appBar: appBarPushingScreens('Chat', isFromScaffold: true),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is NewMessageState) {
                  return Text(
                    "New message: ${state.message}",
                    style: customTextStyle.bodyMedium,
                  );
                }
                return Text("No messages".tr(),
                    style: customTextStyle.bodyMedium);
              },
            ),
          ),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
                labelText: 'Send a message',
                labelStyle: customTextStyle.bodyMedium),
            onSubmitted: (value) {
              context.read<ChatBloc>().add(SendMessageEvent(value));
              _controller.clear();
            },
          ),
        ],
      ),
    );
  }
}
