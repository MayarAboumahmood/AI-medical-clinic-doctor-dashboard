import 'dart:math';

import 'package:equatable/equatable.dart';

class AchivementApiResponse extends Equatable {
  final bool success;
  final Data data;
  final String message;

  const AchivementApiResponse(
      {required this.success, required this.data, required this.message});

  factory AchivementApiResponse.fromMap(Map<String, dynamic> json) {
    return AchivementApiResponse(
      success: json['success'],
      data: Data.fromMap(json['data']),
      message: json['message'],
    );
  }

  @override
  List<Object?> get props => [success, data, message];
}

class Data extends Equatable {
  final List<Coupon> coupons;
  final List<Achievement> achievments;

  const Data({required this.coupons, required this.achievments});

  factory Data.fromMap(Map<String, dynamic> json) {
    return Data(
      coupons: (json['Coupons'] as List).map((i) => Coupon.fromMap(i)).toList(),
      achievments: (json['Achievments'] as List)
          .map((i) => Achievement.fromMap(i))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [coupons, achievments];
}

class Coupon extends Equatable {
  final int id;
  final String description;
  final String code;
  final String discount;
  final String limit;
  final String startDate;
  final String endDate;
  final String image;
  final String type;

  const Coupon(
      {required this.id,
      required this.description,
      required this.code,
      required this.discount,
      required this.limit,
      required this.startDate,
      required this.endDate,
      required this.image,
      required this.type});

  factory Coupon.fromMap(Map<String, dynamic> json) {
    return Coupon(
      id: json['id'],
      description: json['description'],
      code: json['code'],
      discount: json['discount'],
      limit: json['limit'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      image: json['image'],
      type: json['type'],
    );
  }

  @override
  List<Object?> get props =>
      [id, description, code, discount, limit, startDate, endDate, image, type];

  Coupon generateRandomCoupon() {
    final random = Random();
    int id = random.nextInt(1000);
    String description = "Coupon Description ${random.nextInt(100)}";
    String code = "CODE${random.nextInt(1000)}";
    String discount = "${random.nextInt(100)}%";
    String limit = "${random.nextInt(50)} uses";
    String startDate = "2023-01-${random.nextInt(28) + 1}";
    String endDate = "2023-12-${random.nextInt(28) + 1}";
    String image = "https://example.com/image${random.nextInt(10)}.png";
    String type = random.nextBool() ? "Fixed" : "Percentage";

    return Coupon(
      id: id,
      description: description,
      code: code,
      discount: discount,
      limit: limit,
      startDate: startDate,
      endDate: endDate,
      image: image,
      type: type,
    );
  }
}

class Achievement extends Equatable {
  final int id;
  final String discount;
  final String title;
  final String description;
  final String coupons;
  final int userCount;
  final int target;

  const Achievement(
      {required this.id,
      required this.discount,
      required this.userCount,
      required this.target,
      required this.title,
      required this.description,
      required this.coupons});

  factory Achievement.fromMap(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'],
      discount: json['discount'],
      title: json['title'],
      description: json['description'],
      userCount: json['user_count'],
      target: json['target'],
      coupons: json['coupons'],
    );
  }

  @override
  List<Object?> get props =>
      [id, discount, title, description, coupons, target, userCount];
}
