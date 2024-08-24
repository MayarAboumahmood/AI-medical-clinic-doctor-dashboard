import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/features/home_page/bloc/home_page_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  late HomePageBloc homePageBloc;

  @override
  void initState() {
    homePageBloc = context.read<HomePageBloc>();
    homePageBloc.add(GetUserInfoEvent());
    homePageBloc.add(GetUserStatusEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomePageBloc, HomePageState>(
      listener: (context, state) {
        if (state is HomePageInitial) {
          print('home page init state');
        } else if (state is FetchDataFauilerState) {
          customSnackBar(state.errorMessage, context, isFloating: true);
        }
      },
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: FloatingActionButton.extended(
            backgroundColor: customColors.primary,
            onPressed: () {
              navigationService.navigateTo(helpCenter);
            },
            label: Text(
              '${'Provided By:'.tr()} GMMAF',
              style: customTextStyle.bodyMedium,
            ),
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        backgroundColor: customColors.primaryBackGround,
        body: BlocBuilder<HomePageBloc, HomePageState>(
          builder: (context, state) {
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 6,
                    ),
                    Image.asset(
                      'assets/images/SMHC icon.png',
                      height: 200,
                    ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height / 6,
                    // ),
                    Text(
                      '${'Welcome to the platform'.tr()}',
                      style: customTextStyle.headlineMedium,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${isDoctor ? 'Doctor'.tr() : 'Therapist'.tr()}: ${userData?.fullName}',
                      style: customTextStyle.headlineMedium,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      userStatus.name.tr(),
                      style: customTextStyle.bodyMedium,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
