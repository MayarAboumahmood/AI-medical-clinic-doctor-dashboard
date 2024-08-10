import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/dialog_snackbar_pop_up/custom_snackbar.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import '../../../core/status_requests/staus_request.dart';

void messageDisplayWidget(
    {required StatusRequest statusRequest,
    required BuildContext context}) async {
  bool messageAlreadyShowed = false;
  switch (statusRequest) {
    case StatusRequest.sucess:
      break;
    case StatusRequest.validationError:
      if (!messageAlreadyShowed) {
        messageAlreadyShowed = true;
        customSnackBar('validationError.', context);
      }
      break;
    case StatusRequest.authErorr:
      navigationService.navigationOfAllPagesToName(context, welcomeScreen);
      sharedPreferences!.remove('token');
      sharedPreferences!.remove('user_profile');
      sharedPreferences!.remove('isRegisterCompleted');

      customSnackBar('Authentication error. Please log in again.', context);
      break;
    case StatusRequest.serverError:
      if (!messageAlreadyShowed) {
        messageAlreadyShowed = true;
        // if (!await checkInternet()) {
        //   if (context.mounted) {
        //     customSnackBar(
        //       'check your internet connection',
        //       context,
        //     );
        //   }
        // } else {
          if (context.mounted) {
            customSnackBar('Server Error', context, isFloating: true);
          }
        // }
      }
      break;
    default:
  }
}

showSnackBar({required String message, required BuildContext context}) {
  return ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message)));
}
