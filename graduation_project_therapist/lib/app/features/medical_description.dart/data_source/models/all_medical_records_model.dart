class AllMedicalRecordsModel {
  final int id;
  final String mainComplaint;
  final String doctorUsername;
  final String patientName;
  final DateTime createdAt;

  AllMedicalRecordsModel({
    required this.id,
    required this.mainComplaint,
    required this.doctorUsername,
    required this.patientName,
    required this.createdAt,
  });

  // Factory method to create a Complaint from a JSON object
  factory AllMedicalRecordsModel.fromJson(Map<String, dynamic> json) {
    return AllMedicalRecordsModel(
      id: json['id'],
      mainComplaint: json['MainComplaint'],
      doctorUsername: json['doctorUsername'],
      patientName: json['patientName'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // Method to convert a Complaint object to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'MainComplaint': mainComplaint,
      'doctorUsername': doctorUsername,
      'patientName': patientName,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
  