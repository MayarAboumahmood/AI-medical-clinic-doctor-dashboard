class PatientRequestModel {
  int id;
  int patientID;
  bool? status;
  String description;
  String patientName;
  String? proposedDate;

  PatientRequestModel({
    required this.id,
    required this.patientID,
    this.status,
    required this.description,
    required this.patientName,
    this.proposedDate,
  });

  factory PatientRequestModel.fromMap(Map<String, dynamic> json) {
    return PatientRequestModel(
      id: json['id'],
      patientID: json['patientId'],
      status: json['status'],
      description: json['description'],
      patientName: json['patientName'],
      proposedDate: json['proposedDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'description': description,
      'patientName': patientName,
      'proposedDate': proposedDate,
      'patientId': patientID,
    };
  }
}
