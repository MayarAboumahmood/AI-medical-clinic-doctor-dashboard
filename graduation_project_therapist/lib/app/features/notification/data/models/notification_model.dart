import 'package:easy_localization/easy_localization.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_functions/chose_langauge_from_backend.dart';

class NotificationModel {
  final int id;
  final String title;
  final String description;
  final String date;
  final int customerId;
  final int seenType;
  final int liveType;
  final String createdAt;
  final String updatedAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.customerId,
    required this.seenType,
    required this.liveType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> rowJson) {
    Map<String, dynamic> json = removeDuplicateKeysAr(rowJson);

    return NotificationModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: json['date'],
      customerId: json['customer_id'],
      seenType: json['seen_type'],
      liveType: json['live_type'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'customer_id': customerId,
      'seen_type': seenType,
      'live_type': liveType,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  String get formattedTime =>
      DateFormat('HH:mm').format(DateTime.parse(createdAt));

  // Helper method to determine if the date is today, yesterday, or older
  String get relativeDate {
    final createdAtDate = DateTime.parse(createdAt);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    if (createdAtDate.compareTo(today) == 0) {
      return 'Today';
    } else if (createdAtDate.compareTo(yesterday) == 0) {
      return 'Yesterday';
    } else {
      // You can adjust the format as needed
      return DateFormat('yyyy-MM-dd').format(createdAtDate);
    }
  }
}
