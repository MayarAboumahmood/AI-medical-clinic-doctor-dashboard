part of 'block_bloc.dart';

@immutable
sealed class BlockEvent extends Equatable {}

class BlockPatientEvent extends BlockEvent {
  final int patientId;
  BlockPatientEvent({required this.patientId});
  @override
  List<Object?> get props => [patientId];
}

class UnBlocPatientEvent extends BlockEvent {
  final int patientId;
  final String blockedPatientName;
  UnBlocPatientEvent(
      {required this.patientId, required this.blockedPatientName});
  @override
  List<Object?> get props => [patientId, blockedPatientName];
}

// ignore: must_be_immutable
class GetAllBlocedPatientEvent extends BlockEvent {
  bool fromRefreshIndicator;
  GetAllBlocedPatientEvent({this.fromRefreshIndicator = false});
  @override
  List<Object?> get props => [];
}

class ReportPatientEvent extends BlockEvent {
  final int patientId;
  final String description;
  ReportPatientEvent({required this.patientId, required this.description});
  @override
  List<Object?> get props => [patientId, description];
}

class ReportMedicalDescriptionEvent extends BlockEvent {
  final int medicalDescriptionId;
  final String description;
  ReportMedicalDescriptionEvent(
      {required this.medicalDescriptionId, required this.description});
  @override
  List<Object?> get props => [medicalDescriptionId, description];
}
