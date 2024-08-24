import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/core/extension/app_color_extension.dart';
import 'package:graduation_project_therapist_dashboard/app/core/extension/app_text_field_extension.dart';
import 'package:graduation_project_therapist_dashboard/app/core/theme/app_theme.dart';
import 'package:graduation_project_therapist_dashboard/app/core/utils/responsive_util.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/bloc/register_cubit/register_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/bloc/sign_in_cubit/sign_in_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/view/screens/welcome_screen/wlcome_screen.dart';
import 'package:graduation_project_therapist_dashboard/app/features/block_and_report/bloc/block_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/bottom_navigation_bar/bloc/bottom_navigation_widget_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/bottom_navigation_bar/bottom_navigation_widget/bottom_navigation_widget.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/bloc/chat_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/doctor_employment_requests/cubit/doctor_employment_requests_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/cubit/get_all_therapist_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_patients/cubit/get_patients_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/home_page/bloc/home_page_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/home_page/data_source/models/user_profile_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/home_page/data_source/models/user_status_enum.dart';
import 'package:graduation_project_therapist_dashboard/app/features/medical_description.dart/cubit/medical_description_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/notification/presentaion/bloc/notification_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/cubit/patient_requests_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_reservations/cubit/patient_reservations_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/registration_data_complete/cubit/registration_data_complete_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/user_profile/cubit/user_profile_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/video_call/bloc/video_call_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/wallet/cubit/wallet_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_blocs/connectivity_bloc/connectivity_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_blocs/language_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_blocs/user_data_block/user_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/notification_service.dart';
import 'package:graduation_project_therapist_dashboard/generated/l10n.dart';
import 'package:location/location.dart';
import 'package:pushy_flutter/pushy_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/core/injection/app_injection.dart' as di;

import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/core/injection/app_injection.dart';
import 'package:graduation_project_therapist_dashboard/app/core/service/navigation_service.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_blocs/theme_bloc.dart';

late ResponsiveUtil responsiveUtil;
late AppColorsExtension customColors;

late NavigationService navigationService;
late AppTextStylesExtension customTextStyle;

SharedPreferences? sharedPreferences;
UserProfileModel? userData;
bool isGuest = false;
late bool isDoctor;
UserStatusEnum userStatus = UserStatusEnum.loading;
LocationData? globalUserLocation;
bool comingFromRegisterOrLogin = false;

late Timer timer;
void startTimerToRemoveSplashScreen() {
  timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
    if (t.tick == 2) {
      // Timer reached 2 seconds
      t.cancel(); // Stop the timer
      FlutterNativeSplash.remove(); // Remove splash screen
    }
  });
}

void main() async {
  // debugRepaintRainbowEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  startTimerToRemoveSplashScreen();

  await EasyLocalization.ensureInitialized();

  await di.init();
  // Start the Pushy service
  Pushy.listen();

  // Enable in-app notification banners (iOS 10+)
  Pushy.toggleInAppBanner(true);

  // Set custom notification icon (Android)
  Pushy.setNotificationIcon('@mipmap/launcher_icon');

// Listen for push notifications received
  Pushy.setNotificationListener(backgroundNotificationListener);

  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  navigationService = sl.get<NavigationService>();
  sharedPreferences = await SharedPreferences.getInstance();

  userStatus = userStatusFromString(
      sharedPreferences!.getString('user_status') ?? 'unverified');
  if (sharedPreferences?.getString('isDarkMode') == null) {
    sharedPreferences?.setString('isDarkMode', 'true');
  }
  final ThemeMode isDarkMode =
      sharedPreferences?.getString('isDarkMode') == "false"
          ? ThemeMode.light
          : ThemeMode.dark;

  final themeBloc = di.sl<ThemeBloc>(); // Use GetIt to get the instance
  themeBloc.add(ThemeChanged(themeMode: isDarkMode));
  runApp(BlocProvider(
    create: (context) => ConnectivityBloc(),
    child: EasyLocalization(
      startLocale:
          Locale(sharedPreferences?.getString('language_code') ?? 'en'),
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translation',
      fallbackLocale: const Locale('en'),
      child: BlocProvider.value(
        value: ThemeBloc(), // Providing the ThemeBloc
        child: const MyApp(),
      ),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState;
    Pushy.setNotificationClickListener((data) {
      final BuildContext context =
          navigationService.navigatorKey.currentContext!;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notificationClickListener(context, data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    responsiveUtil = ResponsiveUtil(context);
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => di.sl<ThemeBloc>()),
          BlocProvider(create: (_) => di.sl<GetAllTherapistCubit>()),
          BlocProvider(create: (_) => di.sl<LanguageBloc>()),
          BlocProvider(create: (_) => di.sl<RegistrationDataCompleteCubit>()),
          BlocProvider(create: (_) => di.sl<UserProfileCubit>()),
          BlocProvider(create: (_) => di.sl<GetUserDataBloc>()),
          BlocProvider(create: (_) => di.sl<NotificationBloc>()),
          BlocProvider(create: (_) => di.sl<ProfileBloc>()),
          BlocProvider(create: (_) => di.sl<SignInCubit>()),
          BlocProvider(create: (_) => di.sl<RegisterCubit>()),
          BlocProvider(create: (_) => di.sl<PatientRequestsCubit>()),
          BlocProvider(create: (_) => di.sl<PatientReservationsCubit>()),
          BlocProvider(create: (_) => di.sl<BottomNavigationWidgetBloc>()),
          BlocProvider(create: (_) => di.sl<HomePageBloc>()),
          BlocProvider(create: (_) => di.sl<VideoCallBloc>()),
          BlocProvider(
            create: (_) => di.sl<ChatBloc>(),
          ),
          BlocProvider(
            create: (_) => di.sl<WalletCubit>(),
          ),
          BlocProvider(
            create: (_) => di.sl<DoctorEmploymentRequestsCubit>(),
          ),
          BlocProvider(
            create: (_) => di.sl<MedicalDescriptionCubit>(),
          ),
          BlocProvider(
            create: (_) => di.sl<GetPatientsCubit>(),
          ),
          BlocProvider(
            create: (_) => di.sl<BlockBloc>(),
          ),
        ],
        child: BlocBuilder<ThemeBloc, ThemeData>(builder: (context, theme) {
          return MaterialApp(
            themeMode: ThemeMode.light,
            navigatorKey: sl.get<NavigationService>().navigatorKey,
            debugShowCheckedModeBanner: false,
            supportedLocales: S.delegate.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            locale: context.locale,
            theme: theme.copyWith(
                textSelectionTheme: const TextSelectionThemeData(
                    cursorColor: Color.fromARGB(255, 25, 93, 219),
                    selectionColor: Color.fromARGB(255, 25, 93, 219),
                    selectionHandleColor: Color.fromARGB(255, 25, 93, 219))),
            darkTheme: AppTheme.dark,
            routes: routes,
            initialRoute: initialRoute,
          );
        }));
  }
}

class InitializerWidget extends StatelessWidget {
  const InitializerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    customTextStyle = Theme.of(context).extension<AppTextStylesExtension>()!;
    customColors = Theme.of(context).extension<AppColorsExtension>()!;

    return BlocBuilder<LanguageBloc, LanguageState>(builder: (context, state) {
      if (state is LanguageLoadSuccess) {
        context.setLocale(state.locale); // <-- Change the locale
      }
      if (sharedPreferences!.getString('token') != null) {
        if (sharedPreferences!.getBool('isRegisterCompleted') == true) {
          return const BottomNavigationWidget();
        }
      }
      return WelcomeScreen();
    });
  }
}
