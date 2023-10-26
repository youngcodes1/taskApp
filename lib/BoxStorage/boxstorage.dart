import 'package:shared_preferences/shared_preferences.dart';

class BoxStorage {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setString(String key, String value) async {
    if (_prefs != null) {
      await _prefs!.setString(key, value);
    }
  }

  static String getString(String key, {String defaultValue = ''}) {
    return _prefs?.getString(key) ?? defaultValue;
  }

  static Future<void> remove(String key) async {
    if (_prefs != null) {
      await _prefs!.remove(key);
    }
  }

  static Future<void> clear() async {
    if (_prefs != null) {
      await _prefs!.clear();
    }
  }
}
