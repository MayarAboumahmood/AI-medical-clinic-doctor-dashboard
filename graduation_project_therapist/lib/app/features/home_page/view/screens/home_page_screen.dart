import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/home_page/bloc/home_page_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';

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
          context.read<HomePageBloc>().add(LoadHomePageDataEvent());
        } else if (state is FetchDataFauilerState) {
          customSnackBar(state.errorMessage, context,isFloating: true);
        }
      },
      child: const Scaffold(),
    );
  }
}
