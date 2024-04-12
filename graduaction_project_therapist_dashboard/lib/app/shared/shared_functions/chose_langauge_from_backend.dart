import 'package:graduation_project_therapist_dashboard/main.dart';

Map<String, dynamic> removeDuplicateKeysAr(Map<String, dynamic> data) {
  String languageCode = sharedPreferences?.getString('language_code') ?? 'en';

  if (languageCode == "en") {
    return data;
  } else {
    final newData = <String, dynamic>{};
    for (final key in data.keys) {
      if (key.startsWith('ar_')) {
        String newKey = key.substring(3); // Remove the '_ar' prefix

        if (data.containsKey(newKey) && data[newKey] != null) {
          // If there is a corresponding non-prefixed key and it's not null, use its value
          newData[newKey] = data[key];
        } else {
          // If there's no corresponding non-prefixed key, just add it without the prefix
          newData[newKey] = data[key];
        }
      } else {
        // For keys not starting with '_ar', add them as they are
        newData[key] = data[key];
      }
    }
    return newData;
  }
}
