class MedicalResponse {
  final bool status;
  final String message;
  final List<MedicalRecord> data;

  MedicalResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MedicalResponse.fromMap(Map<String, dynamic> map) {
    return MedicalResponse(
      status: map['status'],
      message: map['message'],
      data: List<MedicalRecord>.from(
          map['data'].map((record) => MedicalRecord.fromMap(record))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'data': List<dynamic>.from(data.map((record) => record.toMap())),
    };
  }
}

class MedicalRecord {
  final int id;
  final String mainComplaint;
  final int doctorId;
  final int userId;
  final List<MedicalCondition> medicalConditions;
  final List<MedicalFamilyHistory> medicalFamilyHistories;
  final List<MedicalPersonalHistory> medicalPersonalHistories;
  final List<MedicalDiagnosis> medicalDiagnosis;

  MedicalRecord({
    required this.id,
    required this.mainComplaint,
    required this.doctorId,
    required this.userId,
    required this.medicalConditions,
    required this.medicalFamilyHistories,
    required this.medicalPersonalHistories,
    required this.medicalDiagnosis,
  });

  factory MedicalRecord.fromMap(Map<String, dynamic> map) {
    return MedicalRecord(
      id: map['id'],
      mainComplaint: map['MainComplaint'],
      doctorId: map['doctorId'],
      userId: map['userId'],
      medicalConditions: List<MedicalCondition>.from(map['medicalConditions']
          .map((condition) => MedicalCondition.fromMap(condition))),
      medicalFamilyHistories: List<MedicalFamilyHistory>.from(
          map['medicalFamilyHistories']
              .map((history) => MedicalFamilyHistory.fromMap(history))),
      medicalPersonalHistories: List<MedicalPersonalHistory>.from(
          map['medicalPersonalHistories']
              .map((history) => MedicalPersonalHistory.fromMap(history))),
      medicalDiagnosis: List<MedicalDiagnosis>.from(map['medicalDiagnosis']
          .map((diagnosis) => MedicalDiagnosis.fromMap(diagnosis))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'MainComplaint': mainComplaint,
      'doctorId': doctorId,
      'userId': userId,
      'medicalConditions': List<dynamic>.from(
          medicalConditions.map((condition) => condition.toMap())),
      'medicalFamilyHistories': List<dynamic>.from(
          medicalFamilyHistories.map((history) => history.toMap())),
      'medicalPersonalHistories': List<dynamic>.from(
          medicalPersonalHistories.map((history) => history.toMap())),
      'medicalDiagnosis': List<dynamic>.from(
          medicalDiagnosis.map((diagnosis) => diagnosis.toMap())),
    };
  }
}

class MedicalCondition {
  final int id;
  final String symptoms;
  final String causes;
  final String startDate;
  final int medicalRecordId;

  MedicalCondition({
    required this.id,
    required this.symptoms,
    required this.causes,
    required this.startDate,
    required this.medicalRecordId,
  });

  factory MedicalCondition.fromMap(Map<String, dynamic> map) {
    return MedicalCondition(
      id: map['id'],
      symptoms: map['symptoms'],
      causes: map['causes'],
      startDate: map['startDate'],
      medicalRecordId: map['medicalRecordId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'symptoms': symptoms,
      'causes': causes,
      'startDate': startDate,
      'medicalRecordId': medicalRecordId,
    };
  }
}

class MedicalFamilyHistory {
  final int id;
  final String type;
  final String description;
  final int medicalRecordId;

  MedicalFamilyHistory({
    required this.id,
    required this.type,
    required this.description,
    required this.medicalRecordId,
  });

  factory MedicalFamilyHistory.fromMap(Map<String, dynamic> map) {
    return MedicalFamilyHistory(
      id: map['id'],
      type: map['type'],
      description: map['description'],
      medicalRecordId: map['medicalRecordId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'description': description,
      'medicalRecordId': medicalRecordId,
    };
  }
}

class MedicalPersonalHistory {
  final int id;
  final String type;
  final String description;
  final int medicalRecordId;

  MedicalPersonalHistory({
    required this.id,
    required this.type,
    required this.description,
    required this.medicalRecordId,
  });

  factory MedicalPersonalHistory.fromMap(Map<String, dynamic> map) {
    return MedicalPersonalHistory(
      id: map['id'],
      type: map['type'],
      description: map['description'],
      medicalRecordId: map['medicalRecordId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'description': description,
      'medicalRecordId': medicalRecordId,
    };
  }
}

class MedicalDiagnosis {
  final int id;
  final int medicalRecordId;
  final String differentialDiagnosis;
  final String treatmentPlan;

  MedicalDiagnosis({
    required this.id,
    required this.medicalRecordId,
    required this.differentialDiagnosis,
    required this.treatmentPlan,
  });

  factory MedicalDiagnosis.fromMap(Map<String, dynamic> map) {
    return MedicalDiagnosis(
      id: map['id'],
      medicalRecordId: map['medicalRecordId'],
      differentialDiagnosis: map['differentialDiagnosis'],
      treatmentPlan: map['treatmentPlan'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'medicalRecordId': medicalRecordId,
      'differentialDiagnosis': differentialDiagnosis,
      'treatmentPlan': treatmentPlan,
    };
  }
}
