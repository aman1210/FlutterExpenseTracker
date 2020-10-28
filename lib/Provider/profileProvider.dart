import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider with ChangeNotifier {
  bool isDark = false;
  var path = '';
  var name = '';
  var number = '';
  var email = '';
  var address = '';

  void addProfile(String path2, String name2, String number2, String email2,
      String address2) {
    path = path2;
    name = name2;
    email = email2;
    address = address2;
    number = number2;
    saveProfile();
  }

  ProfileProvider() {
    starting();
    initProfile();
  }

  toggleDark() {
    isDark = !isDark;
    notifyListeners();
    saveTheme();
  }

  Future<void> initProfile() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final userData = json.decode(prefs.getString('userData'));
    path = userData['path'];
    name = userData['name'];
    email = userData['email'];
    number = userData['number'];
    address = userData['address'];
    notifyListeners();
    return true;
  }

  Future<void> saveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    var userData = json.encode(
      {
        'path': path,
        'name': name,
        'number': number,
        'email': email,
        'address': address,
      },
    );
    prefs.setString('userData', userData);
  }

  Future<void> starting() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('isDark')) {
      return false;
    }
    isDark = prefs.getBool('isDark');
    notifyListeners();
  }

  Future<void> saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', isDark);
  }
}
