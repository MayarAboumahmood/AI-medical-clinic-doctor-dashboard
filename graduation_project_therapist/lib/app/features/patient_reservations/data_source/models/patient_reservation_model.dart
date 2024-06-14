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
  factory PatientReservationModel.fromMap(Map<String, dynamic> json) {
    return PatientReservationModel(
      userName: json['name'],
      userImage: json['image'],
      id: json['id'],
      prefNote: json['prefNote'],
      date: DateTime.parse(json['date']),
    );
  }
}

//TODO: delelte this list
List<PatientReservationModel> fakeReservations = [
  PatientReservationModel(
    userName: 'Alice Johnson',
    userImage: 'https://example.com/images/alice.jpg',
    id: 101,
    prefNote: 'Allergic to penicillin',
    date: DateTime(2024, 6, 15, 10, 0), // June 15, 2024, 10:00 AM
  ),
  PatientReservationModel(
    userName: 'Bob Smith',
    userImage: 'https://example.com/images/bob.jpg',
    id: 102,
    prefNote: 'Prefers morning appointments',
    date: DateTime(2024, 6, 20, 9, 0), // June 20, 2024, 9:00 AM
  ),
  PatientReservationModel(
    userName: 'Catherine Lee',
    userImage: 'https://example.com/images/catherine.jpg',
    id: 103,
    prefNote: 'Diabetic patient',
    date: DateTime(2024, 6, 25, 14, 30), // June 25, 2024, 2:30 PM
  ),
  PatientReservationModel(
    userName: 'Daniel Kim',
    userImage: 'https://example.com/images/daniel.jpg',
    id: 104,
    prefNote: 'Vegetarian diet',
    date: DateTime(2024, 7, 1, 11, 45), // July 1, 2024, 11:45 AM
  ),
  PatientReservationModel(
    userName: 'Elena Rodriguez',
    userImage: 'https://example.com/images/elena.jpg',
    id: 105,
    prefNote: 'Needs wheelchair accessibility',
    date: DateTime(2024, 7, 5, 16, 15), // July 5, 2024, 4:15 PM
  ),
];
