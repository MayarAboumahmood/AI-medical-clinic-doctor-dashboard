import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/bloc/chat_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/bloc/chat_event.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/bloc/chat_state.dart';

import 'package:graduation_project_therapist_dashboard/app/features/chat/models/message_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/view/widgets/message_card.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/app_bar_pushing_screens.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/text_fields/loadin_widget.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  List<MessageModel> messages = [];
  late final ChatBloc chatBloc;
  @override
  void initState() {
    super.initState();
    chatBloc = context.read<ChatBloc>();
    chatBloc.add(GetAllMessagesEvent());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });

    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

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
                print('sssssssssssssssssss $state');
                print('sssssssssssssssssss ${messages.length}');
                if (state is ChatsLoadingState) {
                  return messageListShimmer();
                } else if (state is GotAllMessagesState) {
                  messages.addAll(state.messages);
                  return listOfMessagesBody();
                } else if (state is MessageSentState) {
                  messages.add(state.messageModel);
                  _scrollToBottom();
                  return listOfMessagesBody();
                }
                return listOfMessagesBody();
              },
            ),
          ),
          messageTextField(),
        ],
      ),
    );
  }

  Widget listOfMessagesBody() {
    if (messages.isEmpty) {
      return Text("No messages".tr(), style: customTextStyle.bodyMedium);
    } else {
      return SingleChildScrollView(
          controller: _scrollController,
          child: Column(children: [
            const SizedBox(height: 20),
            ...List.generate(messages.length, (index) {
              print(
                  'sssssssss what is going on?:${index == 0 ? true : !messages[index - 1].iAmTheSender}');
              bool iAmTheSender = messages[index].iAmTheSender;
              return MessageCard(
                iAmTheSender: iAmTheSender,
                isConsecutiveMessage:
                    shouldMessageHaveTail(iAmTheSender, index),
                text: messages[index].content,
              );
            })
          ]));
    }
  }

  bool shouldMessageHaveTail(bool iAmTheSender, int index) {
    return iAmTheSender
        ? index == 0
            ? true
            : !messages[index - 1].iAmTheSender
        : index == 0
            ? true
            : messages[index - 1].iAmTheSender;
  }

  Padding messageTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: _controller,
        enabled: chatBloc.state is ChatsLoadingState,
        decoration: InputDecoration(
            labelText: 'Send a message',
            labelStyle: customTextStyle.bodyMedium),
        style: customTextStyle.bodyMedium,
        onSubmitted: (value) {
          print('sssssssssssssssssssssssssss : $value');
          print('sssssssssssssssssssssssssss : ${chatBloc.messages.length}');
          chatBloc.add(SendMessageEvent(
              message: value, messageType: MessageTypeEnum.text));
          _controller.clear();
        },
      ),
    );
  }
}
