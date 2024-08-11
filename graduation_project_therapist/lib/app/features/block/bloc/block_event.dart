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

class GetAllBlocedPatientEvent extends BlockEvent {
  @override
  List<Object?> get props => [];
}
