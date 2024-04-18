import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/bottom_navigation_bar/bloc/bottom_navigation_widget_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/screens/profile/profile_screen.dart';
import 'package:graduation_project_therapist_dashboard/app/features/registration_data_complete/view/screens/your_data_notcompleted_yet_page.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/buttons/button_with_options.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/geust/geust_page.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:pushy_flutter/pushy_flutter.dart';
import 'icon_navigation.dart';

// ignore: must_be_immutable
class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

// LocationService locationService = LocationService();

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _currentPage = 0;
  @override
  void initState() {
    if (mounted) {
      _checkAndRequestBatteryOptimization(context);
    }
    // locationService.getCurrentLocation();

    super.initState();
  }

  List<Widget> get homePageWidgets {
    return [
      const SizedBox(),
      isGuest == true ? GuestWidget() :  YourDataNotCompletedYetPage(),
      isGuest == true ? GuestWidget() : const SizedBox(),
      isGuest == true ? GuestWidget() : const SizedBox(),
      isGuest == true ? GuestWidget() : const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationWidgetBloc, BottomNavigationWidgetState>(
      builder: (context, state) {
        if (state is PageChangedIndex) {
          _currentPage = state.currentPage;
        }
        return PopScope(
          onPopInvoked: (d) {
            BlocProvider.of<BottomNavigationWidgetBloc>(context)
                .add(const ChangeCurrentPage(nextIndex: 0));
          },
          canPop: _currentPage == 0,
          child: Scaffold(
            extendBody: true,
            backgroundColor: customColors.primaryBackGround,
            bottomNavigationBar: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              ),
              child: BottomAppBar(
                shape:
                    const CircularNotchedRectangle(), // Optional: Use a circular notch
                notchMargin: 15.0, // Optional: Adjust notch margin

                color: customColors.secondaryBackGround,
                height: 65,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    iconPagesButton(
                        context: context,
                        icon: _currentPage == 0
                            ? Icons.home
                            : Icons.home_outlined,
                        index: 0,
                        currentPage: _currentPage),
                    iconPagesButton(
                        context: context,
                        icon: _currentPage == 1
                            ? Icons.favorite
                            : Icons.favorite_outline,
                        currentPage: _currentPage,
                        index: 1),
                    iconPagesButton(
                        context: context,
                        icon: _currentPage == 2
                            ? Icons.explore
                            : Icons.explore_outlined,
                        currentPage: _currentPage,
                        index: 2),
                    iconPagesButton(
                        context: context,
                        icon: _currentPage == 3
                            ? CupertinoIcons.chat_bubble_2_fill
                            : CupertinoIcons.chat_bubble_2,
                        currentPage: _currentPage,
                        index: 3),
                    iconPagesButton(
                        context: context,
                        icon: _currentPage == 4
                            ? Icons.person
                            : Icons.person_outline,
                        currentPage: _currentPage,
                        index: 4),
                  ],
                ),
              ),
            ),
            body: homePageWidgets[_currentPage],
          ),
        );
      },
    );
  }

  Padding mapCard() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            color: customColors.primary,
            borderRadius: BorderRadius.circular(100)),
        child: Icon(
          Icons.map_outlined,
          color: customColors.info,
          size: 35,
        ),
      ),
    );
  }

  SizedBox sizedBoxBetweenBottomnavBar() => SizedBox(
        width: responsiveUtil.screenWidth * .11,
      );
}

void _checkAndRequestBatteryOptimization(BuildContext context) async {
  // Check if the app is ignoring battery optimizations
  bool isIgnoringBatteryOptimizations =
      await Pushy.isIgnoringBatteryOptimizations();
  bool alreadyAsked = sharedPreferences!.containsKey('AlreadyAsked');
  // If not ignoring, then show the dialog
  if (!isIgnoringBatteryOptimizations && !alreadyAsked) {
    sharedPreferences!.setBool('AlreadyAsked', true);
    showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: customColors.primaryBackGround,
          title: Text(
            'Improve Notification Reliability'.tr(),
            style: customTextStyle.bodyLarge,
          ),
          content: Text(
            'Allowing the app to run without battery restrictions can improve notification reliability and doesn\'t significantly affect battery life.'
                .tr(),
            style: customTextStyle.bodyMedium,
          ),
          actions: <Widget>[
            goToSettingToRemoveBattaryOpButton(),
            cancelButton(),
          ],
        );
      },
    );
  }
}

GeneralButtonOptions cancelButton() {
  return GeneralButtonOptions(
    text: 'Cancel'.tr(),
    options: ButtonOptions(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: customColors.error,
        width: 1,
      ),
      color: customColors.primaryBackGround,
      textStyle: customTextStyle.bodyMedium.copyWith(color: customColors.error),
    ),
    onPressed: () {
      navigationService.goBack(); // Just close the dialog
    },
  );
}

GeneralButtonOptions goToSettingToRemoveBattaryOpButton() {
  return GeneralButtonOptions(
    text: 'let\'s Do it'.tr(),
    options: ButtonOptions(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: customColors.primary,
        width: 1,
      ),
      color: customColors.primary,
      textStyle: customTextStyle.bodyMedium.copyWith(
          color: customColors.primaryText, fontWeight: FontWeight.w800),
    ),
    onPressed: () {
      navigationService.goBack(); // Just close the dialog
      removeBatteryRestrictionForNotification();
    },
  );
}

void removeBatteryRestrictionForNotification() {
  // Launch the battery optimizations activity
  Pushy.launchBatteryOptimizationsActivity();
}
