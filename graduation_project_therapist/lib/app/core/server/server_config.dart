class ServerConfig {
  // static const String url = "http://127.0.0.1:3000/";
  static const String url =
      "http://192.168.100.38:3000/"; //for mobile with ip config.

  static const String baseURL = url;
  static const String baseURLForSearch = '$url/api/';
  static const String images = '$url/';
  static const String register = 'specs/register';
  static const String login = 'specs/login';
  static const String otpVerify = 'otp/verify';
  static const String sendOTP = 'otp/sendOTP';
  static const String getUserInfourl = 'specs/profile';
  static const String getUserStatus = 'specs/status';
  static const String passwordforgotChangePassword = 'specs/password/forgot';
  static const String notifications = 'notification';
  static const String editProfile = 'edit_profile';
  static const String resetPassword = 'reset_password';
  static const String deleteAccountURL = 'delete_account';
  static const String getAllNotificationURL = 'get_notifications';
}
