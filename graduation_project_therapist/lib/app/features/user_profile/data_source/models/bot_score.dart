class BotScoreResponse {
  final bool status;
  final String message;
  final List<Score> data;

  BotScoreResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BotScoreResponse.fromJson(Map<String, dynamic> json) {
    return BotScoreResponse(
      status: json['status'],
      message: json['message'],
      data: List<Score>.from(json['data'].map((x) => Score.fromJson(x))),
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

class Score {
  final int id;
  final String score;
  final int userId;

  Score({
    required this.id,
    required this.score,
    required this.userId,
  });

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      id: json['id'],
      score: json['score'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'score': score,
      'userId': userId,
    };
  }
}
