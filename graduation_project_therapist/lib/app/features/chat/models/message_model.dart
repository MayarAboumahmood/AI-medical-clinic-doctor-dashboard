class MessageModel {
  int? id; // Auto-incremented database ID
  MessageTypeEnum type; // 'text', 'image', or 'voice'
  Object? content; 
  String timestamp; // Store timestamps as String
  bool iAmTheSender;
  MessageModel(
      {this.id,
      required this.type,
      required this.content,
      required this.timestamp,
      required this.iAmTheSender});

  // Convert a Message into a Map. The keys must correspond to the names of the columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.index,
      'content': content,
      'timestamp': timestamp,
      'iAmSender': iAmTheSender,
    };
  }

  // Extract a Message from a Map. This is used when querying the database.
  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'],
      type: map['type'],
      content: map['content'],
      timestamp: map['timestamp'],
      iAmTheSender: map['timestamp'],
    );
  }
  MessageModel copyWith({
    int? id,
    MessageTypeEnum? type,
    String? content,
    String? timestamp,
    bool? iAmTheSender,
  }) {
    return MessageModel(
      id: id ?? this.id,
      type: type ?? this.type,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      iAmTheSender: iAmTheSender ?? this.iAmTheSender,
    );
  }
}

enum MessageTypeEnum {
  text,
  image,
  voice,
}
