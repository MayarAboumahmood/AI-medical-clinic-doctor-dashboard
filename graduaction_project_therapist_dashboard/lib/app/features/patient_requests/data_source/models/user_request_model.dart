import 'dart:convert';

class PatientRequestModel {
  String userName;
  String userInfo;
  String userImage;
  int id;
  PatientRequestModel({
    required this.userName,
    required this.userInfo,
    required this.userImage,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'userInfo': userInfo,
      'userImage': userImage,
      'id': id,
    };
  }

  factory PatientRequestModel.fromMap(Map<String, dynamic> map) {
    return PatientRequestModel(
      userName: map['userName'] as String,
      userInfo: map['userInfo'] as String,
      userImage: map['userImage'] as String,
      id: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PatientRequestModel.fromJson(String source) =>
      PatientRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PatientRequestModel(userName: $userName, userInfo: $userInfo, userImage: $userImage, id: $id)';

  @override
  bool operator ==(covariant PatientRequestModel other) {
    if (identical(this, other)) return true;

    return other.userName == userName &&
        other.userInfo == userInfo &&
        other.id == id &&
        other.userImage == userImage;
  }

  @override
  int get hashCode =>
      userName.hashCode ^ userInfo.hashCode ^ userImage.hashCode ^ id.hashCode;
}
