import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_patients/cubit/get_patients_state.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_patients/data_source/models/get_patients_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_patients/reposetory/get_patients_repo.dart';

class GetPatientsCubit extends Cubit<GetPatientsState> {
  final GetPatientsRepositoryImp getPatientsRepositoryImp;

  GetPatientsCubit({required this.getPatientsRepositoryImp})
      : super(GetPatientsInitial());
  Timer? _debounce;
  int? therapistId;
  List<GetPatientsModel>? getPatientsModels;
  List<GetPatientsModel> searchedPatientsModels = [];

  List<GetPatientsModel> getMyTherapistModels = [];
  List<GetPatientsModel> searchedMyTherapistModels = [];

  void getPatients({bool fromRefreshIndicator = false}) async {
    if (getPatientsModels == null || fromRefreshIndicator) {
      emit(PatientsLoadingState());
      final getData = await getPatientsRepositoryImp.getPatients();
      getData.fold((error) {
        emit(PatientsErrorState(errorMessage: error));
      }, (data) {
        getPatientsModels = data;
        emit(PatientsLoadedState(getPatientsModel: data));
      });
    } else {
      emit(PatientsLoadedState(getPatientsModel: getPatientsModels!));
    }
  }

  void searchOnPatients(String searchWord) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      searchWord = searchWord.toLowerCase();
      searchedPatientsModels.clear();

      for (var i in getPatientsModels ?? []) {
        if (i.name.toLowerCase().contains(searchWord)) {
          searchedPatientsModels.add(i);
        }
      }
      emit(SearchOnPatientsState(
          searchedPatientsModels: searchedPatientsModels,
          dateTime: DateTime.now()));
    });
  }
}
