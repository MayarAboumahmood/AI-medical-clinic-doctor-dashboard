class PatientReservationModel {
  String userName;
  String? userImage;
  int id;
  String prefNote;
  DateTime date;
  PatientReservationModel({
    required this.userName,
    required this.userImage,
    required this.id,
    required this.prefNote,
    required this.date,
  });
  factory PatientReservationModel.fromJson(Map<String, dynamic> json) {
    return PatientReservationModel(
      userName: json['name'],
      userImage: json['image'],
      id: json['id'],
      prefNote: json['prefNote'],
      date: DateTime.parse(json['date']),
    );
  }
}
