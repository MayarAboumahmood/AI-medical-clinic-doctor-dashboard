part of 'block_bloc.dart';

@immutable
sealed class BlockEvent extends Equatable {}

class BlocPatientEvent extends BlockEvent {
  final int patientId;
  BlocPatientEvent({required this.patientId});
  @override
  List<Object?> get props => [patientId];
}
class UnBlocPatientEvent extends BlockEvent {
  final int patientId;
  UnBlocPatientEvent({required this.patientId});
  @override
  List<Object?> get props => [patientId];
}

class GetAllBlocedPatientEvent extends BlockEvent {
  @override
  List<Object?> get props => [];
}
