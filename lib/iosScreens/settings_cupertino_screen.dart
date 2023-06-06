import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../modals/person.dart';
import '../providers/platform_provider.dart';
import '../providers/theme_provider.dart';

class SettingsCupertinoScreen extends StatefulWidget {
  const SettingsCupertinoScreen({Key? key}) : super(key: key);

  @override
  State<SettingsCupertinoScreen> createState() =>
      _SettingsCupertinoScreenState();
}

class _SettingsCupertinoScreenState extends State<SettingsCupertinoScreen> {
  final GlobalKey<FormState> addInFormKey = GlobalKey<FormState>();
  File? imgFile;
  TextEditingController profilenamecontroller = TextEditingController();
  TextEditingController biocontroller = TextEditingController();
  String profilename = "";
  String bio = "";
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
          height: double.infinity,
          width: double.infinity,
          color: (Provider.of<ThemeProvider>(context).themeModel.isDark)
              ? Colors.black
              : Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(
                      Icons.person,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Profile",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: (Provider.of<ThemeProvider>(context)
                                    .themeModel
                                    .isDark)
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        Text(
                          "Update Profile Data",
                          style: TextStyle(
                            color: (Provider.of<ThemeProvider>(context)
                                    .themeModel
                                    .isDark)
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    CupertinoSwitch(
                        value:
                            Provider.of<PlatFormProvider>(context, listen: true)
                                .isProfile,
                        onChanged: (val) {
                          Provider.of<PlatFormProvider>(context, listen: false)
                              .changeProfile(val);
                        }),
                  ],
                ),
              ),
              (Provider.of<PlatFormProvider>(context).isProfile != false)
                  ? Column(
                      children: [
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
                                            XFile? xfile =
                                                await picker.pickImage(
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
                                            XFile? xfile =
                                                await picker.pickImage(
                                                    source:
                                                        ImageSource.gallery);
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
                          foregroundImage: (imgFile == null)
                              ? null
                              : FileImage(imgFile as File),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15, right: 15, left: 15),
                          child: CupertinoTextField(
                            controller: profilenamecontroller,
                            textInputAction: TextInputAction.next,
                            onSubmitted: (val) {
                              profilename = val!;
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
                          padding: const EdgeInsets.only(
                              top: 15, right: 15, left: 15),
                          child: CupertinoTextField(
                            controller: biocontroller,
                            textInputAction: TextInputAction.next,
                            onSubmitted: (val) {
                              bio = val!;
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
                          padding: const EdgeInsets.only(left: 120),
                          child: Row(
                            children: [
                              CupertinoButton(
                                child: Text(
                                  "SAVE",
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onPressed: () {
                                  if (addInFormKey.currentState!.validate()) {
                                    addInFormKey.currentState!.save();
                                    Profile p1 = Profile(
                                        name: profilename,
                                        bio: bio,
                                        imgFile: imgFile!);
                                  }
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              CupertinoButton(
                                child: Text(
                                  "CANCLE",
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  addInFormKey.currentState!.reset();
                                  profilenamecontroller.text = "";
                                  biocontroller.text = "";
                                  imgFile = null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Container(),
              Divider(
                thickness: 2,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(
                      CupertinoIcons.brightness,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Theme",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: (Provider.of<ThemeProvider>(context)
                                    .themeModel
                                    .isDark)
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        Text(
                          "Change Theme",
                          style: TextStyle(
                            color: (Provider.of<ThemeProvider>(context)
                                    .themeModel
                                    .isDark)
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    CupertinoSwitch(
                        value: Provider.of<ThemeProvider>(context, listen: true)
                            .themeModel
                            .isDark,
                        onChanged: (val) {
                          Provider.of<ThemeProvider>(context, listen: false)
                              .changeTheme();
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
