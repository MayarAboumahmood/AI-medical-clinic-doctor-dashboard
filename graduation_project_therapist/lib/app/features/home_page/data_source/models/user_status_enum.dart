enum UserStatusEnum {
  unverified,
  verified,
}

UserStatusEnum userStatusFromString(String status) {
  switch (status.toLowerCase()) {
    case 'unverified':
      return UserStatusEnum.unverified;
    case 'verified':
      return UserStatusEnum.verified;
    default:
      throw ArgumentError('Invalid user status: $status');
  }
}

String userStatusToString(UserStatusEnum status) {
  switch (status) {
    case UserStatusEnum.unverified:
      return 'unverified';
    case UserStatusEnum.verified:
      return 'verified';
  }
}
