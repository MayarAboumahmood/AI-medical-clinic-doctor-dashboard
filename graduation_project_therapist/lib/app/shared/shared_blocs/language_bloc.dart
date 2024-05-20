// LanguageEvent.dart
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class LanguageEvent {}

class LanguageSelected extends LanguageEvent {
  final Locale locale;

  LanguageSelected(this.locale);
}

// LanguageState.dart
sealed class LanguageState extends Equatable{
   @override
  List<Object> get props => [];
}

class LanguageInitial extends LanguageState {
  @override
  List<Object> get props => [];
}

class LanguageLoadInProgress extends LanguageState {
  @override
  List<Object> get props => [];
}

class LanguageLoadSuccess extends LanguageState {
  final Locale locale;

  LanguageLoadSuccess(this.locale);
   @override
  List<Object> get props => [locale];
}

// LanguageBloc.dart
class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial()){
on<LanguageSelected>((event, emit) async {
      emit(LanguageLoadInProgress());
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate some delay
      emit(LanguageLoadSuccess(event.locale));
    });
  }

 
}
