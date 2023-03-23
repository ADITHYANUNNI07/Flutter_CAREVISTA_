import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:carevista_ver05/Helper/helper_function.dart';
import 'package:carevista_ver05/SCREEN/dashboard.dart';
import 'package:carevista_ver05/SCREEN/home/favorites.dart';
import 'package:carevista_ver05/SCREEN/profile.dart';
import 'package:carevista_ver05/SCREEN/send_otp.dart';
import 'package:carevista_ver05/Service/database_service.dart';
import 'package:carevista_ver05/main.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class PatientRecord extends StatefulWidget {
  const PatientRecord({super.key});

  @override
  State<PatientRecord> createState() => _PatientRecordState();
}

final fromKey = GlobalKey<FormState>();
String Fname = "";
String Fremark = "";
String uid = '';
String userName = "";
String email = "";
String phoneNo = "";
bool createfolder = false;

class _PatientRecordState extends State<PatientRecord> {
  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    gettingUserData();
  }

  gettingUserData() async {
    await HelperFunction.getUserUIDFromSF().then((value) {
      setState(() {
        uid = value!;
        print(uid);
      });
    });
    await HelperFunction.getUserNameFromSF().then((value) {
      setState(() {
        userName = value!;
      });
    });
    await HelperFunction.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunction.getUserPhoneFromSF().then((value) {
      setState(
        () {
          phoneNo = value!;
        },
      );
    });
  }

  Widget build(BuildContext context) {
    int selsctedIconIndex = 0;
    return Container(
      color: const Color(0xFF04FBC3),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              LineAwesomeIcons.angle_double_left,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Patient Record',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'brandon_H',
                color: Theme.of(context).primaryColorDark),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    createfolder = true;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  height: createfolder == false ? 49 : 400,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Color(0XFF407BFF),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Add New Folder',
                            style: TextStyle(color: Colors.white),
                          ),
                          Expanded(child: Container()),
                          IconButton(
                              onPressed: () {
                                if (createfolder == false) {
                                  setState(() {
                                    createfolder = true;
                                  });
                                } else {
                                  setState(() {
                                    createfolder = false;
                                  });
                                }
                              },
                              icon: createfolder == false
                                  ? const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    )
                                  : const Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ))
                        ],
                      ),
                      createfolder == true
                          ? Container(
                              padding: const EdgeInsets.all(34),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10))),
                              child: Form(
                                key: fromKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Text('Enter New Folder Name and Remark',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2),
                                    const SizedBox(height: 20),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                          prefixIcon:
                                              Icon(Icons.folder_outlined),
                                          labelText: 'Folder Name',
                                          border: OutlineInputBorder()),
                                      onChanged: (val) {
                                        Fname = val;
                                      },
                                      // check tha validation
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "Please Enter Folder Name";
                                        }
                                      },
                                    ),
                                    const SizedBox(height: 15),
                                    TextFormField(
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(LineAwesomeIcons.pen),
                                        labelText: 'Remark',
                                        border: OutlineInputBorder(),
                                      ),
                                      onChanged: (val) {
                                        Fremark = val;
                                      },
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "Please Enter Remark";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(height: 15),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 13),
                                            foregroundColor: Colors.white,
                                            backgroundColor:
                                                const Color(0XFF407BFF),
                                          ),
                                          onPressed: () {
                                            createFolder();
                                          },
                                          child: const Text(
                                            'CREATE',
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          index: selsctedIconIndex,
          buttonBackgroundColor: const Color(0XFF407BFF),
          height: 60.0,
          color: Theme.of(context).canvasColor,
          onTap: (index) {
            setState(() {
              selsctedIconIndex = index;
            });
          },
          animationDuration: const Duration(
            milliseconds: 200,
          ),
          items: <Widget>[
            Icon(
              Icons.library_books_outlined,
              size: 30,
              color: selsctedIconIndex == 0
                  ? Colors.white
                  : MyApp.themeNotifier.value == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
            ),
            Icon(
              Icons.search,
              size: 30,
              color: selsctedIconIndex == 1
                  ? Colors.white
                  : MyApp.themeNotifier.value == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
            ),
            IconButton(
              onPressed: () {
                nextScreenReplace(context, Dashboard());
              },
              icon: const Icon(Icons.home_outlined, size: 30),
              color: selsctedIconIndex == 2
                  ? Colors.white
                  : MyApp.themeNotifier.value == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
            ),
            IconButton(
              onPressed: () {
                nextScreenReplace(context, Favorites());
              },
              icon: const Icon(Icons.favorite_border_outlined, size: 30),
              color: selsctedIconIndex == 3
                  ? Colors.white
                  : MyApp.themeNotifier.value == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
            ),
            IconButton(
              onPressed: () {
                nextScreenReplace(
                    context,
                    ProfilePage(
                        phoneNo: phoneNo, email: email, userName: userName));
              },
              icon: const Icon(Icons.person_outline, size: 30),
              color: selsctedIconIndex == 4
                  ? Colors.white
                  : MyApp.themeNotifier.value == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  createFolder() async {
    if (fromKey.currentState!.validate()) {
      await DatabaseService(uid: uid).folderDB(Fname, Fremark);
      // ignore: use_build_context_synchronously
      newshowSnackbar(context, 'Add New Folder',
          'create new folder successfully :)', ContentType.success);
      setState(() {
        createfolder = false;
      });
    }
  }
}
