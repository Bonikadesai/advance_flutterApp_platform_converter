import 'package:flutter/material.dart';

class PlatFormProvider extends ChangeNotifier {
  bool isIos = true;
  bool isProfile = true;
  DateTime initialDate = DateTime.now();
  TimeOfDay initialTime = TimeOfDay.now();
  int select = 0;
  //ThemeModel themeModel = ThemeModel(isDark: false);
  // ThemeModel themeModel;
  // ThemeProvider({required this.themeModel});

  void changePlatform(bool n) {
    isIos = n;
    notifyListeners();
  }

  void pickDate(DateTime n) {
    initialDate = n;
    notifyListeners();
  }

  void pickTime(TimeOfDay n) {
    initialTime = n;
    notifyListeners();
  }

  void selectColor(int n) {
    select = n;
    notifyListeners();
  }

  void changeProfile(bool n) {
    isProfile = n;
    notifyListeners();
  }

  // void changeTheme() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   themeModel.isDark = !themeModel.isDark;
  //   pref.setBool("isthemeDark", themeModel.isDark);
  //
  //   notifyListeners();
  // }
}
