import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/bloc/chat_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/bloc/chat_event.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/bloc/chat_state.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class ChatInitPage extends StatefulWidget {
  const ChatInitPage({super.key});

  @override
  State<ChatInitPage> createState() => _ChatInitPageState();
}

class _ChatInitPageState extends State<ChatInitPage> {
late ChatBloc chatBloc;

  @override
void initState(){
  super.initState();
  chatBloc=context.read<ChatBloc>();
  chatBloc.add(GetChatInformation());
}

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {
        if(state is GotChatInfoState){
          navigationService.navigateTo(chatPage);
        }else if(state is ChatErrorState){
          customSnackBar(state.errorMessage, context);
          navigationService.goBack();
        }
        },
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Text('preparing the chat'.tr(), style: customTextStyle.bodyLarge),
            Expanded(
                child: Center(
              child: CircularProgressIndicator(
                color: customColors.primary,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
