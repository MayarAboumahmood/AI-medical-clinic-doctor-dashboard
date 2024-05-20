import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/bloc/chat_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/bloc/chat_state.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/models/chat_card_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/view/widgets/chat_card.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/app_bar_pushing_screens.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/text_fields/loadin_widget.dart';

class ChatsUsersPage extends StatefulWidget {
  const ChatsUsersPage({super.key});

  @override
  State<ChatsUsersPage> createState() => _ChatsUsersPageState();
}

class _ChatsUsersPageState extends State<ChatsUsersPage> {
  late ChatBloc chatBloc;
  late List<ChatCardModel> chatsCardsModels;
  @override
  void initState() {
    chatBloc = context.read<ChatBloc>();
    chatsCardsModels = chatBloc.chatsCardsModels;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPushingScreens('Chats'),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is ChatsLoadingState) {
            return mediumSizeCardShimmer();
          } else if (state is GotAllChatsState) {
            chatsCardsModels = state.chatsCardsModels;
            return chatsBody();
          }
          return mediumSizeCardShimmer();
        },
      ),
    );
  }

  SingleChildScrollView chatsBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...List.generate(
              chatsCardsModels.length,
              (index) => ChatCard(
                    chatCardModel: chatsCardsModels[index],
                  ))
        ],
      ),
    );
  }
}
