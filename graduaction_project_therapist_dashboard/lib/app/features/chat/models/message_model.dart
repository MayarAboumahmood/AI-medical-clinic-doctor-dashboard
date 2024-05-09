class Message {
  int? id; // Auto-incremented database ID
  String type; // 'text', 'image', or 'voice'
  String content; // URL or text content
  String timestamp; // Store timestamps as String

  Message(
      {this.id,
      required this.type,
      required this.content,
      required this.timestamp});

  // Convert a Message into a Map. The keys must correspond to the names of the columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'content': content,
      'timestamp': timestamp,
    };
  }

  // Extract a Message from a Map. This is used when querying the database.
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      type: map['type'],
      content: map['content'],
      timestamp: map['timestamp'],
    );
  }
  Message copyWith({
    int? id,
    String? type,
    String? content,
    String? timestamp,
  }) {
    return Message(
      id: id ?? this.id,
      type: type ?? this.type,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
