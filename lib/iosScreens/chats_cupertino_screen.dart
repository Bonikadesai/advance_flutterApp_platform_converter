import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/platform_provider.dart';
import '../providers/theme_provider.dart';
import '../utils/globals.dart';

class ChatsCupertinoScreen extends StatefulWidget {
  const ChatsCupertinoScreen({Key? key}) : super(key: key);

  @override
  State<ChatsCupertinoScreen> createState() => _ChatsCupertinoScreenState();
}

class _ChatsCupertinoScreenState extends State<ChatsCupertinoScreen> {
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
            height: double.infinity,
            color: (Provider.of<ThemeProvider>(context).themeModel.isDark)
                ? Colors.black
                : Colors.white,
            width: double.infinity,
            child: (Globals.allContact.isNotEmpty)
                ? ListView.builder(
                    itemCount: Globals.allContact.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CupertinoListTile(
                            onTap: () {
                              showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoActionSheet(
                                      actions: [
                                        Container(
                                          height: 300,
                                          width: double.infinity,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              CircleAvatar(
                                                foregroundImage: (Globals
                                                            .allContact[index]
                                                            .imgFile !=
                                                        null)
                                                    ? FileImage(Globals
                                                        .allContact[index]
                                                        .imgFile)
                                                    : null,
                                                radius: 60,
                                                child: (Globals
                                                            .allContact[index]
                                                            .imgFile !=
                                                        null)
                                                    ? Text("")
                                                    : Icon(Icons.person),
                                                backgroundColor:
                                                    Colors.grey.shade400,
                                              ),
                                              Text(
                                                Globals.allContact[index].name,
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              Text(
                                                Globals.allContact[index].chat,
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CupertinoButton(
                                                      child: Icon(CupertinoIcons
                                                          .pencil),
                                                      onPressed: () {}),
                                                  CupertinoButton(
                                                      child: Icon(CupertinoIcons
                                                          .delete),
                                                      onPressed: () {
                                                        Globals.allContact
                                                            .remove(Globals
                                                                    .allContact[
                                                                index]);
                                                        Navigator.of(context)
                                                            .pop();
                                                      }),
                                                ],
                                              ),
                                              CupertinoButton(
                                                  child: Text("Cancle"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  }),
                                            ],
                                          ),
                                        )
                                        // CupertinoActionSheetAction(
                                        //     onPressed: () {},
                                        //     child: Text("Edit Page"))
                                      ],
                                    );
                                  });
                            },
                            title: Text("${Globals.allContact[index].name}"),
                            leading: CircleAvatar(
                              radius: 30,
                              foregroundImage:
                                  FileImage(Globals.allContact[index].imgFile),
                            ),
                            subtitle: Text(
                              Globals.allContact[index].chat,
                              style: TextStyle(color: Colors.grey),
                            ),
                            trailing: Text(
                                "${Globals.allContact[index].pickDate.day}/${Globals.allContact[index].pickDate.month}/${Globals.allContact[index].pickDate.year}"),
                          ),
                        ],
                      );
                    },
                  )
                : Center(
                    child: Text("No any chat yet..."),
                  ),
          ),
          // child: Column(
          //   children: [
          //     SizedBox(
          //       height: 70,
          //     ),
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: [
          //         CupertinoButton(
          //             child: Icon(CupertinoIcons.person_add), onPressed: () {}),
          //         GestureDetector(
          //           child: Text(
          //             "CHATS",
          //           ),
          //         ),
          //         Text(
          //           "CALLS",
          //         ),
          //         Text(
          //           "SETTINGS",
          //         ),
          //       ],
          //     ),
          //     Divider(
          //       thickness: 2,
          //     ),
          //     SizedBox(
          //       height: 300,
          //     ),
          //     Text(
          //       "No any chats yet..",
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
