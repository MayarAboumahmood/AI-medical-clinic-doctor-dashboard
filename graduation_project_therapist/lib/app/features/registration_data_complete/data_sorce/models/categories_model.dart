class SpeCategoryResponse {
  final bool status;
  final String message;
  final List<SpeCategory> data;

  SpeCategoryResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SpeCategoryResponse.fromJson(Map<String, dynamic> json) {
    return SpeCategoryResponse(
      status: json['status'],
      message: json['message'],
      data: List<SpeCategory>.from(json['data'].map((x) => SpeCategory.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': List<dynamic>.from(data.map((x) => x.toJson())),
    };
  }
}

class SpeCategory {
  final int id;
  final String name;
  final String eng;

  SpeCategory({
    required this.id,
    required this.name,
    required this.eng,
  });

  factory SpeCategory.fromJson(Map<String, dynamic> json) {
    return SpeCategory(
      id: json['id'],
      name: json['name'],
      eng: json['eng'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'eng': eng,
    };
  }
}
