import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/user_profile/cubit/user_profile_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/user_profile/data_source/models/user_profile_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/user_profile/view/widgets/user_profile_body.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/image_widgets/network_image.dart';
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
      final int argument =
          ModalRoute.of(context)!.settings.arguments as int? ?? 1;
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
            return userProfileSilverAppBar(state.patientProfileModel);
          }
          return offerAndNewOpiningShimmer();
        },
      ),
    );
  }

  Widget userProfileSilverAppBar(PatientProfileModel PatientProfileModel) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          iconTheme: IconThemeData(color: customColors.primary),
          expandedHeight: responsiveUtil.screenHeight * .25,
          floating: false,
          pinned: true,
          backgroundColor: customColors.secondaryBackGround,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(PatientProfileModel.name,
                style: customTextStyle.headlineMedium
                    .copyWith(color: Colors.white)),
            background: getImageNetwork(
                url: PatientProfileModel.image ??
                    'https://via.placeholder.com/150',
                fit: BoxFit.cover,
                width: responsiveUtil.screenWidth,
                height: responsiveUtil.screenHeight * .25),
          ),
        ),
        SliverToBoxAdapter(
          child: userProfileBody(PatientProfileModel, context),
        ),
      ],
    );
  }
}
