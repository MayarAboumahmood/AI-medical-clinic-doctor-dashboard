import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'registration_data_complete_state.dart';

class RegistrationDataCompleteCubit extends Cubit<RegistrationDataCompleteState> {
  RegistrationDataCompleteCubit() : super(RegistrationDataCompleteInitial());
}
