class MedicalDescriptionDetailsModel {
  bool status;
  String message;
  MedicalRecordData data;

  MedicalDescriptionDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MedicalDescriptionDetailsModel.fromJson(Map<String, dynamic> json) {
    return MedicalDescriptionDetailsModel(
      status: json['status'],
      message: json['message'],
      data: MedicalRecordData.fromJson(json['data']),
    );
  }
}

class MedicalRecordData {
  int id;
  String mainComplaint;
  String createdAt;
  int doctorId;
  int userId;
  List<MedicalCondition> medicalConditions;
  List<MedicalFamilyHistory> medicalFamilyHistories;
  List<MedicalPersonalHistory> medicalPersonalHistories;
  List<MedicalDiagnosis> medicalDiagnosis;

  MedicalRecordData({
    required this.id,
    required this.mainComplaint,
    required this.createdAt,
    required this.doctorId,
    required this.userId,
    required this.medicalConditions,
    required this.medicalFamilyHistories,
    required this.medicalPersonalHistories,
    required this.medicalDiagnosis,
  });

  factory MedicalRecordData.fromJson(Map<String, dynamic> json) {
    var medicalConditionsJson = json['medicalConditions'] as List;
    var medicalFamilyHistoriesJson = json['medicalFamilyHistories'] as List;
    var medicalPersonalHistoriesJson = json['medicalPersonalHistories'] as List;
    var medicalDiagnosisJson = json['medicalDiagnosis'] as List;

    return MedicalRecordData(
      id: json['id'],
      mainComplaint: json['MainComplaint'],
      createdAt: json['createdAt'],
      doctorId: json['doctorId'],
      userId: json['userId'],
      medicalConditions: medicalConditionsJson
          .map((e) => MedicalCondition.fromJson(e))
          .toList(),
      medicalFamilyHistories: medicalFamilyHistoriesJson
          .map((e) => MedicalFamilyHistory.fromJson(e))
          .toList(),
      medicalPersonalHistories: medicalPersonalHistoriesJson
          .map((e) => MedicalPersonalHistory.fromJson(e))
          .toList(),
      medicalDiagnosis: medicalDiagnosisJson
          .map((e) => MedicalDiagnosis.fromJson(e))
          .toList(),
    );
  }
}

class MedicalCondition {
  int id;
  String symptoms;
  String causes;
  String startDate;
  int medicalRecordId;

  MedicalCondition({
    required this.id,
    required this.symptoms,
    required this.causes,
    required this.startDate,
    required this.medicalRecordId,
  });

  factory MedicalCondition.fromJson(Map<String, dynamic> json) {
    return MedicalCondition(
      id: json['id'],
      symptoms: json['symptoms'],
      causes: json['causes'],
      startDate: json['startDate'],
      medicalRecordId: json['medicalRecordId'],
    );
  }
}

class MedicalFamilyHistory {
  int id;
  String type;
  String description;
  int medicalRecordId;

  MedicalFamilyHistory({
    required this.id,
    required this.type,
    required this.description,
    required this.medicalRecordId,
  });

  factory MedicalFamilyHistory.fromJson(Map<String, dynamic> json) {
    return MedicalFamilyHistory(
      id: json['id'],
      type: json['type'],
      description: json['description'],
      medicalRecordId: json['medicalRecordId'],
    );
  }
}

class MedicalPersonalHistory {
  int id;
  String type;
  String description;
  int medicalRecordId;

  MedicalPersonalHistory({
    required this.id,
    required this.type,
    required this.description,
    required this.medicalRecordId,
  });

  factory MedicalPersonalHistory.fromJson(Map<String, dynamic> json) {
    return MedicalPersonalHistory(
      id: json['id'],
      type: json['type'],
      description: json['description'],
      medicalRecordId: json['medicalRecordId'],
    );
  }
}

class MedicalDiagnosis {
  int id;
  int medicalRecordId;
  String differentialDiagnosis;
  String treatmentPlan;

  MedicalDiagnosis({
    required this.id,
    required this.medicalRecordId,
    required this.differentialDiagnosis,
    required this.treatmentPlan,
  });

  factory MedicalDiagnosis.fromJson(Map<String, dynamic> json) {
    return MedicalDiagnosis(
      id: json['id'],
      medicalRecordId: json['medicalRecordId'],
      differentialDiagnosis: json['differentialDiagnosis'],
      treatmentPlan: json['treatmentPlan'],
    );
  }
}
