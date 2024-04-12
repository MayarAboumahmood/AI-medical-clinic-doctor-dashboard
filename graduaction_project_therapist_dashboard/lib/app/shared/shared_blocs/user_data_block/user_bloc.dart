import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_blocs/user_data_block/user_data_event.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_blocs/user_data_block/user_data_state.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';

class GetUserDataBloc extends Bloc<GetUserDataAEvent, GetUserDataAState> {
  GetUserDataBloc() : super(UserDataInitial()) {
    on<GetUserDataEvent>((event, emit) async {
      if (sharedPreferences!.getString('user_profile') == null) {
        /*getUserData.fold(
            (onError) =>
                emit(FetchUserDataFauilerState(statusRequest: onError)),
            (data) {
          if (kDebugMode) {
            print(
                'the user data is here ${sharedPreferences!.getString('user_profile')}');
          }
        });
      } else {
        if (kDebugMode) {
          print('the user: ${sharedPreferences!.getString('user_profile')}');
        }*/
      }
    });
  }
}
