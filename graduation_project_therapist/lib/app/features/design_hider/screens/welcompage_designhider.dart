import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/bloc/sign_in_cubit/sign_in_cubit.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class DesignHidderRegisterPage extends StatelessWidget {
  const DesignHidderRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    SignInCubit signInCubit = context.read<SignInCubit>();
    signInCubit.passwordtextgController = TextEditingController();
    return Scaffold(
      backgroundColor: customColors.primaryBackGround,
      body: Center(
          child: BlocListener<SignInCubit, SignInState>(
        listener: (context, state) {
          if (state is SuccessRequest) {
            // navigationService.navigationOfAllPagesToName(
            //     context, bottomNavigationBar);
            navigationService.navigationOfAllPagesToName(
                context, medicalDescriptionPage);
          }
        },
        child: BlocBuilder<SignInCubit, SignInState>(
          builder: (context, state) {
            bool isLoading = state is SignInLoadingState;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      signInCubit.userEmail = 'mab026550@gmail.com';
                      signInCubit.passwordtextgController.text = 'Hdr@2132';
                      signInCubit.sendSignInRequest();
                    },
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Container(
                            decoration: BoxDecoration(
                                color: customColors.primary,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Text('sign in',
                                  style: customTextStyle.bodyMedium),
                            ),
                          ),
                  ),
                  GestureDetector(
                    onTap: () {
                      signInCubit.userEmail = 'abmayar208@gmail.com';
                      signInCubit.passwordtextgController.text = 'Hdr@2132';
                      signInCubit.sendSignInRequest();
                    },
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Container(
                            decoration: BoxDecoration(
                                color: customColors.primary,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Text('sign in as a therapist',
                                  style: customTextStyle.bodyMedium),
                            ),
                          ),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigationService.navigateTo(videoCallPage);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: customColors.primary,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text('go to Video Call Page',
                            style: customTextStyle.bodyMedium),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigationService.navigateTo(chatPage);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: customColors.primary,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text('go to Chat Page',
                            style: customTextStyle.bodyMedium),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigationService.navigateTo(medicalDescriptionPage);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: customColors.primary,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text('go to medical Description Page',
                            style: customTextStyle.bodyMedium),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      )),
    );
  }
}
