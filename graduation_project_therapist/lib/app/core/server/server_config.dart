class ServerConfig {
  // static const String url = "http://127.0.0.1:3000/";
  static const String url = "https://backend-cznw.onrender.com/"; //the server

  static const String imageUrl = '${url}storage/';
  // static const String url =
  // "http://192.168.100.13:3000/"; //for mobile with ip config.

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
  static const String getAllTherapists = 'specs';
  static const String getMyTherapists = 'specs/clinic/employees';
  static const String assignTherapist = 'specs/employmentRequests/send';
  static const String removeTherapist = 'specs/clinic/employees/';
  static const String getHistory = 'specs/clinic/withdraw';
  static const String makeRequestToGetMoneyUri = 'specs/clinic/withdraw';
  static const String getAvailableFundsuri = 'specs/wallet/balance';
  static const String getAllDoctorEmploymentRequests =
      'specs/employmentRequests';
  static const String approveDoctorEmploymentRequestsuri =
      'specs/employmentRequests';
  static const String getAppointmentsuri = 'appointment/specialist';
  static const String cancelAppointment =
      'appointment/cancellation/'; //here the id.
  static const String getPatientrequestUri = 'appointment/request/specialist';
  static const String acceptPatientrequest = 'appointment/request/';
  static const String rejectPatientrequest = 'appointment/request/';
  static const String getAllMedicalRecordsUri = 'specs/medicalRecords/';
  static const String createMedicalRecordsUri = 'specs/medicalRecords';
  static const String editMedicalRecordsUri = 'specs/medicalRecords/update/';
  static const String getPatientsUri = 'specs/patients';
  static const String getPatientsProfileUri =
      'specs/patients/'; //... id/profile
  static const String cancelPatientReservationUri = 'appointment/cancellation/';
  static const String assignPatientToTherapistUri = 'specs/assignment/';
  static const String getMedicalRecordDetailsUri =
      'specs/medicalRecords/getRecord/';
  static const String therapistRequestToPateintUri =
      'appointment/request/specialist/createRequest';
  static const String getChatInfoUri = 'chat/getChat/';
  static const String blockPatienturi = 'blocks';
  static const String unBlockPatienturi = 'blocks/undo';
  static const String reportPatientUri = 'reports/user';
  static const String reportMedicalRecordUri = 'reports/medicalRecord';
  static const String getCategoriesUri = 'categories';
  static const String getBotScoreUri = 'botScore';
  static const String videoCallCompleteUri = 'appointment/complete';
  static const String checkIfSessionCompleteUri = 'appointment/check/';
  static const String sendToBackendForNotificationUrl = 'chat/message';
  static const String reportVideoCallUri = 'reports/appointment';
}
