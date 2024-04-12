import 'package:easy_localization/easy_localization.dart';

import '../../core/status_requests/staus_request.dart';

StatusRequest getStatusFromCode(int code) {
  switch (code) {
    case 200:
      return StatusRequest.sucess;
    case 201:
      return StatusRequest.validationErrorFormat;
    case 400:
      return StatusRequest.validationError;
    case 401:
      return StatusRequest.authErorr;
    case 403:
      return StatusRequest.validationErrorFormat;
    case 402:
      return StatusRequest.validationErrorFormat;
    case 500:
      return StatusRequest.serverError;
    case 404:
      return StatusRequest.urlError;
    default:
      return StatusRequest.serverError;
    // throw Exception('Unknown status code: $code');
  }
}

String getMessageFromStatus(StatusRequest status) {
  switch (status) {
    case StatusRequest.youAreBloced:
      return 'Access Denied: Your account has been temporarily blocked'.tr();
    case StatusRequest.urlError:
      return 'Something wrong!, Server Error'.tr();
    case StatusRequest.wrongOTPCode:
      return 'Invalid OTP code. Please check and try again, or request a new code.'
          .tr();
    case StatusRequest.serverError:
      return 'Something wrong!, Server Error'.tr();
    case StatusRequest.validationErrorFormat:
      return 'Your phone number is not in the right format!'.tr();
    case StatusRequest.validationError:
      return 'Something wrong!, Validation Error'.tr();
    case StatusRequest.authErorr:
      return 'Something wrong!, Authentication Error'.tr();
    case StatusRequest.sucess:
      return 'Done'.tr();
    default:
      return 'Something wrong!, Server Error'.tr();
    // throw Exception('Unknown status code: $code');
  }
}
