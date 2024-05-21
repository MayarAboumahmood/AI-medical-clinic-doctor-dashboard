import 'dart:typed_data';

import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/models/message_model.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/image_widgets/network_image.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class MessageCard extends StatelessWidget {
  final String text;
  final Uint8List? imageData;
  final bool iAmTheSender;
  final bool isConsecutiveMessage;
  final MessageTypeEnum messageType;

  const MessageCard({
    Key? key,
    required this.text,
    this.imageData,
    required this.iAmTheSender,
    required this.isConsecutiveMessage,
    required this.messageType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (messageType) {
      case MessageTypeEnum.text:
        return BubbleSpecialThree(
          text: text,
          textStyle: customTextStyle.bodyMedium,
          tail: isConsecutiveMessage,
          color: iAmTheSender ? customColors.primary : customColors.completeded,
          isSender: iAmTheSender,
        );
      case MessageTypeEnum.image:
        return imageData == null
            ? const SizedBox.shrink()
            : Align(
                alignment:
                    iAmTheSender ? Alignment.topRight : Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: responsiveUtil.screenWidth * .4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: customColors.primary)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.memory(
                          imageData!,
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return buildErrorBody(
                                true,
                                responsiveUtil.screenWidth * .4,
                                responsiveUtil.screenWidth * .4);
                          },
                          fit: BoxFit.fitWidth,
                        )),
                  ),
                ));
      default:
        return const SizedBox.shrink();
    }
  }
}
