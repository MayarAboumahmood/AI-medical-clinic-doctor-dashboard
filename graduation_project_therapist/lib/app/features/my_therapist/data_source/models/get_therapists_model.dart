class  GetTherapistModel {
  int id;
  SpecialistProfile specialistProfile;
  dynamic employee;

  GetTherapistModel({
    required this.id,
    required this.specialistProfile,
    this.employee,
  });

  GetTherapistModel copyWith({
    int? id,
    SpecialistProfile? specialistProfile,
    dynamic employee,
  }) {
    return GetTherapistModel(
      id: id ?? this.id,
      specialistProfile: specialistProfile ?? this.specialistProfile,
      employee: employee ?? this.employee,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'specialistProfile': specialistProfile.toMap(),
      'employee': employee,
    };
  }

  factory GetTherapistModel.fromMap(Map<String, dynamic> map) {
    return GetTherapistModel(
      id: map['id'] as int,
      specialistProfile: SpecialistProfile.fromMap(map['__specialistProfile__'] as Map<String, dynamic>),
      employee: map['employee'],
    );
  }
}

class SpecialistProfile {
  int id;
  String fullName;
  String photo;

  SpecialistProfile({
    required this.id,
    required this.fullName,
    required this.photo,
  });

  SpecialistProfile copyWith({
    int? id,
    String? fullName,
    String? photo,
  }) {
    return SpecialistProfile(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      photo: photo ?? this.photo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'photo': photo,
    };
  }

  factory SpecialistProfile.fromMap(Map<String, dynamic> map) {
    return SpecialistProfile(
      id: map['id'] as int,
      fullName: map['fullName'] as String,
      photo: map['photo'] as String,
    );
  }
}
