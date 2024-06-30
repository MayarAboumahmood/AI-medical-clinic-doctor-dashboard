class PatientReservationModel {
  String patientName;
  int id;
  int patientID;
  String date;

  PatientReservationModel({
    required this.patientName,
    required this.id,
    required this.patientID,
    required this.date,
  });

  factory PatientReservationModel.fromMap(Map<String, dynamic> json) {
    return PatientReservationModel(
      patientName: json['patientName'],
      id: json['id'],
      patientID: json['patientId'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patientName': patientName,
      'id': id,
      'date': date,
    };
  }
}
