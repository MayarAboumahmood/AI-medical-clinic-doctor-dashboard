import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/cubit/get_all_therapist_state.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/data_source/models/get_therapists_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/reposetory/get_all_therapist_repo.dart';

class GetAllTherapistCubit extends Cubit<GetAllTherapistState> {
  final GetAllTherapistRepositoryImp getAllTherapistRepositoryImp;

  GetAllTherapistCubit({required this.getAllTherapistRepositoryImp})
      : super(GetAllTherapistInitial());
  Timer? _debounce;
  int? therapistId;
  List<GetTherapistModel>? getAllTherapistModels;
  List<GetTherapistModel> searchedAllTherapistModels = [];

  List<GetTherapistModel>? getMyTherapistModels;
  List<GetTherapistModel> searchedMyTherapistModels = [];

  void getAllTherapist({bool fromRefreshIndicator = false}) async {
    if (getAllTherapistModels == null || fromRefreshIndicator) {
      emit(AllTherapistLoadingState());
      final getData = await getAllTherapistRepositoryImp.getAllTherapist();
      getData.fold((error) {
        emit(AllTherapistErrorState(errorMessage: error));
      }, (data) {
        getAllTherapistModels = data;
        emit(AllTherapistLoadedState(getTherapistModels: data));
      });
    } else {
      emit(AllTherapistLoadedState(getTherapistModels: getAllTherapistModels!));
    }
  }

  void assignTherapist(int therapistId) async {
    this.therapistId = therapistId;
    emit(AssignTherapistLoadingState());
    final getData =
        await getAllTherapistRepositoryImp.assignTherapist(therapistId);
    getData.fold((error) {
      emit(AllTherapistErrorState(errorMessage: error));
    }, (data) {
      if (getAllTherapistModels != null) {
        for (var therapist in getAllTherapistModels!) {
          if (therapist.specialistProfile.id == therapistId) {
            print(
                'therapist.specialistProfile.id: ${therapist.specialistProfile.id}');
            therapist.employmentRequests = true;
            break;
          }
        }
      }
      emit(AssignTherapistSuccessfullyState());
    });
  }

  void searchOnAllTherapist(String searchWord) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      searchWord = searchWord.toLowerCase();
      searchedAllTherapistModels.clear();

      for (var i in getAllTherapistModels ?? []) {
        if (i.specialistProfile.fullName.toLowerCase().contains(searchWord)) {
          searchedAllTherapistModels.add(i);
        }
      }
      emit(SearchOnAllTherapistState(
          searchedTherapistModels: searchedAllTherapistModels,
          dateTime: DateTime.now()));
    });
  }

  void getMyTherapist(int patientID,
      {bool fromRefreshIndicator = false}) async {
    if (getMyTherapistModels == null || fromRefreshIndicator) {
      emit(MyTherapistLoadingState());
      final getData =
          await getAllTherapistRepositoryImp.getMyTherapist(patientID);
      getData.fold((error) {
        emit(MyTherapistErrorState(errorMessage: error));
      }, (data) {
        getMyTherapistModels = data;
        emit(MyTherapistLoadedState(getTherapistModels: data));
      });
    } else {
      emit(MyTherapistLoadedState(getTherapistModels: getMyTherapistModels!));
    }
  }

  void removeTherapist(int therapistId) async {
    this.therapistId = therapistId;
    emit(RemoveTherapistLoadingState());
    final getData =
        await getAllTherapistRepositoryImp.removeTherapist(therapistId);
    getData.fold((error) {
      emit(MyTherapistErrorState(errorMessage: error));
    }, (data) {
      if (getMyTherapistModels != null) {
        getMyTherapistModels!
            .removeWhere((therapist) => therapist.id == therapistId);
      }
      emit(TherapistRemovedSuccessfullyState(dateTime: DateTime.now()));
    });
  }

  void searchOnMyTherapist(String searchWord) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      searchWord = searchWord.toLowerCase();
      searchedMyTherapistModels.clear();

      for (var i in getMyTherapistModels ?? []) {
        if (i.specialistProfile.fullName.toLowerCase().contains(searchWord)) {
          searchedMyTherapistModels.add(i);
        }
      }
      emit(SearchOnMyTherapistState(
          searchedTherapistModels: searchedMyTherapistModels,
          dateTime: DateTime.now()));
    });
  }
}
