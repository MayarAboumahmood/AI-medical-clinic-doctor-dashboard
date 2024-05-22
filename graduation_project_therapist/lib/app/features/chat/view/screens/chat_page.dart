import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/image_widgets/pic_picture_sheet.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/bloc/chat_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/bloc/chat_event.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/bloc/chat_state.dart';

import 'package:graduation_project_therapist_dashboard/app/features/chat/models/message_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/view/widgets/message_card.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/show_bottom_sheet.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/app_bar_pushing_screens.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/text_fields/loadin_widget.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:image_picker/image_picker.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _textFeildController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<MessageModel> messages = [];
  late final ChatBloc chatBloc;
  @override
  void initState() {
    super.initState();
    chatBloc = context.read<ChatBloc>();
    chatBloc.add(SubscribeMessagesEvent());
  }

  bool firstTime = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (firstTime) {
      chatBloc.add(GetAllMessagesEvent());
      chatBloc.add(ReceiveNewMessageEvent());
      _jumpToBottom();
      firstTime = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _textFeildController.dispose();
    _scrollController.dispose();
    chatBloc.add(UnsubscribeEvent());
    messages.clear();
  }

  void _jumpToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(
          _scrollController.position.maxScrollExtent,
        );
      } else {
        debugPrint("we can't jumb to bottom, yet.");
      }
    });
    // });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is ChatErrorState) {
          customSnackBar(state.errorMessage, context);
        }
      },
      child: Scaffold(
        backgroundColor: customColors.primaryBackGround,
        appBar: appBarPushingScreens('Chat', isFromScaffold: true),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  debugPrint('sssssssssssssssss the state in chat page $state');
                  if (state is ChatsLoadingState) {
                    return messageListShimmer();
                  } else if (state is GotAllMessagesState) {
                    messages.addAll(state.messages);
                    _jumpToBottom();
                    Future.delayed(const Duration(milliseconds: 300), () {
                      _jumpToBottom();
                    });
                    Future.delayed(const Duration(seconds: 2), () {
                      _jumpToBottom();
                    });

                    return listOfMessagesBody();
                  } else if (state is MessageSentState) {
                    messages.add(state.messageModel);
                    _scrollToBottom();
                    return listOfMessagesBody();
                  } else if (state is NewMessageReceivedState) {
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
      ),
    );
  }

  Widget listOfMessagesBody() {
    if (messages.isEmpty) {
      return noMessageYetContainer();
    } else {
      return SingleChildScrollView(
          controller: _scrollController,
          child: Column(children: [
            const SizedBox(height: 20),
            ...List.generate(messages.length, (index) {
              MessageTypeEnum messageTypeEnum = messages[index].type;
              bool iAmTheSender = messages[index].iAmTheSender;
              switch (messageTypeEnum) {
                case MessageTypeEnum.text:
                  return MessageCard(
                    iAmTheSender: iAmTheSender,
                    isConsecutiveMessage:
                        shouldMessageHaveTail(iAmTheSender, index),
                    text: messages[index].content as String?,
                    messageType: messages[index].type,
                  );
                case MessageTypeEnum.image:
                  return MessageCard(
                    iAmTheSender: iAmTheSender,
                    isConsecutiveMessage:
                        shouldMessageHaveTail(iAmTheSender, index),
                    text: '',
                    imageData: messages[index].content as Uri? ?? Uri(),
                    messageType: messages[index].type,
                  );

                case MessageTypeEnum.voice:
                  return const SizedBox();
                default:
                  return const SizedBox();
              }
            })
          ]));
    }
  }

  Padding noMessageYetContainer() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Container(
              width: responsiveUtil.screenWidth,
              height: responsiveUtil.screenHeight * .1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: customColors.primary.withOpacity(0.1),
              ),
              child: Center(
                  child: Text("No messages yet".tr(),
                      style: customTextStyle.bodyMedium))),
          const Spacer(),
        ],
      ),
    );
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

  Future<void> pickImageToSend(ImageSource source, BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      final Uint8List imageBytes = await image.readAsBytes();
      final String fileName =
          image.name; // Get the file name from the XFile object
      chatBloc.add(SendMessageEvent(
        imageData: imageBytes,
        imageName: fileName,
        messageType: MessageTypeEnum.image,
      ));
    }
  }

  Widget messageTextField() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              cursorColor: customColors.primary,
              controller: _textFeildController,
              enabled: chatBloc.state is! ChatsLoadingState,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.camera_alt),
                    onPressed: () async {
                      await showBottomSheetWidget(
                          context,
                          buildimageSourcesBottomSheet(context,
                              pickImage: pickImageToSend));
                    },
                  ),
                  hintText: 'Send a message',
                  hintStyle: customTextStyle.bodyMedium
                      .copyWith(color: customColors.secondaryText)),
              style: customTextStyle.bodyMedium,
              onSubmitted: (message) {
                onSubmittedTextField(message);
              },
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: () {
            String message = _textFeildController.text;
            onSubmittedTextField(message);
          },
        ),
      ],
    );
  }

  void onSubmittedTextField(String message) {
    message = message.trim();
    if (message.isNotEmpty) {
      chatBloc.add(SendMessageEvent(
          message: message, messageType: MessageTypeEnum.text));
      _textFeildController.clear();
    }
  }
}