import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        backgroundColor: customColors.primaryBackGround,
        body: BlocBuilder<HomePageBloc, HomePageState>(
          builder: (context, state) {
            return SizedBox(
              height: responsiveUtil.screenHeight * .3,
              width: responsiveUtil.screenWidth * .3,
              child: Center(
                  child: Text(
                userStatus.name.tr(),
                style: customTextStyle.bodyMedium,
              )),
            );
          },
        ),
      ),
    );
  }
}
