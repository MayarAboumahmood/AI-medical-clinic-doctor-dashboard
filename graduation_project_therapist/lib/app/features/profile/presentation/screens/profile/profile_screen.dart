import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/core/injection/app_injection.dart';
import 'package:graduation_project_therapist_dashboard/app/core/service/shared_preferences.dart';
import 'package:graduation_project_therapist_dashboard/app/core/utils/flutter_flow_util.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/view/widgets/welcome_screen_widget.dart/language_widget.dart';
import 'package:graduation_project_therapist_dashboard/app/features/block_and_report/bloc/block_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/bottom_navigation_bar/bloc/bottom_navigation_widget_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/doctor_employment_requests/cubit/doctor_employment_requests_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/cubit/get_all_therapist_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_patients/cubit/get_patients_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/home_page/data_source/models/user_profile_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/home_page/data_source/models/user_status_enum.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/cubit/patient_requests_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_reservations/cubit/patient_reservations_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/bloc/profile_event.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/bloc/profile_state.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/widgets/account_choice_widget.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/widgets/edit_profile_widgets/location_notification_widget.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_blocs/user_data_block/user_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_blocs/user_data_block/user_data_event.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/show_bottom_sheet.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/terms_of_use_bottom_sheet.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/build_image_with_name.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userName = '';

  Future<String?> getUserDataFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('user_profile')) return null;

    String userProfileString = prefs.getString('user_profile')!;
    Map<String, dynamic> userJson = json.decode(userProfileString);
    return UserProfileModel.fromMap(userJson).fullName;
  }

  Future<void> initializeUserData() async {
    userName = await getUserDataFromPrefs();
    setState(() {
      if (userName == null || userName == '') {
        userName = 'your name';
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initializeUserData();
  }

  @override
  Widget build(BuildContext context) {
    //to stor the user data in the
    if (sharedPreferences!.containsKey('user_profile') == false) {
      BlocProvider.of<GetUserDataBloc>(context).add(GetUserDataEvent());
    }
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is AccountDeletedState) {
          Navigator.pushNamedAndRemoveUntil(
              context, welcomeScreen, (route) => false);
          logOutClearBloc(context);
          Future.delayed(const Duration(milliseconds: 400), () {
            logOut();
          });
          customSnackBar('Your account was deleted successfully.', context);
        } else if (state is ServerErrorRequest) {
          customSnackBar(state.errorMessage, context, isFloating: true);
        }
      },
      child: profileBody(context),
    );
  }

  SingleChildScrollView profileBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: responsiveUtil.screenHeight * .1,
          ),
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is SuccessEditRequest) {
                return buildImageWithName(state.name, context);
              }

              return buildImageWithName(userName!, context);
            },
          ),
          SizedBox(
            height: responsiveUtil.scaleHeight(50),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // accountChoiceWidget(
                //     title: "Notification".tr(),
                //     icon: Icons.notifications_none_outlined,
                //     onTap: () {
                //       navigationService.navigateTo('/notification');
                //     }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: accountAndThemeWidgetForEditProfile(context),
                  ),
                ),
                accountChoiceWidget(
                    title: "Change password".tr(),
                    icon: Icons.password,
                    onTap: () {
                      navigationService.navigateTo(changePasswordPage);
                    }),
                accountChoiceWidget(
                    title: "Language".tr(),
                    icon: Icons.language,
                    onTap: () {
                      showChangeLangeuageDrowpDownDialog(context);
                    }),
                profilePageDivider(),
                (sharedPreferences!.getString('user_status') ==
                        UserStatusEnum.verified.name)
                    ? isDoctor
                        ? doctorColumn()
                        : therapistColumn()
                    : SizedBox(),
                (sharedPreferences!.getString('user_status') ==
                        UserStatusEnum.verified.name)
                    ? accountChoiceWidget(
                        title: "Patients".tr(),
                        icon: Icons.people,
                        onTap: () {
                          navigationService.navigateTo(getPatientsPage);
                        })
                    : const SizedBox(),
                accountChoiceWidget(
                    title: "Wallet".tr(),
                    icon: Icons.account_balance_wallet_outlined,
                    onTap: () {
                      navigationService.navigateTo(walletPage);
                    }),
                profilePageDivider(),
                accountChoiceWidget(
                    title: "Help center".tr(),
                    icon: Icons.headset_mic_rounded,
                    onTap: () {
                      navigationService.navigateTo(helpCenter);
                    }),
                accountChoiceWidget(
                    title: "Terms of Use".tr(),
                    icon: Icons.contact_support,
                    onTap: () {
                      termOfUseBottomSheet(context);
                    }),
                profilePageDivider(),
                (sharedPreferences!.getString('user_status') ==
                        UserStatusEnum.verified.name)
                    ? accountChoiceWidget(
                        title: "Blocked Patients".tr(),
                        icon: Icons.block,
                        onTap: () {
                          navigationService.navigateTo(blockedPatients);
                        })
                    : const SizedBox(),
                accountChoiceWidget(
                    isLogout: true,
                    title: "Delete your account".tr(),
                    icon: Icons.delete_outline_outlined,
                    onTap: () {
                      showBottomSheetWidget(
                          context, deleteAccountBottomSheet(context));
                    }),
                accountChoiceWidget(
                    isLogout: true,
                    title: "Log Out".tr(),
                    icon: Icons.logout_outlined,
                    onTap: () {
                      showBottomSheetWidget(
                          context, logOutBottomSheet(context));
                    }),
                const SizedBox(
                  height: 45,
                )
              ].divide(SizedBox(
                height: responsiveUtil.scaleHeight(13),
              )),
            ),
          )
        ],
      ),
    );
  }

  Column doctorColumn() {
    return Column(
      children: [
        accountChoiceWidget(
            title: "All Therapists".tr(),
            icon: Icons.person_pin_rounded,
            onTap: () {
              navigationService.navigateTo(getAllTherapistPage);
            }),
        SizedBox(
          height: responsiveUtil.scaleHeight(13),
        ),
        accountChoiceWidget(
            title: "My Therapists".tr(),
            icon: Icons.person_pin_rounded,
            onTap: () {
              navigationService.navigateTo(getMyTherapistPage);
            }),
      ],
    );
  }

  Column therapistColumn() {
    return Column(
      children: [
        accountChoiceWidget(
            title: "Doctor job request.".tr(),
            icon: Icons.person_pin_rounded,
            onTap: () {
              navigationService.navigateTo(doctorEmploymentRequestsPage);
            }),
      ],
    );
  }
}

Widget middelTitle(String title) {
  return SizedBox(
    width: responsiveUtil.screenWidth * .8,
    child: Text(
      title.tr(),
      style: customTextStyle.bodyMedium
          .copyWith(color: customColors.text2, fontWeight: FontWeight.bold),
      overflow: TextOverflow.fade,
    ),
  );
}

Widget normalDescription(String description) {
  return SizedBox(
    width: responsiveUtil.screenWidth * .9,
    child: Text(
      description.tr(),
      style: customTextStyle.bodySmall.copyWith(
          color: customColors.secondaryText, fontWeight: FontWeight.w600),
      overflow: TextOverflow.fade,
    ),
  );
}

void logOut() async {
  await sl<PrefService>().remove('user_status');
  await sl<PrefService>().remove('token');
  await sl<PrefService>().remove('user_profile');
  await sl<PrefService>().remove('isRegisterCompleted');
  await sl<PrefService>().remove('doctorOrTherapist');
  await sl<PrefService>().remove('user_status');
  await sl<PrefService>().remove('AlreadyAsked');
  userStatus = UserStatusEnum.loading;
}

void logOutClearBloc(BuildContext context) async {
  BlocProvider.of<BottomNavigationWidgetBloc>(context)
      .add(const ChangeCurrentPage(nextIndex: 0));
  context.read<GetAllTherapistCubit>().getAllTherapistModels = null;
  context.read<GetAllTherapistCubit>().getMyTherapistModels = null;
  context.read<GetPatientsCubit>().getPatientsModels = null;
  context.read<PatientRequestsCubit>().cachedUserRequests = null;
  context.read<DoctorEmploymentRequestsCubit>().doctorEmploymentRequests = null;
  context.read<BlockBloc>().allBlockedPatientModel = null;
  context.read<PatientReservationsCubit>().cachedPatientReservations = null;

  Navigator.pushNamedAndRemoveUntil(
    context,
    welcomeScreen,
    (route) => false, // This line removes all previous routes from the stack
  );
}

Widget profilePageDivider() {
  return Divider(
    height: responsiveUtil.scaleHeight(10),
    color: customColors.secondaryBackGround,
  );
}

void showChangeLangeuageDrowpDownDialog(BuildContext context) {
  showBottomSheetWidget(
      context,
      Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(width: 200, child: dropDown(context))),
      ));
}

Widget deleteAccountBottomSheet(BuildContext context) {
  return BlocBuilder<ProfileBloc, ProfileState>(
    builder: (context, state) {
      bool isLoading = state is LoadingRequest;
      return SizedBox(
        height: responsiveUtil.screenHeight * .22,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          child: Scaffold(
            body: Container(
              decoration: BoxDecoration(
                  color: customColors.primaryBackGround,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )),
              height: responsiveUtil.screenHeight * .22,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Container(
                        height: 3,
                        width: 40,
                        color: customColors.secondaryBackGround,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Center(
                        child: Text(
                      'Are you sure you want to delete your account?'.tr(),
                      style: customTextStyle.bodyLarge
                          .copyWith(fontWeight: FontWeight.w700),
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        cancelLogOutButton(context),
                        const SizedBox(
                          width: 30,
                        ),
                        deleteAccountButton(context, isLoading),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget logOutBottomSheet(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
        color: customColors.primaryBackGround,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        )),
    height: responsiveUtil.screenHeight * .22,
    child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Center(
            child: Container(
              height: 3,
              width: 40,
              color: customColors.secondaryBackGround,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Center(
              child: Text(
            'Are you sure you want to Logout?'.tr(),
            style:
                customTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.w700),
          )),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              cancelLogOutButton(context),
              const SizedBox(
                width: 30,
              ),
              logOutButton(context),
            ],
          )
        ],
      ),
    ),
  );
}

GeneralButtonOptions cancelLogOutButton(BuildContext context) {
  return GeneralButtonOptions(
    text: 'Cancel'.tr(),
    onPressed: () {
      navigationService.goBack();
    },
    options: ButtonOptions(
      height: 40,
      color: customColors.primaryBackGround,
      textStyle:
          customTextStyle.titleSmall.copyWith(color: customColors.primaryText),
      borderSide: BorderSide(
        color: customColors.primary,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
  );
}

GeneralButtonOptions logOutButton(BuildContext context) {
  return GeneralButtonOptions(
    text: 'Yes, Logout'.tr(),
    onPressed: () {
      logOutClearBloc(context);
      Future.delayed(const Duration(milliseconds: 400), () {
        logOut();
      });
    },
    options: ButtonOptions(
      height: 40,
      color: customColors.primary,
      textStyle: customTextStyle.titleSmall.copyWith(color: Colors.white),
      borderSide: BorderSide(
        color: customColors.primary,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
  );
}

GeneralButtonOptions deleteAccountButton(BuildContext context, bool isLoading) {
  ProfileBloc profileBloc = context.read<ProfileBloc>();

  return GeneralButtonOptions(
    text: 'Yes, Delete my account'.tr(),
    onPressed: () {
      profileBloc.add(const DeleteAccountEvent());
    },
    loading: isLoading,
    options: ButtonOptions(
      height: 40,
      color: customColors.error,
      textStyle: customTextStyle.titleSmall.copyWith(color: Colors.white),
      borderSide: BorderSide(
        color: customColors.error,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
  );
}
