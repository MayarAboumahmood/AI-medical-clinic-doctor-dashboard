import 'dart:math';

class UserProfileModel {
  final String name;
  final String? image; // Optional
  final DateTime dateOfBirth;
  final String relationshipState;
  final int numberOfKids;
  final String currentWork;
  final double? workHoursPerDay; // Optional
  final String? placeOfWork; // Optional

  UserProfileModel({
    required this.name,
    this.image,
    required this.dateOfBirth,
    required this.relationshipState,
    required this.numberOfKids,
    required this.currentWork,
    this.workHoursPerDay,
    this.placeOfWork,
  });

  // Factory constructor for creating a new UserProfileModelinstance from a map.
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      name: json['name'],
      image: json['image'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      relationshipState: json['relationshipState'],
      numberOfKids: json['numberOfKids'],
      currentWork: json['currentWork'],
      workHoursPerDay: json['workHoursPerDay']?.toDouble(),
      placeOfWork: json['placeOfWork'],
    );
  }

  // Method to serialize UserProfileModelobject to JSON.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'relationshipState': relationshipState,
      'numberOfKids': numberOfKids,
      'currentWork': currentWork,
      'workHoursPerDay': workHoursPerDay,
      'placeOfWork': placeOfWork,
    };
  }

  static UserProfileModel generateFakeUserProfile() {
    final random = Random();

    // Helper function to generate a random date of birth
    DateTime randomDateOfBirth() {
      int year = 1950 + random.nextInt(50); // Year between 1950 and 2000
      int month = 1 + random.nextInt(12); // Month between 1 and 12
      int day = 1 +
          random
              .nextInt(28); // Day between 1 and 28 to avoid month/day conflicts
      return DateTime(year, month, day);
    }

    // Creating a random UserProfile
    return UserProfileModel(
      name:
          'Person ${random.nextInt(1000)}', // Randomly generated name identifier
      image: random.nextBool()
          ? 'https://example.com/image${random.nextInt(100)}.jpg'
          : null,
      dateOfBirth: randomDateOfBirth(),
      relationshipState: [
        'Single',
        'Married',
        'Divorced',
        'Widowed'
      ][random.nextInt(4)],
      numberOfKids: random.nextInt(6), // Random number of kids from 0 to 5
      currentWork: 'Job ${random.nextInt(100)}', // Random job identifier
      workHoursPerDay: random.nextBool()
          ? random.nextDouble() * 10
          : null, // Random work hours, up to 10 hours, or null
      placeOfWork: random.nextBool()
          ? 'City ${random.nextInt(100)}'
          : null, // Random city name or null
    );
  }
}
