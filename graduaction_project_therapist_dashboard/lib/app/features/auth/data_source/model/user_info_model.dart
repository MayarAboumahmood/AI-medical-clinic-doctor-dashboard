// class UserInfo {
//   final String firstName;
//   final String lastName;
//   final String phoneNumber;
//   final String userEmail;
//   final String locationInfo;
//   final String studieInfo;
//   final String password;
//   final String? selectedSpecialization;
//   final String? selectedGender;
//   final String dateOfBirth;

//   UserInfo({
//     required this.firstName,
//     required this.lastName,
//     required this.dateOfBirth,
//     required this.phoneNumber,
//     required this.userEmail,
//     required this.password,
//     required this.locationInfo,
//     required this.studieInfo,
//     this.selectedSpecialization,
//     this.selectedGender,
//   });
//   UserInfo copyWith({
//     String? firstName,
//     String? lastName,
//     String? phoneNumber,
//     String? userEmail,
//     String? locationInfo,
//     String? studieInfo,
//     String? dateOfBirth,
//     String? password,
//     String? selectedSpecialization,
//     String? selectedGender,
//   }) {
//     return UserInfo(
//       firstName: firstName ?? this.firstName,
//       lastName: lastName ?? this.lastName,
//       phoneNumber: phoneNumber ?? this.phoneNumber,
//       dateOfBirth: dateOfBirth ?? this.dateOfBirth,
//       userEmail: userEmail ?? this.userEmail,
//       password: password ?? this.password,
//       locationInfo: locationInfo ?? this.locationInfo,
//       studieInfo: studieInfo ?? this.studieInfo,
//       selectedSpecialization:
//           selectedSpecialization ?? this.selectedSpecialization,
//       selectedGender: selectedGender ?? this.selectedGender,
//     );
//   }
// }
