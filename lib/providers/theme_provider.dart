import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modals/theme_modals.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeModel themeModel;
  ThemeProvider({required this.themeModel});
  //ThemeModel themeModel = ThemeModel(isDark: false);

  void changeTheme() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    themeModel.isDark = !themeModel.isDark;
    pref.setBool("isthemeDark", themeModel.isDark);

    notifyListeners();
  }
}
