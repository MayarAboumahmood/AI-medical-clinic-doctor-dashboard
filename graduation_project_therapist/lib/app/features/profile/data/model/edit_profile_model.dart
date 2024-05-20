import 'dart:io';

class EditProfileModel {
  final String dateOfBirth;
  final String firstName;
  final String lastName;
  final String gender;
  final File? profilePic;
  final String state;

  const EditProfileModel({
    required this.dateOfBirth,
    required this.gender,
    required this.profilePic,
    required this.state,
    required this.firstName,
    required this.lastName,
  });
  //need to recheck after ahmed edit it with the right form of data.
  factory EditProfileModel.fromJson(Map<String, dynamic> json) {
    return EditProfileModel(
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      profilePic: File(json['profilePic']),
      state: json['state'],
      firstName: json['fistName'],
      lastName: json['lastName'],
    );
  }
}
