import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'registration_data_complete_state.dart';

class RegistrationDataCompleteCubit
    extends Cubit<RegistrationDataCompleteState> {
  RegistrationDataCompleteCubit() : super(RegistrationDataCompleteInitial());

  List<String> selectedMedicalSpecialty = [];
  String studiesInfo = '';
  String locationInfo = '';
  String specialtyInfo = '';
  final List<String> certificationImages = []; // List to store image paths

  void addCertificationImage(String imagePath) {
    certificationImages.add(imagePath);

    emit(RegistrationDataCompleteImagesUpdated(
        certificationImages: certificationImages));
  }

  void updateSelectedMedicalSpecialty(List<String> values) {
    selectedMedicalSpecialty.clear();
    selectedMedicalSpecialty.addAll(values);
    print('ssssssssssssssssssssssss $selectedMedicalSpecialty');
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
}
