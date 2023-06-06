import 'package:flutter/material.dart';

import '../utils/globals.dart';

class ChatMaterialScreen extends StatefulWidget {
  const ChatMaterialScreen({Key? key}) : super(key: key);

  @override
  State<ChatMaterialScreen> createState() => _ChatMaterialScreenState();
}

class _ChatMaterialScreenState extends State<ChatMaterialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (Globals.allContact.isNotEmpty)
          ? ListView.builder(
              padding: EdgeInsets.all(16),
              physics: BouncingScrollPhysics(),
              itemCount: Globals.allContact.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    foregroundImage:
                        FileImage(Globals.allContact[index].imgFile),
                  ),
                  title: Text("${Globals.allContact[index].name}"),
                  subtitle: Text("${Globals.allContact[index].chat}"),
                  trailing: Text("${Globals.allContact[index].pickTime}"),
                );
              })
          : Center(
              child: Text("No any Chats yet..."),
            ),
    );
  }
}
