import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:graduation_project_therapist_dashboard/app/features/registration_data_complete/data_sorce/models/complete_register_model.dart';
import 'package:graduation_project_therapist_dashboard/app/features/registration_data_complete/repo/registration_data_complete_repo.dart';
import 'package:latlong2/latlong.dart';

part 'registration_data_complete_state.dart';

class RegistrationDataCompleteCubit
    extends Cubit<RegistrationDataCompleteState> {
  RegistrationDataCompleteRepoIpm registrationDataCompleteRepoIpm;
  RegistrationDataCompleteCubit({required this.registrationDataCompleteRepoIpm})
      : super(RegistrationDataCompleteInitial());
  String? selectedCity;
  List<String> selectedMedicalSpecialty = [];
  String? locationInfo = '';
  String? clinicName = '';
  List<Uint8List> certificationImages = []; // List to store image paths
  LatLng? userLatLng;

  void emitInitState() {
    emit(RegistrationDataCompleteInitial());
  }

  void setUserLating(LatLng newLating) {
    userLatLng = newLating;
  }

  void updateClinicName(String? newClinicName) {
    clinicName = newClinicName;
  }

  void addCertificationImage(Uint8List imagePath) {
    certificationImages.add(imagePath);

    emit(RegistrationDataCompleteImagesUpdated(
        certificationImages: certificationImages, dateTime: DateTime.now()));
  }

  void updateSelectedMedicalSpecialty(List<String> values) {
    selectedMedicalSpecialty.clear();
    selectedMedicalSpecialty.addAll(values);
  }

  void updateLocationInfo(updatedInfo) {
    locationInfo = updatedInfo;
  }

  void submitteUserData() async {
    emit(RegistrationDataCompleteLoadingState());
    CompleteRegisterModel completeRegisterModel = CompleteRegisterModel(
        selectedMedicalSpecialty: selectedMedicalSpecialty,
        locationInfo: locationInfo,
        clinicName: clinicName,
        selectedCity: selectedCity,
        userLatLng: userLatLng,
        certificationImages: certificationImages);

    final response = await registrationDataCompleteRepoIpm
        .completeRegister(completeRegisterModel);

    response.fold(
        (error) =>
            emit(RegistrationDataCompleteFailureState(errorMessage: error)),
        (data) => emit(RegistrationDataCompleteDoneSuccseflyState()));
  }

  void gettingUserLocation() {
    emit(GettingUserLocationState());
  }
}
