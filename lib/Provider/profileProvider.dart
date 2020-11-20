import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider with ChangeNotifier {
  bool isDark = false;
  bool showNoti = false;
  var time = '';
  var path = '';
  var name = '';
  var number = '';
  var email = '';
  var address = '';
  var currency = '₹';

  void addProfile(String path2, String name2, String number2, String email2,
      String address2) {
    path = path2;
    name = name2;
    email = email2;
    address = address2;
    number = number2;
    saveProfile();
    notifyListeners();
  }

  ProfileProvider() {
    starting();
    getCurrency();
    initProfile();
    startNoti();
  }

  toggleDark() {
    isDark = !isDark;
    notifyListeners();
    saveTheme();
  }

  toggleNoti(String newTime) {
    showNoti = !showNoti;
    time = newTime;
    saveNoti();
  }

  changeCurreny(String symbol) {
    currency = symbol;
    notifyListeners();
    saveCurrency();
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

  Future<void> saveNoti() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('showNoti', showNoti);
    prefs.setString('time', time);
  }

  Future<void> startNoti() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('showNoti')) {
      return false;
    }
    showNoti = prefs.getBool('showNoti');
    time = prefs.getString('time');
  }

  Future<void> saveCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('currency', currency);
  }

  Future<void> getCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('currency')) {
      return false;
    }
    currency = prefs.getString('currency');
    notifyListeners();
  }
}
