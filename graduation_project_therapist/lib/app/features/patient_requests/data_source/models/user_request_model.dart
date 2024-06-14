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
}
