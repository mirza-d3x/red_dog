
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getValue(dynamic key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key) ?? '';
}

Future<bool> setValue(dynamic key, dynamic value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString(key, value);
}

Future<bool> deleteValue(dynamic key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.remove(key);
}




