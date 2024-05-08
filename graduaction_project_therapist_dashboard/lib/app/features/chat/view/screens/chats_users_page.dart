import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/app_bar_pushing_screens.dart';

class ChatsUsersPage extends StatelessWidget {
  const ChatsUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPushingScreens('Chats'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...List.generate(10, (index) => chatCard())
          ],
        ),
      ),
    );
  }
}
