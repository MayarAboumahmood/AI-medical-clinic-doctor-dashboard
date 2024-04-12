import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/injection/app_injection.dart';
import 'package:graduation_project_therapist_dashboard/app/core/service/shared_preferences.dart';
import 'package:graduation_project_therapist_dashboard/app/core/theme/app_theme.dart';

abstract class ThemeEvent {}

class ThemeChanged extends ThemeEvent {
  final ThemeMode themeMode;

  ThemeChanged({required this.themeMode});
}

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  ThemeBloc() : super(AppTheme.light) {
    _loadThemeFromPreferences();
    on<ThemeChanged>((event, emit) {
      final ThemeData themeData =
          (event.themeMode == ThemeMode.light) ? AppTheme.light : AppTheme.dark;
      emit(themeData);

      sl<PrefService>()
          .createString('isDarkMode', "${event.themeMode == ThemeMode.dark}");
    });
  } // initial theme

  Future<void> _loadThemeFromPreferences() async {
    final bool isDarkMode =
        await sl<PrefService>().readString("isDarkMode") == "true";
    add(ThemeChanged(themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light));
  }
}
