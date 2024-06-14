class UserInfo {
  String userEmail;
  String password;
  int roleId;
  String phoneNumber;
  String? dateOfBirth;
  String photo;
  int gender;
  String firstName;
  String lastName;

  UserInfo({
    required this.userEmail,
    required this.password,
    required this.roleId,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.photo,
    required this.gender,
    required this.firstName,
    required this.lastName,
  });

  // From JSON constructor
  factory UserInfo.fromMap(Map<String, dynamic> json) {
    return UserInfo(
      userEmail: json['email'] as String,
      password: json['password'] as String,
      roleId: json['roleId'] as int,
      phoneNumber: json['phone'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      photo: json['photo'] as String,
      gender: json['gender'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
    );
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    return {
      'email': userEmail,
      'password': password,
      'roleId': roleId,
      'phone': phoneNumber,
      'dateOfBirth': dateOfBirth,
      'photo': photo,
      'gender': gender,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  UserInfo copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? userEmail,
    String? dateOfBirth,
    String? password,
  }) {
    return UserInfo(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        userEmail: userEmail ?? this.userEmail,
        password: password ?? this.password,
        gender: gender,
        roleId: roleId,
        photo: photo);
  }
}
