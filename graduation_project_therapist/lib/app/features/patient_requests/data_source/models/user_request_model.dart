class PatientRequestModel {
  int id;
  bool? status;
  String description;
  String patientName;
  String? proposedDate;

  PatientRequestModel({
    required this.id,
    this.status,
    required this.description,
    required this.patientName,
    this.proposedDate,
  });

  factory PatientRequestModel.fromMap(Map<String, dynamic> json) {
    return PatientRequestModel(
      id: json['id'],
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
    };
  }
}
