class GetTherapistModel {
  int id;
  bool status;
  SpecialistProfile specialistProfile;
  bool employmentRequests;

  GetTherapistModel({
    required this.id,
    required this.status,
    required this.specialistProfile,
    required this.employmentRequests,
  });

  GetTherapistModel copyWith({
    int? id,
    SpecialistProfile? specialistProfile,
    bool? employmentRequests,
    bool? status,
  }) {
    return GetTherapistModel(
      id: id ?? this.id,
      status: status ?? this.status,
      specialistProfile: specialistProfile ?? this.specialistProfile,
      employmentRequests: employmentRequests ?? this.employmentRequests,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status,
      'specialistProfile': specialistProfile.toMap(),
      'employmentRequests': employmentRequests,
    };
  }

  factory GetTherapistModel.fromMap(Map<String, dynamic> map) {
    print('alll therapist mappapap: $map');
    return GetTherapistModel(
      id: map['id'] as int,
      status: map['status'] ?? false,
      specialistProfile: SpecialistProfile.fromMap(
          map['specialistProfile'] as Map<String, dynamic>),
      employmentRequests: map['employmentRequests'] == null ? false : true,
    );
  }
}

class SpecialistProfile {
  int id;
  String fullName;
  String photo;
  String specInfo;

  SpecialistProfile({
    required this.id,
    required this.fullName,
    required this.photo,
    required this.specInfo,
  });

  SpecialistProfile copyWith({
    int? id,
    String? fullName,
    String? photo,
    String? specInfo,
  }) {
    return SpecialistProfile(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      photo: photo ?? this.photo,
      specInfo: specInfo ?? this.specInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'photo': photo,
      'specInfo': specInfo,
    };
  }

  factory SpecialistProfile.fromMap(Map<String, dynamic> map) {
    return SpecialistProfile(
      id: map['id'] as int,
      fullName: map['fullName'] ?? '',
      photo: map['photo'] ?? '',
      specInfo: map['specInfo'] ?? '',
    );
  }
}
