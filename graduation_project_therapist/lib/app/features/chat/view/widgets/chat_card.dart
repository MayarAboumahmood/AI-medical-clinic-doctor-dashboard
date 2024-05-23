import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/models/chat_card_model.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class ChatCard extends StatelessWidget {
  final ChatCardModel chatCardModel;
  const ChatCard({super.key, required this.chatCardModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: customColors.secondaryBackGround, // Background color of the card
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(chatCardModel.image),
              radius: 30,
            ),
            const SizedBox(width: 10),
            Text(
              chatCardModel.name,
              style: customTextStyle.bodyMedium, // Custom text style
            ),
          ],
        ),
      ),
    );
  }
}
