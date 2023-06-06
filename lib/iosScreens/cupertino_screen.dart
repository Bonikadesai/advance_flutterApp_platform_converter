import 'package:flutter/cupertino.dart';
import 'package:platform_converter/iosScreens/profile_cupertino_screen.dart';
import 'package:platform_converter/iosScreens/settings_cupertino_screen.dart';
import 'package:platform_converter/providers/platform_provider.dart';
import 'package:provider/provider.dart';

import 'calls_cupertino_screen.dart';
import 'chats_cupertino_screen.dart';

class CupertinoScreen extends StatefulWidget {
  const CupertinoScreen({Key? key}) : super(key: key);

  @override
  State<CupertinoScreen> createState() => _CupertinoScreenState();
}

class _CupertinoScreenState extends State<CupertinoScreen> {
  List<Widget> pages = [
    ProfileCupertinoScreen(),
    ChatsCupertinoScreen(),
    CallsCupertinoScreen(),
    SettingsCupertinoScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: Provider.of<PlatFormProvider>(context).select,
        onTap: (val) {
          Provider.of<PlatFormProvider>(context, listen: false)
              .selectColor(val);
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.person_add,
              ),
              label: "Profile"),
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.chat_bubble_text,
              ),
              label: "Chats"),
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.phone,
              ),
              label: "Calls"),
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.settings,
              ),
              label: "Settings"),
        ],
      ),
      tabBuilder: (context, index) => CupertinoTabView(builder: (BuildContext) {
        return pages[index];
      }),
    );
  }
}
