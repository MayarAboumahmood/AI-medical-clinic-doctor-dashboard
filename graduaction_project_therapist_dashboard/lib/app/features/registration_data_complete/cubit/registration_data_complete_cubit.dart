import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';

part 'registration_data_complete_state.dart';

class RegistrationDataCompleteCubit
    extends Cubit<RegistrationDataCompleteState> {
  RegistrationDataCompleteCubit() : super(RegistrationDataCompleteInitial());

  List<String> selectedMedicalSpecialty = [];
  String studiesInfo = '';
  String locationInfo = '';
  String specialtyInfo = '';
  List<String> certificationImages = []; // List to store image paths
  LatLng? userLatLng;
  void emitInitState() {
    emit(RegistrationDataCompleteInitial());
  }

  void setUserLating(LatLng newLating) {
    userLatLng = newLating;
  }

  void addCertificationImage(String imagePath) {
    certificationImages.add(imagePath);
    print('ssssssssssssssssssssss state $certificationImages');
    print('ssssssssssssssssssssss state2 ${certificationImages.length}');
    print('ssssssssssssssssssssss state3 $imagePath');

    emit(RegistrationDataCompleteImagesUpdated(
        certificationImages: certificationImages, dateTime: DateTime.now()));
  }

  void updateSelectedMedicalSpecialty(List<String> values) {
    selectedMedicalSpecialty.clear();
    selectedMedicalSpecialty.addAll(values);
  }

  void updateStudiesInfo(updatedInfo) {
    studiesInfo = updatedInfo;
  }

  void updateSpecialtyInfo(updatedInfo) {
    specialtyInfo = updatedInfo;
  }

  void updateLocationInfo(updatedInfo) {
    locationInfo = updatedInfo;
  }

  void submitteUserData() {
    //TODO: send the request.
    emit(RegistrationDataCompleteDoneSuccseflyState());
  }

  void gettingUserLocation() {
    emit(GettingUserLocationState());
  }
}
