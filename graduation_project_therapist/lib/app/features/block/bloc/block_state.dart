part of 'block_bloc.dart';

@immutable
sealed class BlockState extends Equatable {}

final class BlockInitial extends BlockState {
  @override
  List<Object?> get props => [];
}

final class UnBlockPatientSuccessState extends BlockState {
  @override
  List<Object?> get props => [];
}
final class BlockPatientSuccessState extends BlockState {
  @override
  List<Object?> get props => [];
}
final class GetAllBlocedPatientState extends BlockState {
  @override
  List<Object?> get props => [];
}

final class BlocFauilerState extends BlockState {
  final String errorMessage;
  BlocFauilerState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

// final class GetUserStatesuccessfulyState extends BlockState {
//   GetUserStatesuccessfulyState();
//   @override
//   List<Object?> get props => [];
// }
