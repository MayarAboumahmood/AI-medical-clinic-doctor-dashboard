import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/app_bar_pushing_screens.dart';

class GetAllTherapistPage extends StatelessWidget {
  const GetAllTherapistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPushingScreens('All Therapist', isFromScaffold: true),
    );
  }
}
