import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/data_source/models/get_therapists_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/my_therapist/cubit/get_my_therapist_state.dart';
import 'package:graduation_project_therapist_dashboard/app/features/my_therapist/reposetory/get_my_therapist_repo.dart';

class GetMyTherapistCubit extends Cubit<GetMyTherapistState> {
  final GetMyTherapistRepositoryImp getMyTherapistRepositoryImp;
  GetMyTherapistCubit({required this.getMyTherapistRepositoryImp})
      : super(GetMyTherapistInitial());
  Timer? _debounce;

  List<GetTherapistModel> getTherapistModels = [];
  List<GetTherapistModel> searchedTherapistModels = [];

  void getMyTherapist() async {
    emit(MyTherapistLoadingState());
    final getData = await getMyTherapistRepositoryImp.getMyTherapist();
    getData.fold((error) {
      emit(MyTherapistErrorState(errorMessage: error));
    }, (data) {
      getTherapistModels = data;
      emit(MyTherapistLoadedState(getTherapistModels: getTherapistModels));
    });
  }

  void removeTherapist(int therapistId) async {
    emit(RemoveTherapistLoadingState());
    final getData =
        await getMyTherapistRepositoryImp.removeTherapist(therapistId);
    getData.fold((error) {
      emit(MyTherapistErrorState(errorMessage: error));
    }, (data) {
      emit(TherapistRemovedSuccessfullyState());
    });
  }

  void searchOnAllTherapist(String searchWord) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      searchWord = searchWord.toLowerCase();
      searchedTherapistModels.clear();

      for (var i in getTherapistModels) {
        if (i.specialistProfile.fullName.toLowerCase().contains(searchWord)) {
          searchedTherapistModels.add(i);
        }
      }
      emit(SearchOnMyTherapistState(
          searchedTherapistModels: searchedTherapistModels,
          dateTime: DateTime.now()));
    });
  }
}
