import 'package:equatable/equatable.dart';
import 'package:graduation_project_therapist_dashboard/app/core/status_requests/staus_request.dart';

class GetUserDataAState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetUserDataState extends GetUserDataAState {}

class UserDataInitial extends GetUserDataAState {
  @override
  List<Object?> get props => [];
}

final class FetchUserDataFauilerState extends GetUserDataAState {
  final StatusRequest statusRequest;

  FetchUserDataFauilerState({required this.statusRequest});

  @override
  List<Object> get props => [statusRequest];
}
