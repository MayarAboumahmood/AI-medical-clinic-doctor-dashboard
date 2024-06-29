class PatientReservationModel {
  String patientName;
  int id;

  String date;

  PatientReservationModel({
    required this.patientName,
    required this.id,
    required this.date,
  });

  factory PatientReservationModel.fromMap(Map<String, dynamic> json) {
    return PatientReservationModel(
      patientName: json['patientName'],
      id: json['id'],
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
