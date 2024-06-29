class PatientProfileModel {
  bool status;
  String message;
  Data data;

  PatientProfileModel({required this.status, required this.message, required this.data});

  factory PatientProfileModel.fromJson(Map<String, dynamic> json) {
    return PatientProfileModel(
      status: json['status'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class Data {
  int id;
  String dateOfBirth;
  bool gender;
  String fullName;
  String maritalStatus;
  int children;
  String profession;
  int hoursOfWork;
  String placeOfWork;

  Data({
    required this.id,
    required this.dateOfBirth,
    required this.gender,
    required this.fullName,
    required this.maritalStatus,
    required this.children,
    required this.profession,
    required this.hoursOfWork,
    required this.placeOfWork,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      fullName: json['fullName'],
      maritalStatus: json['maritalStatus'],
      children: json['children'],
      profession: json['profession'],
      hoursOfWork: json['hoursOfWork'],
      placeOfWork: json['placeOfWork'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'fullName': fullName,
      'maritalStatus': maritalStatus,
      'children': children,
      'profession': profession,
      'hoursOfWork': hoursOfWork,
      'placeOfWork': placeOfWork,
    };
  }
}
