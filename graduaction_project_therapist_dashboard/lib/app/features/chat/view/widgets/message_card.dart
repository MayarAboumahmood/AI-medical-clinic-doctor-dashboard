import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class MessageCard extends StatelessWidget {
  final String text;
  final bool iAmTheSender; //if I am the sender than it's true else it's false.
  final bool
      isConsecutiveMessage; //if there is no message above it for the same persone than it's false.
  const MessageCard(
      {super.key,
      required this.text,
      required this.iAmTheSender,
      required this.isConsecutiveMessage});

  @override
  Widget build(BuildContext context) {
    return BubbleSpecialThree(
      text: text,
      textStyle: customTextStyle.bodyMedium,
      tail: isConsecutiveMessage,
      color: iAmTheSender ? customColors.primary : customColors.completeded,
      isSender: iAmTheSender,
    );
  }
}
