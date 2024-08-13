part of 'block_bloc.dart';

@immutable
sealed class BlockState extends Equatable {}

final class BlockInitial extends BlockState {
  @override
  List<Object?> get props => [];
}

final class UnBlockPatientSuccessState extends BlockState {
  final String blockedPatientName;
  UnBlockPatientSuccessState({required this.blockedPatientName});

  @override
  List<Object?> get props => [blockedPatientName];
}

final class BlockPatientSuccessState extends BlockState {
  @override
  List<Object?> get props => [];
}

final class UnBlocedPatientLoadingState extends BlockState {
  @override
  List<Object?> get props => [];
}

final class BlocedPatientLoadingState extends BlockState {
  @override
  List<Object?> get props => [];
}

final class GetAllBlocedPatientState extends BlockState {
  @override
  List<Object?> get props => [];
}

final class BlockFauilerState extends BlockState {
  final String errorMessage;
  BlockFauilerState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

final class ReportFauilerState extends BlockState {
  final String errorMessage;
  ReportFauilerState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}


final class ReportPatientSuccessState extends BlockState {
  @override
  List<Object?> get props => [];
}
final class ReportMedicalDescriptionSuccessState extends BlockState {
  @override
  List<Object?> get props => [];
}
