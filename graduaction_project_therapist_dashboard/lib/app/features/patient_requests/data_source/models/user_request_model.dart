import 'dart:convert';

class PatientRequestModel {
  String userName;
  String userInfo;
  String userImage;
  PatientRequestModel({
    required this.userName,
    required this.userInfo,
    required this.userImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'userInfo': userInfo,
      'userImage': userImage,
    };
  }

  factory PatientRequestModel.fromMap(Map<String, dynamic> map) {
    return PatientRequestModel(
      userName: map['userName'] as String,
      userInfo: map['userInfo'] as String,
      userImage: map['userImage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PatientRequestModel.fromJson(String source) =>
      PatientRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PatientRequestModel(userName: $userName, userInfo: $userInfo, userImage: $userImage)';

  @override
  bool operator ==(covariant PatientRequestModel other) {
    if (identical(this, other)) return true;

    return other.userName == userName &&
        other.userInfo == userInfo &&
        other.userImage == userImage;
  }

  @override
  int get hashCode =>
      userName.hashCode ^ userInfo.hashCode ^ userImage.hashCode;
}
