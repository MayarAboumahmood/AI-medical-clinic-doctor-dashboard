// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:graduation_project_therapist_dashboard/app/core/constants/app_images/app_images.dart';
// import 'package:graduation_project_therapist_dashboard/app/features/auth/bloc/sign_in_cubit/sign_in_cubit.dart';
// import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
// import 'package:graduation_project_therapist_dashboard/main.dart';

// import '../../../../../core/constants/app_string/app_string.dart';
// import '../../widgets/steps_widget/navigat_button.dart';
// import '../../widgets/steps_widget/pin_widget.dart';

// // ignore: must_be_immutable
// class ForgetPasswordOTP extends StatelessWidget {
//   const ForgetPasswordOTP({super.key});
//   @override
//   Widget build(BuildContext context) {
//     SignInCubit signInCubit = context.read<SignInCubit>();

//     return PopScope(
//       canPop: false,
//       onPopInvoked: (didPop) {
//         signInCubit.phoneNumber = '';
//         signInCubit.pin = '';

//         Navigator.pushNamedAndRemoveUntil(
//           context,
//           welcomScreen,
//           (route) => false,
//         );
//       },
//       child:
//           BlocConsumer<SignInCubit, SignInState>(listener: (ccontext, state) {
//         if (state is SuccessRequestForgetPasswordOTP) {
//           Navigator.pushNamedAndRemoveUntil(
//             context,
//             forgetPasswordResetPassword,
//             (route) => false,
//           );
//         } else if (state is ValidationErrorRequest) {
//           customSnackBar('You code is out of date', context, isFloating: true);
//         } else if (state is AuthenticationErorrState) {
//           customSnackBar('You code is out of date', context, isFloating: true);
//         } else if (state is ServerErrorRequest) {
//           customSnackBar(getMessageFromStatus(state.statusRequest), context,
//               isFloating: true);
//         }
//       }, builder: (context, state) {
//         final phoneNumber = signInCubit.phoneNumber; // Access the phone number

//         final isLoading = state is LoadingRequest;
//         return Scaffold(
//             backgroundColor: customColors.primaryBackGround,
//             // appBar: buildAppBarWithLineIndicatorincenter(1, context),
//             body: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   buildForgetPasswordOTPBody(
//                       context, isLoading, phoneNumber, signInCubit)
//                 ],
//               ),
//             ));
//       }),
//     );
//   }
// }

// Widget buildForgetPasswordOTPBody(BuildContext context, isloading,
//     String phoneNumber, SignInCubit signInCubit) {
//   TextEditingController? pinCodeController = TextEditingController();
//   pinCodeController.text = signInCubit.pin;
//   return Padding(
//     padding: const EdgeInsetsDirectional.fromSTEB(20, 48, 20, 0),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       mainAxisSize: MainAxisSize.max,
//       children: [
//         SizedBox(
//           height: responsiveUtil.screenHeight * .1,
//         ),
//         Text(
//           'Verify your number'.tr(),
//           style: customTextStyle.bodyLarge,
//         ),
//         Padding(
//           padding: responsiveUtil.padding(10, 12, 0, 0),
//           child: Text(
//             "${'We\'ll text you on'.tr()} $phoneNumber",
//             textAlign: TextAlign.center,
//             style: customTextStyle.bodyMedium.copyWith(
//               fontFamily: 'Readex Pro',
//               fontSize: 14,
//               letterSpacing: 0.2,
//               fontWeight: FontWeight.normal,
//             ),
//           ),
//         ),
//         Padding(
//           padding: responsiveUtil.padding(50, 0, 0, 0),
//           child: Image.asset(
//             AppImages.otpImage,
//             height: 180,
//             fit: BoxFit.contain,
//           ),
//         ),
//         // .animateOnPageLoad(
//         //     animationsMap['imageOnPageLoadAnimation']!),
//         const SizedBox(
//           height: 100,
//         ),
//         otpWidget(context, (value) {
//           signInCubit.pinUpdated(pin: value!);
//         }, pinCodeController: pinCodeController),
//         Padding(
//           padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
//           child: Text(
//             AppString.sendNewCode.tr(),
//             style: customTextStyle.bodyMedium.copyWith(
//               // fontFamily: 'Readex Pro',
//               color: customColors.primary,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         navigateButton(() {
//           signInCubit.forgetPasswordSendOTPCodeEvent();
//         }, AppString.continueButton.tr(), isloading)
//       ],
//     ),
//   );
// }
