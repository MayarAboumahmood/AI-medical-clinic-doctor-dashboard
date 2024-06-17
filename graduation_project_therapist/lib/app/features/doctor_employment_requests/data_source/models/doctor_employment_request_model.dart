class DoctorEmploymentRequestModel {
  final int id;
  final String date;
  final bool? status;
  final String clinicName;
  final String doctorName;

  DoctorEmploymentRequestModel({
    required this.id,
    required this.date,
    required this.clinicName,
    required this.doctorName,
    this.status,
  });

  factory DoctorEmploymentRequestModel.fromMap(Map<String, dynamic> json) {
    return DoctorEmploymentRequestModel(
      id: json['id'],
      date: json['data'] ?? json['date'] ?? 'unknown',
      status: json['status'],
      clinicName: json['clinicName'] ?? '',
      doctorName: json['doctorName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'clinicName': clinicName,
      'doctorName': doctorName,
      'status': status,
    };
  }
}
