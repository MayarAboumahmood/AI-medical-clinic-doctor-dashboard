import 'package:shared_preferences/shared_preferences.dart';

import '../injection/app_injection.dart';

class PrefService {
  Future createString(String key, String value) async {
    SharedPreferences pref = sl<SharedPreferences>();
    pref.setString(key, value);
  }

  Future<String> readString(String key) async {
    SharedPreferences pref = sl<SharedPreferences>();String cache = pref.getString(key) ?? '';
    return cache;
  }

  Future<void> remove(String key) async {
    SharedPreferences pref = sl<SharedPreferences>(); pref.remove(key);
  }

  Future<bool> isContainKey(String key) async {
    SharedPreferences pref = sl<SharedPreferences>();
    return pref.containsKey(key);
  }
}
