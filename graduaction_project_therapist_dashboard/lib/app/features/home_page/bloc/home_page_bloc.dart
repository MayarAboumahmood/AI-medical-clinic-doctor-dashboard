import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    on<HomePageEvent>((event, emit) {
      if (state is HomePageInitial) {
        
      }
    });
    on<LoadHomePageDataEvent>((event, emit) {
      // TODO: implement sending request to get the home page data.
    });
  }
}
