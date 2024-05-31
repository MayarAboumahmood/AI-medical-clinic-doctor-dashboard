import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
        // if (sharedPreferences!.getString('user_profile') == null) {
        final getUserData = await homePageRepositoryImp.getUserProfileData();

        getUserData.fold((onError) {
          emit(FetchDataFauilerState(errorMessage: onError));
        }, (data) {
          Map<String, dynamic> jsonUserInfo = data.toJson();
          sharedPreferences!
              .setString('user_profile', jsonEncode(jsonUserInfo));

          String userProfileJson =
              sharedPreferences!.getString('user_profile') ?? "";
          print(
              'the user profile when I get it: ${jsonDecode(userProfileJson)}');
        });
      }
      // }
    });
    on<GetUserStatusEvent>((event, emit) async {
      if (!isGuest) {
        if (sharedPreferences!.getString('user_status') == null) {
          final getUserStatus = await homePageRepositoryImp.getUserStatusData();
          getUserStatus.fold((onError) {
            emit(FetchDataFauilerState(errorMessage: onError));
          }, (data) {
            sharedPreferences!.setString(
              'user_status',
              userStatusToString(data),
            );
          });
        }
      }
    });
    on<LoadHomePageDataEvent>((event, emit) {
      // TODO: implement sending request to get the home page data.
    });
  }
}
