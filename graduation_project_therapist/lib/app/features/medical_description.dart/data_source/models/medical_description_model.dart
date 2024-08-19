class MedicalDescriptionModel {
  final int patientId;
  final String mainComplaint;
  final String symptoms;
  final String causes;
  final String startDate;
  final String fType;
  final String fDescription;
  final String pType;
  final String pDescription;
  final String differentialDiagnosis;
  final String treatmentPlan;

  MedicalDescriptionModel({
    required this.patientId,
    required this.mainComplaint,
    required this.symptoms,
    required this.causes,
    required this.startDate,
    required this.fType,
    required this.fDescription,
    required this.pType,
    required this.pDescription,
    required this.differentialDiagnosis,
    required this.treatmentPlan,
  });

  factory MedicalDescriptionModel.fromMap(Map<String, dynamic> map) {
    return MedicalDescriptionModel(
      patientId: map['patientId'],
      mainComplaint: map['mainComplaint'],
      symptoms: map['symptoms'],
      causes: map['causes'],
      startDate: map['startDate'],
      fType: map['fType'],
      fDescription: map['fDescription'],
      pType: map['pType'],
      pDescription: map['pDescription'],
      differentialDiagnosis: map['differentialDiagnosis'],
      treatmentPlan: map['treatmentPlan'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'patientId': patientId.toString(),
      'mainComplaint': mainComplaint,
      'symptoms': symptoms,
      'causes': causes,
      'startDate': startDate,
      'fType': fType,
      'fDescription': fDescription,
      'pType': pType,
      'pDescription': pDescription,
      'differentialDiagnosis': differentialDiagnosis,
      'treatmentPlan': treatmentPlan,
    };
  }

  Map<String, dynamic> toMapWithoutID() {
    return {
      'mainComplaint': mainComplaint,
      'symptoms': symptoms,
      'causes': causes,
      'startDate': startDate,
      'fType': fType,
      'fDescription': fDescription,
      'pType': pType,
      'pDescription': pDescription,
      'differentialDiagnosis': differentialDiagnosis,
      'treatmentPlan': treatmentPlan,
    };
  }
}
