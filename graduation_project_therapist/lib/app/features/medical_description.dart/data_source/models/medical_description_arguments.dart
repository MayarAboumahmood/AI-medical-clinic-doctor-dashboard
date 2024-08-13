class MedicalDetailsArgs {
  final int medicalDescriptionId;
  final int patientID;
  final String patientName;

  MedicalDetailsArgs({
    required this.medicalDescriptionId,
    required this.patientName,
    required this.patientID,
  });
}
