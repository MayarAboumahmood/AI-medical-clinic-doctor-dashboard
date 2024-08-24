import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/user_profile/cubit/user_profile_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/user_profile/data_source/models/patient_profile_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/user_profile/view/widgets/get_phq9_recommendation.dart';
import 'package:graduation_project_therapist_dashboard/app/features/user_profile/view/widgets/user_profile_body.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
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
  late int patientID;
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
      patientID = argument;
      userProfileCubit.getUserProfile(patientID);
    }
  }

  PatientProfileModel? localPatientProfileModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.primaryBackGround,
      body: BlocListener<UserProfileCubit, UserProfileState>(
        listener: (context, state) {
          print('the state in the user profile:$state');
          if (state is UserProfileErrorState) {
            customSnackBar(state.errorMessage, context, isFloating: true);
          } else if (state is PatientAssignedToTherapistState) {
            state.isRequest
                ? customSnackBar('The request has been sent', context)
                : customSnackBar('Patient Assigned successfully', context);
          } else if (state is AssignPatientToTherapistErrorState) {
            customSnackBar(state.errorMessage, context);
          }
        },
        child: userProfileSilverAppBar(),
      ),
    );
  }

  Widget userProfileSilverAppBar() {
    return CustomScrollView(
      slivers: [
        slivarAppBar(),
        profileBody(),
        divider(),
        patientBoxScoreBody(),
        divider(),
        profileButton(),
      ],
    );
  }

  SliverToBoxAdapter divider() {
    return SliverToBoxAdapter(
      child: Padding(
          padding: const EdgeInsets.all(8.0), child: profilePageDivider()),
    );
  }

  SliverToBoxAdapter profileBody() {
    return SliverToBoxAdapter(
      child: BlocBuilder<UserProfileCubit, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileLoadingState) {
            return patientProfileBodyShimmer();
          } else if (state is AssignPatientToTherapistErrorState ||
              state is PatientAssignedToTherapistState ||
              state is GetPatientBotScoreErrorState ||
              state is GetingPatientBotScoreDoneState ||
              state is GetPatientBotScoreLoadingState) {
            return userProfileBody(localPatientProfileModel!, context);
          } else if (state is UserProfileGetData) {
            userProfileCubit.getPatientsBotScore(patientID);

            localPatientProfileModel = state.patientProfileModel;
            return userProfileBody(state.patientProfileModel, context);
          }
          return patientProfileBodyShimmer();
        },
      ),
    );
  }

  SliverToBoxAdapter profileButton() {
    return SliverToBoxAdapter(
      child: BlocBuilder<UserProfileCubit, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileLoadingState) {
            return generalElementForEachCardShimmer();
          } else if (state is AssignPatientToTherapistErrorState ||
              state is PatientAssignedToTherapistState ||
              state is GetPatientBotScoreErrorState ||
              state is GetingPatientBotScoreDoneState ||
              state is GetPatientBotScoreLoadingState) {
            return buildPatientProfileButtons(
                context, localPatientProfileModel!);
          } else if (state is UserProfileGetData) {
            localPatientProfileModel = state.patientProfileModel;
            return buildPatientProfileButtons(
                context, state.patientProfileModel);
          }
          return generalElementForEachCardShimmer();
        },
      ),
    );
  }

  String cachedScore = 'Loading...'.tr();
  SliverToBoxAdapter patientBoxScoreBody() {
    return SliverToBoxAdapter(
      child: BlocBuilder<UserProfileCubit, UserProfileState>(
        builder: (context, state) {
          if (state is GetPatientBotScoreLoadingState) {
            return patientBotScoreShimmer();
          } else if (state is GetPatientBotScoreErrorState) {
            return errorTryAgainButton();
          } else if (state is GetingPatientBotScoreDoneState) {
            cachedScore = state.botScore;
            return circularBotScore(state.botScore);
          }
          return circularBotScore(cachedScore);
        },
      ),
    );
  }

  Widget circularBotScore(String botScore) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoSection('Bot Score', botScore),
        infoSection('The PHQ9 recommendation', getPHQ9Recommendation(botScore)),
      ],
    );
  }

  Column errorTryAgainButton() {
    return Column(
      children: [
        Text("Error while retrieving the score.".tr(),
            style: customTextStyle.bodyMedium),
        tryAgainButton(),
        SizedBox(
          height: responsiveUtil.screenHeight * .1,
        )
      ],
    );
  }

  GeneralButtonOptions tryAgainButton() {
    return GeneralButtonOptions(
        text: 'Try again',
        onPressed: () {
          userProfileCubit.getPatientsBotScore(patientID);
        },
        options: ButtonOptions(
            color: customColors.primary, textStyle: customTextStyle.bodySmall));
  }

  SliverAppBar slivarAppBar() {
    return SliverAppBar(
      iconTheme: IconThemeData(color: customColors.primary),
      expandedHeight: responsiveUtil.screenHeight * .25,
      floating: false,
      pinned: true,
      backgroundColor: customColors.secondaryBackGround,
      flexibleSpace: BlocBuilder<UserProfileCubit, UserProfileState>(
          builder: (context, state) {
        if (state is UserProfileLoadingState) {
          return const SizedBox();
        } else if (state is AssignPatientToTherapistErrorState ||
            state is PatientAssignedToTherapistState ||
            state is GetPatientBotScoreErrorState ||
            state is GetingPatientBotScoreDoneState ||
            state is GetPatientBotScoreLoadingState) {
          return flexiblePatientName(localPatientProfileModel!.data.fullName);
        } else if (state is UserProfileGetData) {
          localPatientProfileModel = state.patientProfileModel;
          return flexiblePatientName(state.patientProfileModel.data.fullName);
        }
        return const SizedBox();
      }),
    );
  }

  FlexibleSpaceBar flexiblePatientName(String patientName) {
    return FlexibleSpaceBar(
      centerTitle: true,
      title: Text(patientName,
          style: customTextStyle.headlineMedium.copyWith(color: Colors.white)),
      background: backGroundImage(),
    );
  }

  BlocBuilder<UserProfileCubit, UserProfileState> backGroundImage() {
    return BlocBuilder<UserProfileCubit, UserProfileState>(
      builder: (context, state) {
        if (state is UserProfileLoadingState) {
          return patientProfileImageShimmer();
        } else if (state is AssignPatientToTherapistErrorState ||
            state is PatientAssignedToTherapistState ||
            state is GetPatientBotScoreErrorState ||
            state is GetingPatientBotScoreDoneState ||
            state is GetPatientBotScoreLoadingState) {
          return patientImageWidget(localPatientProfileModel!.data.fullName);
        } else if (state is UserProfileGetData) {
          localPatientProfileModel = state.patientProfileModel;
          return patientImageWidget(state.patientProfileModel.data.fullName);
        }
        return patientProfileImageShimmer();
      },
    );
  }

  Widget patientImageWidget(String image) {
    return getImageNetwork(
        url: image,
        forProfileImage: true,
        fit: BoxFit.cover,
        width: responsiveUtil.screenWidth,
        height: responsiveUtil.screenHeight * .25);
  }
}
