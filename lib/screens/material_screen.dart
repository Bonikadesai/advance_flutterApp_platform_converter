import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_converter/modals/person.dart';
import 'package:platform_converter/providers/platform_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/theme_provider.dart';
import '../utils/globals.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  int initialIndex = 0;
  final GlobalKey<FormState> addInFormKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  File? xfile;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController chatcontroller = TextEditingController();
  TextEditingController profilenamecontroller = TextEditingController();
  TextEditingController biocontroller = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  String bio = "";
  String name = "";
  String phone = "";
  String chatconversation = "";
  File? imgFile;
  DateTime pickDate = DateTime.now();
  TimeOfDay pickTime = TimeOfDay.now();
  PageController pageController = PageController();
  String chet = "CHATS";
  String call = "CALLS";
  String settings = "SETTINGS";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        title: const Text(
          "Platform Converter",
        ),
        leading: const Icon(
          Icons.home,
        ),
        actions: [
          Switch(
              value: Provider.of<PlatFormProvider>(context, listen: true).isIos,
              onChanged: (val) {
                Provider.of<PlatFormProvider>(context, listen: false)
                    .changePlatform(val);
              }),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
      
        currentIndex: initialIndex,
        //currentIndex: Provider.of<PlatFormProvider>(context).select,
        onTap: (val) {
          Provider.of<PlatFormProvider>(context, listen: false)
              .selectColor(val);
          pageController.animateToPage(val,
              duration: Duration(milliseconds: 400), curve: Curves.bounceIn);
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_add_outlined,
            ),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              // color: Colors.black,
            ),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.call_outlined,
            ),
            label: "Calls",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: "Settings",
          ),
        ],
      ),
      body: Form(
        key: addInFormKey,
        child: PageView(
          controller: pageController,
          onPageChanged: (val) {
            setState(() {
              initialIndex = val;
            });
          },
          children: [
            //profile
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  CircleAvatar(
                    radius: 60,
                    child: FloatingActionButton(
                      elevation: 0,
                      onPressed: () async {
                        scaffoldkey.currentState!.showBottomSheet(
                          (context) => Container(
                            height: 200,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text("Pick the Camera"),
                                  onTap: () async {
                                    ImagePicker picker = ImagePicker();
                                    XFile? xfile = await picker.pickImage(
                                        source: ImageSource.camera);
                                    String path = xfile!.path;
                                    setState(() {
                                      imgFile = File(path);
                                    });
                                    Navigator.of(context).pop();
                                  },
                                ),
                                ListTile(
                                  title: Text("Pick the Gallery"),
                                  onTap: () async {
                                    ImagePicker picker = ImagePicker();
                                    XFile? xfile = await picker.pickImage(
                                        source: ImageSource.gallery);
                                    String path = xfile!.path;
                                    setState(() {
                                      imgFile = File(path);
                                    });
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.camera_alt_outlined,
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
                        const EdgeInsets.only(top: 12, right: 12, left: 12),
                    child: TextFormField(
                      controller: namecontroller,
                      textInputAction: TextInputAction.next,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter the Name";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        name = val!;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Full Name ",
                        prefixIcon: Icon(
                          Icons.person_2_outlined,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 12, right: 12, left: 12),
                    child: TextFormField(
                      controller: phonecontroller,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter the Phone number";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        phone = val!;
                      },
                      //maxLength: 10,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Phone Number ",
                        prefixIcon: Icon(
                          Icons.call,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 12, right: 12, left: 12),
                    child: TextFormField(
                      controller: chatcontroller,
                      textInputAction: TextInputAction.done,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter the chat";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        chatconversation = val!;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Chat Conversation ",
                        prefixIcon: Icon(
                          Icons.chat,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2050),
                          );
                        },
                        icon: Icon(
                          Icons.date_range_outlined,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                          "${Provider.of<PlatFormProvider>(context).initialDate.day.toString()}/"
                          "${Provider.of<PlatFormProvider>(context).initialDate.month.toString()}/"
                          "${Provider.of<PlatFormProvider>(context).initialDate.year.toString()}")
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: Provider.of<PlatFormProvider>(context,
                                    listen: false)
                                .initialTime,
                          );
                          Provider.of<PlatFormProvider>(context, listen: false)
                              .pickTime(pickedTime!);
                        },
                        icon: Icon(
                          Icons.watch_later_outlined,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${Provider.of<PlatFormProvider>(context).initialTime.hour}"
                        " : ${Provider.of<PlatFormProvider>(context).initialTime.minute}",
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.of(context).pushNamed('chat_material');
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
                    },
                    child: Text(
                      "SAVE",
                    ),
                  ),
                ],
              ),
            ),
            // chats
            Container(
              child: (Globals.allContact.isNotEmpty)
                  ? ListView.builder(
                      itemCount: Globals.allContact.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: 300,
                                  width: 400,
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
                                                .allContact[index].imgFile)
                                            : null,
                                        radius: 60,
                                        child: (Globals.allContact[index]
                                                    .imgFile !=
                                                null)
                                            ? Text("")
                                            : Icon(Icons.person),
                                        backgroundColor: Colors.grey.shade400,
                                      ),
                                      Text(
                                        Globals.allContact[index].name,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        Globals.allContact[index].chat,
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.edit),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Globals.allContact.remove(
                                                  Globals.allContact[index]);
                                              Navigator.of(context).pop();
                                              setState(() {});
                                            },
                                            icon: Icon(Icons.delete),
                                          ),
                                        ],
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Cancel"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          leading: CircleAvatar(
                            radius: 30,
                            foregroundImage:
                                FileImage(Globals.allContact[index].imgFile),
                          ),
                          title: Text("${Globals.allContact[index].name}"),
                          subtitle: Text(
                            Globals.allContact[index].chat,
                            style: TextStyle(color: Colors.grey),
                          ),
                          trailing: Text(
                              "${Globals.allContact[index].pickDate.day}/${Globals.allContact[index].pickDate.month}/${Globals.allContact[index].pickDate.year}"),
                        );
                      },
                    )
                  : Center(
                      child: Text("No any chat yet..."),
                    ),
            ),
            //calls
            Container(
                child: (Globals.allContact.isNotEmpty)
                    ? ListView.builder(
                        itemCount: Globals.allContact.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {},
                            leading: CircleAvatar(
                              radius: 30,
                              foregroundImage:
                                  FileImage(Globals.allContact[index].imgFile),
                            ),
                            title: Text("${Globals.allContact[index].name}"),
                            subtitle: Text(
                              "+91 ${Globals.allContact[index].phone}",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            trailing: IconButton(
                                icon: Icon(
                                  Icons.phone,
                                  color: Colors.green,
                                ),
                                onPressed: () async {
                                  await launchUrl(Uri.parse(
                                      "tel:+91${Globals.allContact[index].phone}"));
                                }),
                          );
                        })
                    : Center(
                        child: Text("No any Calls Yet..."),
                      )),
            //settings
            Column(
              children: [
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Update Profile Data",
                          ),
                        ],
                      ),
                      Spacer(),
                      // SizedBox(
                      //   width: 120,
                      // ),
                      Switch(
                          value: Provider.of<PlatFormProvider>(context,
                                  listen: true)
                              .isProfile,
                          onChanged: (val) {
                            Provider.of<PlatFormProvider>(context,
                                    listen: false)
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
                            child: FloatingActionButton(
                              elevation: 0,
                              onPressed: () async {
                                scaffoldkey.currentState!.showBottomSheet(
                                  (context) => Container(
                                    height: 200,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Text("Pick the Camera"),
                                          onTap: () async {
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
                                        ),
                                        ListTile(
                                          title: Text("Pick the Gallery"),
                                          onTap: () async {
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
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 30,
                              ),
                            ),
                            foregroundImage: (imgFile == null)
                                ? null
                                : FileImage(imgFile as File),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 130,
                            ),
                            child: TextFormField(
                              controller: profilenamecontroller,
                              textInputAction: TextInputAction.next,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Enter the chat";
                                }
                                return null;
                              },
                              onSaved: (val) {
                                name = val!;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter your Name... ",
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 130,
                            ),
                            child: TextFormField(
                              controller: biocontroller,
                              textInputAction: TextInputAction.done,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Enter the bio";
                                }
                                return null;
                              },
                              onSaved: (val) {
                                bio = val!;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter your Bio... ",
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 120),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (addInFormKey.currentState!.validate()) {
                                      addInFormKey.currentState!.save();
                                      Profile p1 = Profile(
                                          name: name,
                                          bio: bio,
                                          imgFile: imgFile!);
                                    }
                                  },
                                  icon: Text(
                                    "SAVE ",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    addInFormKey.currentState!.reset();
                                    profilenamecontroller.text = "";
                                    biocontroller.text = "";
                                    imgFile = null;
                                  },
                                  icon: Text(
                                    "CANCLE ",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.wb_sunny_outlined,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Theme",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Change Theme",
                          ),
                        ],
                      ),
                      Spacer(),
                      Switch(
                          value:
                              Provider.of<ThemeProvider>(context, listen: true)
                                  .themeModel
                                  .isDark,
                          onChanged: (val) {
                            Provider.of<ThemeProvider>(context, listen: false)
                                .changeTheme();
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
