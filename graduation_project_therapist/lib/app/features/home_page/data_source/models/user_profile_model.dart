class UserProfileModel {
  int id;
  String fullName;
  String? dateOfBirth;
  bool gender;
  String photo;
  String phone;
  String status;
  int userId;

  UserProfileModel({
    required this.id,
    required this.fullName,
    this.dateOfBirth,
    required this.gender,
    required this.photo,
    required this.phone,
    required this.status,
    required this.userId,
  });

  // From JSON constructor
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] as int,
      fullName: json['fullName'] as String,
      dateOfBirth: json['dateOfBirth'] as String?,
      gender: json['gender'] as bool,
      photo: json['photo'] as String,
      phone: json['phone'].toString(), // Ensure phone is a String
      status: json['status'] as String,
      userId: json['userId'] as int,
    );
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'photo': photo,
      'phone': phone,
      'status': status,
      'userId': userId,
    };
  }

  UserProfileModel copyWith({
    int? id,
    String? fullName,
    String? dateOfBirth,
    bool? gender,
    String? photo,
    String? phone,
    String? status,
    int? userId,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      photo: photo ?? this.photo,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      userId: userId ?? this.userId,
    );
  }
}
