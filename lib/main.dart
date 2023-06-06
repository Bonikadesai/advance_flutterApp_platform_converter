import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter/providers/platform_provider.dart';
import 'package:platform_converter/providers/theme_provider.dart';
import 'package:platform_converter/screens/chats_material_screen.dart';
import 'package:platform_converter/screens/material_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'iosScreens/cupertino_screen.dart';
import 'modals/theme_modals.dart';

CupertinoThemeData cupertinoLight =
    CupertinoThemeData(brightness: Brightness.light);
CupertinoThemeData cupertinoDark =
    CupertinoThemeData(brightness: Brightness.dark);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool isThemeDark = pref.getBool("isthemeDark") ?? false;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PlatFormProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(
            themeModel: ThemeModel(isDark: isThemeDark),
          ),
        ),
      ],
      child: Consumer<PlatFormProvider>(
        builder: (context, value, _) => (value.isIos == false)
            ? MaterialApp(
                theme: ThemeData(
                  useMaterial3: true,
                ),
                darkTheme: ThemeData(
                  useMaterial3: true,
                  colorScheme: ColorScheme.dark(
                    brightness: Brightness.dark,
                  ),
                ),
                themeMode:
                    (Provider.of<ThemeProvider>(context).themeModel.isDark)
                        ? ThemeMode.dark
                        : ThemeMode.light,
                debugShowCheckedModeBanner: false,
                home: Detail(),
                routes: {
                  'chat_material': (context) => ChatMaterialScreen(),
                  // 'person_detail': (context) => PersonDetail(),
                },
              )
            : CupertinoApp(
                debugShowCheckedModeBanner: false,

                theme: (Provider.of<ThemeProvider>(context).themeModel.isDark)
                    ? cupertinoDark
                    : cupertinoLight,
                //theme: CupertinoThemeData(brightness: Brightness.light),
                home: CupertinoScreen(),
                routes: {},
              ),
      ),
    ),
  );
}
