class ChatInfoModel {
  bool status;
  String message;
  Data data;

  ChatInfoModel({
    required this.status,
    required this.message,
    required this.data,
  });

  // Factory constructor to create a ChatInfoModel object from JSON
  factory ChatInfoModel.fromJson(Map<String, dynamic> json) {
    return ChatInfoModel(
      status: json['status'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }

  // Method to convert a ChatInfoModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class Data {
  String channelName;
  String token;

  Data({
    required this.channelName,
    required this.token,
  });

  // Factory constructor to create a Data object from JSON
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      channelName: json['channelName'],
      token: json['token'],
    );
  }

  // Method to convert a Data object to JSON
  Map<String, dynamic> toJson() {
    return {
      'channelName': channelName,
      'token': token,
    };
  }
}
