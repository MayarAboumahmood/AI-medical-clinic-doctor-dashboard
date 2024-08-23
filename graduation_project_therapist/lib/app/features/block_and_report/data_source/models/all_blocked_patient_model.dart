import 'package:easy_localization/easy_localization.dart';

class AllBlockedPatientModel {
  final bool status;
  final String message;
  final List<BlockedUser> data;

  AllBlockedPatientModel({
    required this.status,
    required this.message,
    required this.data,
  });

  // Factory method to create a BlockedUsersResponse object from JSON
  factory AllBlockedPatientModel.fromJson(Map<String, dynamic> json) {
    return AllBlockedPatientModel(
      status: json['status'],
      message: json['message'],
      data: List<BlockedUser>.from(
        json['data'].map((user) => BlockedUser.fromJson(user)),
      ),
    );
  }

  // Method to convert a BlockedUsersResponse object to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.map((user) => user.toJson()).toList(),
    };
  }
}

class BlockedUser {
  final int id;
  final int doctorId;
  final int userId;
  final String patientName;
  final String image;
  final String date;

  BlockedUser({
    required this.id,
    required this.doctorId,
    required this.userId,
    required this.patientName,
    required this.image,
    required this.date,
  });

  // Factory method to create a BlockedUser object from JSON
  factory BlockedUser.fromJson(Map<String, dynamic> json) {
    return BlockedUser(
      id: json['id'],
      doctorId: json['doctorId'],
      userId: json['userId'],
      patientName: json['userName'] ?? 'Unknown'.tr(),
      image: json['image'] ?? 'Unkown'.tr(),
      date: json['date'] ?? 'Unkown'.tr(),
    );
  }
  // Method to convert a BlockedUser object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctorId': doctorId,
      'userId': userId,
      'patientName': patientName,
      'image': image,
    };
  }
}
