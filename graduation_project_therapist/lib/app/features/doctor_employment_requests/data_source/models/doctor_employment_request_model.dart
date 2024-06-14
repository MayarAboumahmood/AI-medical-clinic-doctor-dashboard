class DoctorEmploymentRequestModel {
  final int id;
  final String date;
  final int clinicId;
  final int userId;
  final String? status;

  DoctorEmploymentRequestModel({
    required this.id,
    required this.date,
    required this.clinicId,
    required this.userId,
    this.status,
  });

  factory DoctorEmploymentRequestModel.fromMap(Map<String, dynamic> json) {
    return DoctorEmploymentRequestModel(
      id: json['id'],
      date: json['date'],
      clinicId: json['clinicId'],
      userId: json['userId'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'clinicId': clinicId,
      'userId': userId,
      'status': status,
    };
  }
}
