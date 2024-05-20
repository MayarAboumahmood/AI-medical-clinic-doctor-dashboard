// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Activate`
  String get Activate {
    return Intl.message(
      'Activate',
      name: 'Activate',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'Add Custom Photo' key

  // skipped getter for the 'Book With Ease' key

  // skipped getter for the 'By joining, I agree to Tables\' Terms of Use & Data Privacy Center ' key

  /// `Camera`
  String get Camera {
    return Intl.message(
      'Camera',
      name: 'Camera',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'Choose Source' key

  // skipped getter for the 'Continue as guest' key

  /// `Continue`
  String get Continue {
    return Intl.message(
      'Continue',
      name: 'Continue',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'Continue with Facebook' key

  // skipped getter for the 'Discover a variety of great dining and entertainment options at your fingertips.' key

  // skipped getter for the 'Email Adress' key

  // skipped getter for the 'Enable Fingerprint' key

  // skipped getter for the 'If you enable touch ID, you don’t need to enter password when you login' key

  // skipped getter for the 'Enter Password' key

  // skipped getter for the 'Enter a strong password for your account' key

  // skipped getter for the 'Please enter where do you live' key

  // skipped getter for the 'Enter your location' key

  // skipped getter for the 'Explore Great Options' key

  // skipped getter for the 'First Name' key

  /// `Gallery`
  String get Gallery {
    return Intl.message(
      'Gallery',
      name: 'Gallery',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'Hello Word' key

  /// `Join`
  String get Join {
    return Intl.message(
      'Join',
      name: 'Join',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'Last Name' key

  // skipped getter for the 'Link with Facebook' key

  // skipped getter for the '+963  Mobile Phone' key

  // skipped getter for the 'Profile Picture' key

  // skipped getter for the 'Ready To Reserve?' key

  // skipped getter for the 'Reserve your table or spot with ease, all at the touch of a button.' key

  // skipped getter for the 'Send me a new code' key

  // skipped getter for the 'Set your password' key

  // skipped getter for the 'Sign in' key

  /// `STEP`
  String get STEP {
    return Intl.message(
      'STEP',
      name: 'STEP',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'To give you a customize experience we need to know your gender' key

  // skipped getter for the 'Type a strong password' key

  // skipped getter for the 'The input is not email' key

  // skipped getter for the 'The input should be at least 3 digit' key

  // skipped getter for the 'The input should be at 10 digit' key

  // skipped getter for the 'Which one are you?' key

  // skipped getter for the 'For you' key

  // skipped getter for the 'You\'re all set to reserve and enjoy your next outing. Let\'s get started' key

  // skipped getter for the 'You can select photo from one of this emoji or add your own photo as profile picture' key
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
