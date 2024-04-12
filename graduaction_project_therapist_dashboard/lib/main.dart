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
import 'package:graduation_project_therapist_dashboard/app/features/bottom_navigation_bar/bottom_navigation_widget/bloc/bottom_navigation_widget_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/notification/presentaion/bloc/notification_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/data/model/profile_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_blocs/connectivity_bloc/connectivity_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_blocs/language_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/bottom_navigation_bar/bottom_navigation_widget/bottom_navigation_widget.dart';
import 'package:graduation_project_therapist_dashboard/generated/l10n.dart';
import 'package:location/location.dart';
import 'package:pushy_flutter/pushy_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/core/injection/app_injection.dart' as di;

import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/core/injection/app_injection.dart';
import 'package:graduation_project_therapist_dashboard/app/core/service/navigation_service.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_blocs/theme_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/notification_service.dart';

late ResponsiveUtil responsiveUtil;
late AppColorsExtension customColors;

late NavigationService navigationService;
late AppTextStylesExtension customTextStyle;

SharedPreferences? sharedPreferences;
UserData? userData;
late Timer timer;
bool isGuest = false;
LocationData? globalUserLocation;

void startTimerToRemoveSplashScreen() {
  timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
    if (t.tick == 2) {
      // Timer reached 3 seconds
      t.cancel(); // Stop the timer
      FlutterNativeSplash.remove(); // Remove splash screen
    }
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  startTimerToRemoveSplashScreen();
  await di.init();
  // Start the Pushy service
  Pushy.listen();

  // Enable in-app notification banners (iOS 10+)
  Pushy.toggleInAppBanner(true);

  // Set custom notification icon (Android)
  Pushy.setNotificationIcon('@mipmap/launcher_icon');

// Listen for push notifications received
  Pushy.setNotificationListener(backgroundNotificationListener);
  Pushy.setNotificationClickListener((data) {});
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await EasyLocalization.ensureInitialized();

  navigationService = sl.get<NavigationService>();
  sharedPreferences = await SharedPreferences.getInstance();

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
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    responsiveUtil = ResponsiveUtil(context);
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => di.sl<ThemeBloc>()),
          BlocProvider(create: (_) => di.sl<LanguageBloc>()),
          BlocProvider(create: (_) => di.sl<NotificationBloc>()),
          BlocProvider(create: (_) => di.sl<ProfileBloc>()),
          BlocProvider(create: (_) => di.sl<SignInCubit>()),
          BlocProvider(create: (_) => di.sl<RegisterCubit>()),
          BlocProvider(create: (_) => di.sl<BottomNavigationWidgetBloc>()),
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
                    selectionHandleColor: Color(0xff19db8a))),
            darkTheme: AppTheme.dark,
            routes: routes,
            initialRoute: '/',
          );
        }));
  }
}

class InitializerWidget extends StatelessWidget {
  const InitializerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure these lines are under MaterialApp in the widget tree
    customTextStyle = Theme.of(context).extension<AppTextStylesExtension>()!;
    customColors = Theme.of(context).extension<AppColorsExtension>()!;

    // After initializing, return the next screen in the flow
    return BlocBuilder<LanguageBloc, LanguageState>(builder: (context, state) {
      if (state is LanguageLoadSuccess) {
        context.setLocale(state.locale); // <-- Change the locale
      }
      if (sharedPreferences!.getString('token') != null) {
        if (sharedPreferences!.getString('isRegisterCompleted') == 'true') {
          return const BottomNavigationWidget();
        }
      }

      return WelcomeScreen();
    });
  }
}
