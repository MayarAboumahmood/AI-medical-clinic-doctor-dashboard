import 'package:easy_localization/easy_localization.dart';

enum UserStatusEnum {
  unverified,
  verified,
  pending,
  loading,
}

UserStatusEnum userStatusFromString(String status) {
  switch (status.toLowerCase()) {
    case 'unverified':
      return UserStatusEnum.unverified;
    case 'pending':
      return UserStatusEnum.pending;
    case 'verified':
      return UserStatusEnum.verified;
    case 'loading':
      return UserStatusEnum.loading;
    case 'loading...':
      return UserStatusEnum.loading;
    default:
      throw ArgumentError('Invalid user status: $status');
  }
}

String userStatusToString(UserStatusEnum status) {
  switch (status) {
    case UserStatusEnum.unverified:
      return 'unverified'.tr();
    case UserStatusEnum.verified:
      return 'verified'.tr();
    case UserStatusEnum.pending:
      return 'pending'.tr();
    case UserStatusEnum.loading:
      return 'Loading...'.tr();
  }
}
