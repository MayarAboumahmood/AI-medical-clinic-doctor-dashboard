// class UserProfileResponse {
//   UserData? data;

//   UserProfileResponse({this.data});

//   factory UserProfileResponse.fromMap(Map<String, dynamic> json) {
//     return UserProfileResponse(
//       data: json['data'] != null ? UserData.fromMap(json['data']) : null,
//     );
//   }
// }

// class UserData {
//   int id;
//   String firstname;
//   String lastname;
//   String email;
//   String phone;
//   String gender;
//   String state;
//   String? profilePicture;
//   String birthDate;

//   UserData({
//     required this.id,
//     required this.firstname,
//     required this.lastname,
//     required this.email,
//     required this.phone,
//     required this.gender,
//     required this.state,
//     this.profilePicture,
//     required this.birthDate,
//   });

//   factory UserData.fromMap(Map<String, dynamic> json) {
//     return UserData(
//       id: json['id'],
//       firstname: json['firstname'] ?? 'name',
//       lastname: json['lastname'] ?? 'last name',
//       email: json['email'] ?? '',
//       phone: json['phone'] ?? '09..',
//       gender: json['gender'] != null
//           ? json['gender']
//               ? 'Male'
//               : 'Female'
//           : 'male/female',
//       state: json['State'] ?? 'state', // Note the capital 'S' in 'State'
//       profilePicture: json['profilePicture'] ?? '',
//       birthDate: json['birthDate'] ?? '?/?/?',
//     );
//   }
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'firstname': firstname,
//       'lastname': lastname,
//       'email': email,
//       'phone': phone,
//       'gender': gender,
//       'State': state, // Note the capital 'S' in 'State'
//       'profilePicture': profilePicture,
//       'birthDate': birthDate,
//     };
//   }
// }
