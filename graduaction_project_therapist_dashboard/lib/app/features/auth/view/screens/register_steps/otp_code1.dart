import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_images/app_images.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/bloc/register_cubit/register_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/view/widgets/steps_widget/app_bar_steps.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/get_status_request_from_status_code.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import '../../../../../core/constants/app_string/app_string.dart';
import '../../widgets/steps_widget/navigat_button.dart';
import '../../widgets/steps_widget/pin_widget.dart';
import '../../widgets/steps_widget/riched_text.dart';

class OTPCodeStep extends StatefulWidget {
  const OTPCodeStep({super.key});

  @override
  State<OTPCodeStep> createState() => _OTPCodeStepState();
}

class _OTPCodeStepState extends State<OTPCodeStep> {
  late Timer timer;
  int tickCount = 0;
  int minitTimer = 0;

  void startTImer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        tickCount = t.tick % 60;
        minitTimer = t.tick ~/ 60;
      });
      // Check if you've reached the desired duration (6 minutes in this case)
      if (t.tick == 60 * 6) {
        // Do something when the timer reaches 6 minutes
        t.cancel(); // Stop the timer
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  void initState() {
    super.initState();
    startTImer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterOTPSendSuccessRequest) {
            navigationService.navigationOfAllPagesToName(
                context, bottomNavigationBar);
          } else if (state is RegisterValidationErrorRequest) {
            customSnackBar('Check your inputs', context);
          } else if (state is RegisterServerErrorRequest) {
            customSnackBar(getMessageFromStatus(state.statusRequest), context);
          }
        },
        child: Scaffold(
            backgroundColor: customColors.primaryBackGround,
            appBar: buildAppBarWithLineIndicatorincenter(4, context),
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [buildOTPCodeStep1(context)],
              ),
            )));
  }

  Text buildTimerTextValue() {
    return Text(
      '${'Timer'.tr()} $minitTimer:$tickCount',
      style: customTextStyle.bodySmall.copyWith(
        fontFamily: 'Readex Pro',
      ),
    );
  }

  Widget buildOTPCodeStep1(BuildContext context) {
    final RegisterCubit registerCubit = context.read<RegisterCubit>();
    final String userEmail = registerCubit.userInfo.userEmail;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: responsiveUtil.screenHeight * .04,
          horizontal: responsiveUtil.screenWidth * .04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          richedTextSteps(context, 2),
          Padding(
            padding: responsiveUtil.padding(
                responsiveUtil.screenWidth * .012, 0, 0, 0),
            child: Text(
              "${'We\'ll send the otp code on: '.tr()} $userEmail",
              textAlign: TextAlign.center,
              style: customTextStyle.bodyMedium.copyWith(
                fontFamily: 'Readex Pro',
                fontSize: 14,
                letterSpacing: 0.2,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Padding(
            padding: responsiveUtil.padding(
                responsiveUtil.screenHeight * .05, 0, 0, 0),
            child: Image.asset(
              AppImages.otpImage,
              height: 180,
              fit: BoxFit.contain,
            ),
          ),
          // .animateOnPageLoad(
          //     animationsMap['imageOnPageLoadAnimation']!),
          SizedBox(
            height: responsiveUtil.screenHeight * .09,
          ),
          otpWidget(context, (value) {
            registerCubit.otpCode = value!;
          }),
          buildTimerTextValue(),
          Padding(
            padding: EdgeInsets.only(top: responsiveUtil.screenHeight * .01),
            child: Text(
              AppString.sendNewCode.tr(),
              style: customTextStyle.bodyMedium.copyWith(
                // fontFamily: 'Readex Pro',
                color: customColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: responsiveUtil.screenHeight * .024,
          ),
          BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              final isLoading = state is RegisterLoadingRequest;
              return navigateButton(() {
                registerCubit.sendVerifyPinRequest();
              }, AppString.continueButton.tr(), isLoading);
            },
          )
        ],
      ),
    );
  }
}
