// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:graduation_project_therapist_dashboard/app/core/constants/app_images/app_images.dart';
// import 'package:graduation_project_therapist_dashboard/app/features/auth/bloc/sign_in_cubit/sign_in_cubit.dart';
// import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/format_the_syrain_number.dart';
// import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/get_status_request_from_status_code.dart';
// import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/validation_functions.dart';
// import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
// import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/text_related_widget/text_fields/text_field.dart';
// import 'package:graduation_project_therapist_dashboard/main.dart';

// import '../../../../../core/constants/app_string/app_string.dart';

// import '../../widgets/steps_widget/navigat_button.dart';

// final GlobalKey<FormState> formKey = GlobalKey<FormState>();
// String? phoneNumber;

// class ForgetPasswordEmail extends StatelessWidget {
//   const ForgetPasswordEmail({super.key});

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
//         if (state is SuccessRequest) {
//           Navigator.pushNamedAndRemoveUntil(
//             context,
//             forgetPasswordOTP,
//             (route) => false,
//           );
//         } else if (state is ValidationErrorRequest) {
//           customSnackBar('Check your inputs', context);
//         } else if (state is AuthenticationErorrState) {
//           customSnackBar('Wrong phone number!', context, isFloating: true);
//         } else if (state is ServerErrorRequest) {
//           customSnackBar(getMessageFromStatus(state.statusRequest), context,
//               isFloating: true);
//         }
//       }, builder: (context, state) {
//         final isLoading = state is LoadingRequest;
//         return Scaffold(
//             backgroundColor: customColors.primaryBackGround,
//             body: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   buildForgetPasswordPhoneBody(context, isLoading, formKey)
//                 ],
//               ),
//             ));
//       }),
//     );
//   }
// }

// Widget buildForgetPasswordPhoneBody(
//     BuildContext context, isloading, GlobalKey<FormState> formKey) {
//   SignInCubit signInCubit = context.read<SignInCubit>();
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
//           'First step'.tr(),
//           style: customTextStyle.bodyLarge,
//         ),
//         Padding(
//           padding: responsiveUtil.padding(10, 12, 0, 0),
//           child: Text(
//             'enter Your phone Number'.tr(),
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
//             AppImages.phoneNumberImage,
//             height: 180,
//             fit: BoxFit.contain,
//           ),
//         ),
//         // .animateOnPageLoad(
//         //     animationsMap['imageOnPageLoadAnimation']!),
//         SizedBox(
//           height: responsiveUtil.screenHeight * .115,
//         ),
//         Form(
//           key: formKey,
//           child: SizedBox(
//             width: 300,
//             child: customTextField(
//                 textInputType: TextInputType.phone,
//                 validator: (value) {
//                   return ValidationFunctions.validateSyrianPhoneNumber(value!);
//                 },
//                 context: context,
//                 onSaved: (value) {
//                   signInCubit.phoneNumber =
//                       formatSyrianPhoneNumber(value ?? '');
//                 },
//                 label: 'Phone Number'.tr()),
//           ),
//         ),
//         navigateButton(() {
//           FormState? formdata = formKey.currentState;
//           if (formdata!.validate()) {
//             formdata.save();
//             signInCubit.forgetPasswordSendPhoneNumber();
//           }
//         }, AppString.continueButton.tr(), isloading)
//       ],
//     ),
//   );
// }
