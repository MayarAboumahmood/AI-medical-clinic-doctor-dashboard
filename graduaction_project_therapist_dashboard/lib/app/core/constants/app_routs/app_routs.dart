import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/view/screens/register_steps/otp_code1.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/view/screens/register_steps/password_step.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/view/screens/welcome_screen/wlcome_screen.dart';
import 'package:graduation_project_therapist_dashboard/app/features/bottom_navigation_bar/bottom_navigation_widget/bottom_navigation_widget.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/screens/change_password_page.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/screens/profile/edite_profile/edite_profile_page.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/screens/profile/help_center/help_center_screen.dart';
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
};
