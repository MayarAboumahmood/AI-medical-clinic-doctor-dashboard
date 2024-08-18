import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/view/screens/forget_password/enter_email.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/view/screens/forget_password/forget_passowrd_otp.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/view/screens/forget_password/reset_password.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/view/screens/register_steps/otp_code1.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/view/screens/register_steps/password_step.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/view/screens/register_steps/select_image_step.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/view/screens/welcome_screen/wlcome_screen.dart';
import 'package:graduation_project_therapist_dashboard/app/features/block_and_report/view/screens/blocks_screen.dart';
import 'package:graduation_project_therapist_dashboard/app/features/bottom_navigation_bar/bottom_navigation_widget/bottom_navigation_widget.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/view/screens/chat_init_page.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/view/screens/chat_page.dart';
import 'package:graduation_project_therapist_dashboard/app/features/doctor_employment_requests/view/screens/doctor_employment_requests_page.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/veiw/screens/get_all_therapists_page.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/veiw/screens/get_my_therapists_page.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_patients/veiw/screens/get_patients_page.dart';
import 'package:graduation_project_therapist_dashboard/app/features/medical_description.dart/view/screens/medical_description_details.dart';
import 'package:graduation_project_therapist_dashboard/app/features/medical_description.dart/view/screens/create_medical_description_page.dart';
import 'package:graduation_project_therapist_dashboard/app/features/medical_description.dart/view/screens/medical_descriptions_list_page.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/screens/change_password_page.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/screens/profile/edite_profile/edite_profile_page.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/screens/profile/help_center/help_center_screen.dart';
import 'package:graduation_project_therapist_dashboard/app/features/registration_data_complete/view/screens/complete_data_certifications.dart';
import 'package:graduation_project_therapist_dashboard/app/features/registration_data_complete/view/screens/registeration_data_complete_page.dart';
import 'package:graduation_project_therapist_dashboard/app/features/registration_data_complete/view/screens/set_location_on_map.dart';
import 'package:graduation_project_therapist_dashboard/app/features/user_profile/view/screens/user_profile.dart';
import 'package:graduation_project_therapist_dashboard/app/features/video_call/view/screens/call.dart';
import 'package:graduation_project_therapist_dashboard/app/features/video_call/view/screens/video_call_init_page.dart';
import 'package:graduation_project_therapist_dashboard/app/features/wallet/view/screens/wallet_page.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

// Define route names
const String welcomeScreen = '/welcomeScreen';
const String bottomNavigationBar = '/bottomNavigationBar';
const String specializationInfoStep = '/specializationInfoStep';
const String passwordStepPage = '/passwordStepPage';
const String oTPCodeStep = '/oTPCodeStep';
const String editProfile = '/editProfile';
const String changePasswordPage = '/changePasswordPage';
const String helpCenter = '/helpCenter';
const String initialRoute = '/';
const String completeDataPage = '/CompleteDataPage';
const String completeCertificationsPage = '/CompleteCertificationsPage';
const String selectLocationMapPage = '/SelectLocationMapPage';
const String selectImageRegisterStep = '/SelectImageRegisterStep';
const String userProfilePage = '/UserProfilePage';
const String chatPage = '/ChatPage';
const String forgetPasswordOTP = '/ForgetPasswordOTP';
const String forgetPasswordResetPassword = '/ForgetPasswordResetPassword';
const String forgetPasswordEmail = '/ForgetPasswordEmail';
const String getAllTherapistPage = '/GetAllTherapistPage';
const String getMyTherapistPage = '/GetMyTherapistPage';
const String walletPage = '/WalletPage';
const String doctorEmploymentRequestsPage = '/DoctorEmploymentRequestsPage';
const String designHider = '/designHider';
const String videoCallPage = '/VideoCallPage';
const String medicalDescriptionPage = '/medicalDescriptionPage';
const String getPatientsPage = '/GetPatientsPage';
const String medicalDescriptionsList = '/MedicalDescriptionsList';
const String medicalDescriptionDetails = '/MedicalDescriptionDetails';
const String chatInitPage = '/ChatInitPage';
const String videoCallInitPage = '/VideoCallInitPage';
const String blockedPatients = '/blockedPatients';

// Define the route map
final Map<String, WidgetBuilder> routes = {
  initialRoute: (context) => const InitializerWidget(),
  welcomeScreen: (context) => WelcomeScreen(),
  bottomNavigationBar: (context) => const BottomNavigationWidget(),
  editProfile: (context) => const EditProfile(),
  changePasswordPage: (context) => const ChangePasswordPage(),
  helpCenter: (context) => const HelpCenterScreen(),
  passwordStepPage: (context) => const PasswordStepPage(),
  oTPCodeStep: (context) => const OTPCodeStep(),
  completeDataPage: (context) => const CompleteDataPage(),
  completeCertificationsPage: (context) => const CompleteCertificationsPage(),
  selectLocationMapPage: (context) => const SelectLocationMapPage(),
  selectImageRegisterStep: (context) => const SelectImageAndDateRegisterStep(),
  userProfilePage: (context) => const UserProfilePage(),
  chatPage: (context) => const ChatPage(),
  forgetPasswordOTP: (context) => const ForgetPasswordOTP(),
  forgetPasswordResetPassword: (context) => const ForgetPasswordResetPassword(),
  forgetPasswordEmail: (context) => const ForgetPasswordEmail(),
  getAllTherapistPage: (context) => const GetAllTherapistPage(),
  getMyTherapistPage: (context) => const GetMyTherapistPage(),
  walletPage: (context) => const WalletPage(),
  doctorEmploymentRequestsPage: (context) =>
      const DoctorEmploymentRequestsPage(),
  videoCallPage: (context) => VideoCallPage(),
  medicalDescriptionPage: (context) => const MedicalDescriptionPage(),
  getPatientsPage: (context) => const GetPatientsPage(),
  medicalDescriptionsList: (context) => const MedicalDescriptionsList(),
  medicalDescriptionDetails: (context) => const MedicalDescriptionDetails(),
  chatInitPage: (context) => const ChatInitPage(),
  videoCallInitPage: (context) => const VideoCallInitPage(),
  blockedPatients: (context) => const BlockedPatientsScreen(),
};
