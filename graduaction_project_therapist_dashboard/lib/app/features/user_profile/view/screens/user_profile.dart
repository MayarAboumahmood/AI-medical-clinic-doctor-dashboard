import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/user_profile/cubit/user_profile_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/user_profile/data_source/models/user_profile_model.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/network_image.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/text_fields/loadin_widget.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late UserProfileCubit userProfileCubit;
  late int requestID;
  @override
  initState() {
    userProfileCubit = context.read<UserProfileCubit>();

    super.initState();
  }

  bool firstTimeDidChange = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (firstTimeDidChange) {
      firstTimeDidChange = false;
      final int argument = ModalRoute.of(context)!.settings.arguments as int;
      requestID = argument;
      userProfileCubit.getUserProfile(requestID);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.primaryBackGround,
      body: BlocConsumer<UserProfileCubit, UserProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is UserProfileLoadingState) {
            return offerAndNewOpiningShimmer();
          } else if (state is UserProfileGetData) {
            return dd(state.userProfileModel);
          }
          return offerAndNewOpiningShimmer();
        },
      ),
    );
  }

  Widget dd(UserProfileModel userProfileModel) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: responsiveUtil.screenHeight * .25,
          floating: false,
          pinned: true,
          backgroundColor: customColors.secondaryBackGround,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(userProfileModel.name,
                style: customTextStyle.headlineMedium
                    .copyWith(color: Colors.white)),
            background: getImageNetwork(
                url:
                    userProfileModel.image ?? 'https://via.placeholder.com/150',
                fit: BoxFit.cover,
                width: responsiveUtil.screenWidth,
                height: responsiveUtil.screenHeight * .25),
          ),
        ),
        SliverToBoxAdapter(
          child: userProfileBody(userProfileModel),
        ),
      ],
    );
  }
}

Widget userProfileBody(UserProfileModel profile) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      infoSection(
          'Date of Birth', profile.dateOfBirth.toIso8601String().split('T')[0]),
      profilePageDivider(),
      infoSection('Relationship Status', profile.relationshipState),
      profilePageDivider(),
      infoSection('Number of Kids', profile.numberOfKids.toString()),
      profilePageDivider(),
      infoSection('Current Work', profile.currentWork),
      profile.workHoursPerDay != null ? profilePageDivider() : const SizedBox(),
      profile.workHoursPerDay != null
          ? infoSection(
              'Work Hours per Day', profile.workHoursPerDay.toString())
          : const SizedBox(),
      profile.placeOfWork != null ? profilePageDivider() : const SizedBox(),
      profile.placeOfWork != null
          ? infoSection('Place of Work', profile.currentWork)
          : const SizedBox(),
      profilePageDivider(),
      SizedBox(height: responsiveUtil.screenHeight * .1),
      GeneralButtonOptions(
          text: 'Go to User ', onPressed: () {}, options: ButtonOptions())
    ],
  );
}

Divider profilePageDivider() {
  return Divider(
    thickness: 2,
    color: customColors.secondaryText,
  );
}

Widget infoSection(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
    child: RichText(
      text: TextSpan(
        text: '${title.tr()}: ',
        style: customTextStyle.bodyLarge,
        children: [
          TextSpan(
            text: value,
            style: customTextStyle.bodyMedium
                .copyWith(color: customColors.secondaryText),
          ),
        ],
      ),
    ),
  );
}
