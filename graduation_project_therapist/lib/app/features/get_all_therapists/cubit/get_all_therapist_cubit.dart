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

  List<GetTherapistModel> getTherapistModels = [];
  List<GetTherapistModel> searchedTherapistModels = [];

  void getAllTherapist() async {
    emit(AllTherapistLoadingState());
    final getData = await getAllTherapistRepositoryImp.getAllTherapist();
    getData.fold((error) {
      emit(AllTherapistErrorState(errorMessage: error));
    }, (data) {
      getTherapistModels = data;
      emit(AllTherapistLoadedState(getTherapistModels: getTherapistModels));
    });
  }

  void assignTherapist(int therapistId) async {
    emit(AssignTherapistLoadingState());
    final getData =
        await getAllTherapistRepositoryImp.assignTherapist(therapistId);
    getData.fold((error) {
      emit(AllTherapistErrorState(errorMessage: error));
    }, (data) {
      emit(AssignTherapistSuccessfullyState());
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
      emit(SearchOnAllTherapistState(
          searchedTherapistModels: searchedTherapistModels,
          dateTime: DateTime.now()));
    });
  }
}
