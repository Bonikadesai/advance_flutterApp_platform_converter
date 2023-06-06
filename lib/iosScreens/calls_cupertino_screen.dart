import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/platform_provider.dart';
import '../providers/theme_provider.dart';
import '../utils/globals.dart';

class CallsCupertinoScreen extends StatefulWidget {
  const CallsCupertinoScreen({Key? key}) : super(key: key);

  @override
  State<CallsCupertinoScreen> createState() => _CallsCupertinoScreenState();
}

class _CallsCupertinoScreenState extends State<CallsCupertinoScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "Platform Converter",
        ),
        leading: Icon(
          CupertinoIcons.home,
        ),
        trailing: CupertinoSwitch(
          value: Provider.of<PlatFormProvider>(context, listen: true).isIos,
          onChanged: (val) {
            Provider.of<PlatFormProvider>(context, listen: false)
                .changePlatform(val);
          },
        ),
      ),
      child: Material(
        child: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: (Provider.of<ThemeProvider>(context).themeModel.isDark)
                ? Colors.black
                : Colors.white,
            child: (Globals.allContact.isNotEmpty)
                ? ListView.builder(
                    itemCount: Globals.allContact.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CupertinoListTile(
                            title: Text("${Globals.allContact[index].name}"),
                            leading: CircleAvatar(
                              radius: 30,
                              foregroundImage:
                                  FileImage(Globals.allContact[index].imgFile),
                            ),
                            subtitle: Text(
                              Globals.allContact[index].phone,
                              style: TextStyle(color: Colors.grey),
                            ),
                            trailing: CupertinoButton(
                                child: Icon(CupertinoIcons.phone),
                                onPressed: () async {
                                  await launchUrl(Uri.parse(
                                      "tel:+91${Globals.allContact[index].phone}"));
                                }),
                          ),
                        ],
                      );
                    },
                  )
                : Center(
                    child: Text("No any chat yet..."),
                  ),
          ),
        ),
      ),
    );
  }
}
