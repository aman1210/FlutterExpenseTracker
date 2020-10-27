import 'package:flutter/foundation.dart';

class ProfileProvider with ChangeNotifier {
  bool isDark = false;

  toggleDark() {
    isDark = !isDark;
    notifyListeners();
  }
}
