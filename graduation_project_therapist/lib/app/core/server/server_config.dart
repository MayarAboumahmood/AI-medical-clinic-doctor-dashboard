class ServerConfig {
  static const String url = "http://127.0.0.1:3000/";
  static const String imageUrl = '${url}storage/';
  // static const String url =
  //     "http://192.168.100.21:3000/"; //for mobile with ip config.

  static const String baseURL = url;
  static const String baseURLForSearch = '$url/api/';
  static const String images = '$url/';
  static const String register = 'specs/register';
  static const String completeRegister = 'specs/clinicRegistrationRequest';
  static const String login = 'specs/login';
  static const String otpVerify = 'otp/verify';
  static const String sendOTP = 'otp/sendOTP';
  static const String getUserInfourl = 'specs/profile';
  static const String getUserStatus = 'specs/status';
  static const String passwordforgotChangePassword = 'specs/password/forgot';
  static const String notifications = 'notification';
  static const String editProfile = 'specs/profile/edit';
  static const String resetPassword = 'specs/password/reset';
  static const String deleteAccountURL = 'specs/delete';
  static const String getAllNotificationURL = 'get_notifications';
  static const String getAllTherapists = 'specs/';
  static const String getMyTherapists = 'specs/'; //Todo:
  static const String assignTherapist = 'specs/employmentRequests/send';
  static const String removeTherapist = 'specs/clinic/employees/';
  static const String getHistory = 'specs/clinic/withdraw';
  static const String makeRequestToGetMoneyUri = 'specs/clinic/withdraw';
  static const String getAvailableFundsuri = 'specs/wallet/balance';
  static const String getAllDoctorEmploymentRequests =
      'specs/employmentRequests';
  static const String approveDoctorEmploymentRequestsuri =
      'specs/employmentRequests';
}
