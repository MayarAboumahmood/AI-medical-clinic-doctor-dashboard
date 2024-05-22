import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_navigation_widget_event.dart';
part 'bottom_navigation_widget_state.dart';

class BottomNavigationWidgetBloc
    extends Bloc<BottomNavigationWidgetEvent, BottomNavigationWidgetState> {
  BottomNavigationWidgetBloc() : super(BottomNavigationWidgetInitial()) {
    on<BottomNavigationWidgetEvent>((event, emit) {});

    on<ChangeCurrentPage>((event, emit) {
      emit(PageChangedIndex(currentPage: event.nextIndex));
    });
  }
}
