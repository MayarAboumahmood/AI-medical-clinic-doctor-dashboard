import 'dart:io';

class EditProfileModel {
  final String dateOfBirth;
  final String fullName;
  final String? imageName;
  final String gender;
  final File? profilePic;
  final String state;
  final String phoneNumber;
  final String longitude;
  final String latitude;
  final String studyInfo;
  final String specInfo;

  const EditProfileModel({
    required this.dateOfBirth,
    required this.imageName,
    required this.gender,
    required this.profilePic,
    required this.state,
    required this.fullName,
    required this.phoneNumber,
    required this.longitude,
    required this.latitude,
    required this.studyInfo,
    required this.specInfo,
  });
  //need to recheck after ahmed edit it with the right form of data.
  factory EditProfileModel.fromMap(Map<String, dynamic> json) {
    return EditProfileModel(
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      profilePic: File(json['photo']),
      state: json['state'] ?? '',
      phoneNumber: json['phone'] ?? '',
      fullName: json['fullName'],
      studyInfo: json['studyInfo'],
      specInfo: json['specInfo'],
      imageName: null,
    );
  }
}
