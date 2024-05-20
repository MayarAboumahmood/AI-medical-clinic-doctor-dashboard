import 'package:graduation_project_therapist_dashboard/app/features/notification/data/models/notification_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/notification/presentaion/bloc/notification_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/notification/presentaion/bloc/notification_event.dart';
import 'package:graduation_project_therapist_dashboard/app/features/notification/presentaion/bloc/notification_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/notification/presentaion/widgets/notification_widgets/notification_card.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/get_status_request_from_status_code.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/app_bar_pushing_screens.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/text_fields/loadin_widget.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/no_element_in_page.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class NotificationScreen extends StatelessWidget {
  final List<NotificationModel> notificationList = [];
  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<NotificationBloc>().add(const FetchAllNotifications());
    return BlocConsumer<NotificationBloc, NotificationState>(
      listener: (context, state) {
        if (state is NotificationLoaded) {
          notificationList.clear();
          notificationList.addAll(state.notifications);
        } else if (state is NotificationError) {
          customSnackBar(getMessageFromStatus(state.statusRequest), context);
        }
      },
      builder: (context, state) {
        if (state is NotificationLoading) {
          return followingPageshimmer(
            appBarPushingScreens("Notification", isFromScaffold: true),
          );
        } else if (state is NotificationLoaded) {
          return buildNotificationPageBody();
        }
        return followingPageshimmer(
          appBarPushingScreens("Notification", isFromScaffold: true),
        );
      },
    );
  }

  Scaffold buildNotificationPageBody() {
    return Scaffold(
      appBar: appBarPushingScreens("Notification", isFromScaffold: true),
      backgroundColor: customColors.primaryBackGround,
      body: notificationList.isEmpty
          ? buildNoElementInPage(
              'All caugth up! No new notifications right now.',
              Icons.notifications_sharp,
            )
          : SingleChildScrollView(
              child: Padding(
                padding: responsiveUtil.padding(5, 10, 0, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Below is a list of recent activity".tr(),
                      style: customTextStyle.bodyMedium
                          .copyWith(color: customColors.secondaryText),
                    ),
                    ...List.generate(notificationList.length,
                        (index) => notificationCard(notificationList[index])),
                  ],
                ),
              ),
            ),
    );
  }
}
