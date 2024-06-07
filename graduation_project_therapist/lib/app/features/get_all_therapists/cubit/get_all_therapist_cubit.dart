import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_all_therapist_state.dart';

class GetAllTherapistCubit extends Cubit<GetAllTherapistState> {
  GetAllTherapistCubit() : super(GetAllTherapistInitial());
}
