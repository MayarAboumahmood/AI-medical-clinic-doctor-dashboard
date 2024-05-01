part of 'user_profile_cubit.dart';

@immutable
sealed class UserProfileState extends Equatable {}

final class UserProfileInitial extends UserProfileState {
  @override
  List<Object?> get props => [];
}

final class UserProfileGetData extends UserProfileState {
  final UserProfileModel userProfileModel;
  UserProfileGetData({required this.userProfileModel});
  @override
  List<Object?> get props => [userProfileModel];
}

final class UserProfileLoadingState extends UserProfileState {
  @override
  List<Object?> get props => [];
}
