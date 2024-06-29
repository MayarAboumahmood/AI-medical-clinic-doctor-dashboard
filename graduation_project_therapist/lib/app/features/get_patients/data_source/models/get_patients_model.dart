class GetPatientsModel {
  int id;
  String name;
  GetPatientsModel({
    required this.id,
    required this.name,
  });

  GetPatientsModel copyWith({
    int? id,
    String? name,
  }) {
    return GetPatientsModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory GetPatientsModel.fromMap(Map<String, dynamic> map) {
    return GetPatientsModel(
      id: map['id'] as int,
      name: map['name'],
    );
  }
}

// class SpecialistProfile {
//   int id;
//   String fullName;
//   String photo;
//   String specInfo;

//   SpecialistProfile({
//     required this.id,
//     required this.fullName,
//     required this.photo,
//     required this.specInfo,
//   });

//   SpecialistProfile copyWith({
//     int? id,
//     String? fullName,
//     String? photo,
//     String? specInfo,
//   }) {
//     return SpecialistProfile(
//       id: id ?? this.id,
//       fullName: fullName ?? this.fullName,
//       photo: photo ?? this.photo,
//       specInfo: specInfo ?? this.specInfo,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'fullName': fullName,
//       'photo': photo,
//       'specInfo': specInfo,
//     };
//   }

//   factory SpecialistProfile.fromMap(Map<String, dynamic> map) {
//     return SpecialistProfile(
//       id: map['id'] as int,
//       fullName: map['fullName'] ?? '',
//       photo: map['photo'] ?? '',
//       specInfo: map['specInfo'] ?? '',
//     );
//   }
// }
