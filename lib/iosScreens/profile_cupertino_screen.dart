import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_converter/utils/globals.dart';
import 'package:provider/provider.dart';

import '../modals/person.dart';
import '../providers/platform_provider.dart';
import '../providers/theme_provider.dart';

class ProfileCupertinoScreen extends StatefulWidget {
  const ProfileCupertinoScreen({Key? key}) : super(key: key);

  @override
  State<ProfileCupertinoScreen> createState() => _ProfileCupertinoScreenState();
}

class _ProfileCupertinoScreenState extends State<ProfileCupertinoScreen> {
  final GlobalKey<FormState> addInFormKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  File? xfile;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController chatcontroller = TextEditingController();

  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  String name = "";
  String phone = "";
  String chatconversation = "";
  File? imgFile;
  DateTime pickDate = DateTime.now();
  TimeOfDay pickTime = TimeOfDay.now();
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
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: (Provider.of<ThemeProvider>(context).themeModel.isDark)
              ? Colors.black
              : Colors.white,
          child: SingleChildScrollView(
            child: Form(
              key: addInFormKey,
              child: Container(
                //color: CupertinoColors.black,
                child: Column(
                  children: [
                    SizedBox(
                      height: 130,
                    ),
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: CupertinoColors.activeBlue,
                      child: FloatingActionButton(
                        backgroundColor: CupertinoColors.activeBlue,
                        elevation: 0,
                        onPressed: () {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (context) {
                                return CupertinoActionSheet(
                                  title: Text("Pick the Image"),
                                  actions: [
                                    CupertinoActionSheetAction(
                                      onPressed: () async {
                                        ImagePicker picker = ImagePicker();
                                        XFile? xfile = await picker.pickImage(
                                            source: ImageSource.camera);
                                        String path = xfile!.path;
                                        setState(() {
                                          imgFile = File(path);
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "Pick the Camera",
                                      ),
                                    ),
                                    CupertinoActionSheetAction(
                                      onPressed: () async {
                                        ImagePicker picker = ImagePicker();
                                        XFile? xfile = await picker.pickImage(
                                            source: ImageSource.gallery);
                                        String path = xfile!.path;
                                        setState(() {
                                          imgFile = File(path);
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "Pick the Gallery",
                                      ),
                                    ),
                                    CupertinoActionSheetAction(
                                      isDestructiveAction: true,
                                      onPressed: () {
                                        imgFile = null;
                                      },
                                      child: Text(
                                        "Remove the Image",
                                      ),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Icon(
                          CupertinoIcons.camera,
                          size: 30,
                        ),
                      ),
                      foregroundImage:
                          (imgFile == null) ? null : FileImage(imgFile as File),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15, right: 15, left: 15),
                      child: CupertinoTextField(
                        controller: namecontroller,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (val) {
                          name = val!;
                        },
                        keyboardType: TextInputType.name,
                        prefix: Icon(CupertinoIcons.person),
                        placeholder: "Full Name",
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: (Provider.of<ThemeProvider>(context)
                                    .themeModel
                                    .isDark)
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15, right: 15, left: 15),
                      child: CupertinoTextField(
                        controller: phonecontroller,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (val) {
                          phone = val!;
                        },
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        prefix: Icon(CupertinoIcons.phone),
                        placeholder: "Phone Number",
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: (Provider.of<ThemeProvider>(context)
                                    .themeModel
                                    .isDark)
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15, right: 15, left: 15),
                      child: CupertinoTextField(
                        controller: chatcontroller,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (val) {
                          chatconversation = val!;
                        },
                        keyboardType: TextInputType.name,
                        prefix: Icon(CupertinoIcons.chat_bubble_text),
                        placeholder: "Chate Conversation",
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: (Provider.of<ThemeProvider>(context)
                                    .themeModel
                                    .isDark)
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return CupertinoActionSheet(
                                    message: Container(
                                      height: 200,
                                      color: Colors.transparent,
                                      child: CupertinoDatePicker(
                                        onDateTimeChanged: (DateTime date) {
                                          Provider.of<PlatFormProvider>(context,
                                                  listen: false)
                                              .pickDate(date);
                                        },
                                        initialDateTime:
                                            Provider.of<PlatFormProvider>(
                                                    context,
                                                    listen: true)
                                                .initialDate,
                                        mode: CupertinoDatePickerMode.date,
                                      ),
                                    ),
                                  );
                                });
                          },
                          icon: Icon(
                            CupertinoIcons.calendar,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${Provider.of<PlatFormProvider>(context).initialDate.day.toString()}/"
                          "${Provider.of<PlatFormProvider>(context).initialDate.month.toString()}/"
                          "${Provider.of<PlatFormProvider>(context).initialDate.year.toString()}",
                          style: TextStyle(
                            color: (Provider.of<ThemeProvider>(context)
                                    .themeModel
                                    .isDark)
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return CupertinoActionSheet(
                                    message: Container(
                                      height: 200,
                                      color: Colors.transparent,
                                      child: CupertinoDatePicker(
                                        onDateTimeChanged: (DateTime date) {
                                          Provider.of<PlatFormProvider>(context,
                                                  listen: false)
                                              .pickDate(date);
                                        },
                                        initialDateTime:
                                            Provider.of<PlatFormProvider>(
                                                    context,
                                                    listen: true)
                                                .initialDate,
                                        mode: CupertinoDatePickerMode.time,
                                      ),
                                    ),
                                  );
                                });
                          },
                          icon: Icon(
                            CupertinoIcons.time,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${Provider.of<PlatFormProvider>(context).initialTime.hour}"
                          " : ${Provider.of<PlatFormProvider>(context).initialTime.minute}",
                          style: TextStyle(
                            color: (Provider.of<ThemeProvider>(context)
                                    .themeModel
                                    .isDark)
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    CupertinoButton(
                      child: Text("SAVE"),
                      onPressed: () {
                        if (addInFormKey.currentState!.validate()) {
                          addInFormKey.currentState!.save();
                          Person p1 = Person(
                              name: name,
                              phone: phone,
                              chat: chatconversation,
                              imgFile: imgFile!,
                              pickDate: pickDate,
                              pickTime: pickTime);
                          Globals.allContact.add(p1);
                          addInFormKey.currentState!.reset();
                          namecontroller.text = "";
                          phonecontroller.text = "";
                          chatcontroller.text = "";
                          imgFile = null;
                        }
                        print(name);
                        print(phone);
                        print(chatconversation);
                        print(imgFile);
                        print(pickDate);
                        print(pickTime);
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
