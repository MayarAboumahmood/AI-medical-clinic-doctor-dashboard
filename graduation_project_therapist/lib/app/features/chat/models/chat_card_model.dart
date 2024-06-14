class ChatCardModel {
  String name;
  String image;

  // Constructor with required fields
  ChatCardModel({required this.name, required this.image});

  // Factory constructor for creating an instance from a JSON map
  factory ChatCardModel.fromMap(Map<String, dynamic> json) {
    return ChatCardModel(
      name: json['name'],
      image: json['image'],
    );
  }

  // Method to convert the instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
    };
  }
}
