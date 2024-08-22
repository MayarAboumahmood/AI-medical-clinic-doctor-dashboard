import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation_project_therapist_dashboard/app/features/home_page/data_source/models/user_profile_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/home_page/data_source/models/user_status_enum.dart';
import 'package:graduation_project_therapist_dashboard/app/features/home_page/repository/home_page_repository_imp.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:meta/meta.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageRepositoryImp homePageRepositoryImp;
  HomePageBloc({required this.homePageRepositoryImp})
      : super(HomePageInitial()) {
    on<HomePageEvent>((event, emit) {
      if (state is HomePageInitial) {}
    });
    on<GetUserInfoEvent>((event, emit) async {
      if (!isGuest) {
        if (event.shouldLoadTheUserInfo) {
          await getUserData(emit);
        } else if (sharedPreferences!.getString('user_profile') == null) {
          await getUserData(emit);
        } else {
          final String? userProfileString =
              sharedPreferences?.getString('user_profile');
          if (userProfileString != null && userProfileString.isNotEmpty) {
            final Map<String, dynamic> userProfileMap =
                jsonDecode(userProfileString);
            userData = UserProfileModel.fromMap(userProfileMap);
          }
        }
      }
    });
    on<GetUserStatusEvent>((event, emit) async {
      if (!isGuest) {
        if (sharedPreferences!.getString('user_status') !=
            UserStatusEnum.verified.name) {
          final getUserStatus = await homePageRepositoryImp.getUserStatusData();
          getUserStatus.fold((onError) {
            emit(FetchDataFauilerState(errorMessage: onError));
          }, (data) {
            userStatus = data;
            sharedPreferences!.setString(
              'user_status',
              userStatusToString(data),
            );
            emit(GetUserStatesuccessfulyState());
          });
        } else {
          userStatus = UserStatusEnum.verified;
        }
      }
    });
    on<LoadHomePageDataEvent>((event, emit) {
      // TODO: implement sending request to get the home page data.
    });
  }

  Future<void> getUserData(Emitter<HomePageState> emit) async {
    final getUserData = await homePageRepositoryImp.getUserProfileData();

    getUserData.fold((onError) {
      emit(FetchDataFauilerState(errorMessage: onError));
    }, (data) {
      userData = data;
      Map<String, dynamic> jsonUserInfo = data.toJson();
      sharedPreferences!.setString('user_profile', jsonEncode(jsonUserInfo));
    });
  }
}
