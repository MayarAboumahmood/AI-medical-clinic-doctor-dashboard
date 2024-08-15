class UserProfileModel {
  int id;
  String fullName;
  String dateOfBirth;
  bool gender;
  String photo;
  String phone;
  String status;
  String? state;
  int userId;
  String? studyInfo;
  String? specInfo;

  UserProfileModel({
    required this.id,
    required this.fullName,
    required this.dateOfBirth,
    required this.gender,
    required this.photo,
    required this.phone,
    required this.status,
    required this.userId,
    required this.specInfo,
    required this.studyInfo,
    this.state,
  });

  // From JSON constructor
  factory UserProfileModel.fromMap(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] as int,
      fullName: json['fullName'] as String,
      dateOfBirth: json['dateOfBirth'] ?? '2001-01-01',
      gender: json['gender'] as bool,
      photo: json['photo'] as String,
      phone: json['phone'].toString(), 
      status: json['status'] as String,
      userId: json['userId'] as int,
      state: json['state'] as String?,
      studyInfo: json['studyInfo'] as String?,
      specInfo: json['specInfo'] as String?,
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
      'studyInfo': studyInfo,
      'specInfo': specInfo,
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
    String? studyInfo,
    String? specInfo,
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
      studyInfo: studyInfo ?? this.studyInfo,
      specInfo: specInfo ?? this.specInfo,
    );
  }
}
