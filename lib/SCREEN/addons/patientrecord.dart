import 'dart:io';
import 'package:carevista_ver05/SCREEN/home/search.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:carevista_ver05/Helper/helper_function.dart';
import 'package:carevista_ver05/SCREEN/addons/recorddetails.dart';
import 'package:carevista_ver05/SCREEN/dashboard.dart';
import 'package:carevista_ver05/SCREEN/home/favorites.dart';
import 'package:carevista_ver05/SCREEN/profile.dart';
import 'package:carevista_ver05/Service/database_service.dart';
import 'package:carevista_ver05/main.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'color.dart' as specialcolor;

class PatientRecord extends StatefulWidget {
  const PatientRecord({super.key});
  @override
  State<PatientRecord> createState() => _PatientRecordState();
}

final fromKey = GlobalKey<FormState>();
// ignore: non_constant_identifier_names
String Fname = "";
// ignore: non_constant_identifier_names
String Fremark = "";
String uid = '';
String userName = "";
String email = "";
String phoneNo = "";
bool createfolder = false;
bool menubool = false;

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

  // ignore: non_constant_identifier_names
  final Uid = FirebaseAuth.instance.currentUser?.uid ?? '';

  late File pdfFile;
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
        body: SingleChildScrollView(
          child: Container(
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
                                decoration: BoxDecoration(
                                    color: MyApp.themeNotifier.value ==
                                            ThemeMode.light
                                        ? Colors.white
                                        : Colors.black.withOpacity(1),
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10))),
                                child: Form(
                                  key: fromKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        decoration: const InputDecoration(
                                          prefixIcon:
                                              Icon(LineAwesomeIcons.pen),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                            : Container(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 8000,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(Uid)
                        .collection('PatientRecord')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const Text('Loading...');
                        default:
                          return ListView(
                            //shrinkWrap: false,
                            //scrollDirection: Axis.vertical,
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data() as Map<String, dynamic>;
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 318,
                                        height: menubool == false ? 110 : 190,
                                        child: GestureDetector(
                                          onTap: () {
                                            nextScreen(
                                                context,
                                                RecordDetails(
                                                  folderName:
                                                      data['FolderName'] ?? '',
                                                  date: data['Date'] ?? '',
                                                  folderCreatedate:
                                                      data['UpdateDate'] ?? '',
                                                  imageNo:
                                                      data['ImageNo'] ?? '',
                                                  pdfNo: data['PDFNo'] ?? '',
                                                  remark: data['Remark'] ?? '',
                                                  fileurl1: data['File2'] ?? '',
                                                  fileurl2: data['File3'] ?? '',
                                                  fileurl3: data['File4'] ?? '',
                                                  fileurl4: data['File5'] ?? '',
                                                  fileurl5: data['File6'] ?? '',
                                                  fileurl6: data['File7'] ?? '',
                                                  fileurl7: data['File8'] ?? '',
                                                  fileurl8: data['File9'] ?? '',
                                                  fileurl9:
                                                      data['File10'] ?? '',
                                                  fileurl10:
                                                      data['File11'] ?? '',
                                                ));
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 30, right: 10, top: 5),
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    colors: [
                                                      specialcolor.AppColor
                                                          .gradientFirst
                                                          .withOpacity(0.9),
                                                      specialcolor.AppColor
                                                          .gradientSecond
                                                          .withOpacity(0.9)
                                                    ],
                                                    begin: Alignment.bottomLeft,
                                                    end: Alignment.centerRight),
                                                color: const Color(0XFF407BFF),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(
                                                                10))),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                          data['FolderName'] ??
                                                              '',
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 27,
                                                                  color: Colors
                                                                      .white)),
                                                      Expanded(
                                                          child: Container()),
                                                      IconButton(
                                                          onPressed: () {
                                                            if (menubool ==
                                                                false) {
                                                              setState(() {
                                                                menubool = true;
                                                              });
                                                            } else {
                                                              setState(() {
                                                                menubool =
                                                                    false;
                                                              });
                                                            }
                                                          },
                                                          icon: menubool ==
                                                                  false
                                                              ? const Icon(
                                                                  Icons.menu,
                                                                  color: Colors
                                                                      .white,
                                                                )
                                                              : const Icon(
                                                                  Icons
                                                                      .menu_open,
                                                                  color: Colors
                                                                      .white,
                                                                ))
                                                    ],
                                                  ),
                                                  const SizedBox(height: 7),
                                                  Text(data['Remark'] ?? '',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15,
                                                          color: Colors.white)),
                                                  const SizedBox(height: 7),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: Container()),
                                                      Text(data['Date'] ?? '',
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  fontSize: 10,
                                                                  color: Colors
                                                                      .white)),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  menubool == false
                                                      ? Container()
                                                      : Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10,
                                                                  right: 10),
                                                          height: 50,
                                                          width:
                                                              double.infinity,
                                                          decoration: const BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius: BorderRadius.only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10))),
                                                          child: Row(
                                                            children: [
                                                              IconButton(
                                                                onPressed: () {
                                                                  nextScreen(
                                                                      context,
                                                                      RecordDetails(
                                                                        folderName:
                                                                            data['FolderName'] ??
                                                                                '',
                                                                        date: data['Date'] ??
                                                                            '',
                                                                        folderCreatedate:
                                                                            data['UpdateDate'] ??
                                                                                '',
                                                                        imageNo:
                                                                            data['ImageNo'] ??
                                                                                '',
                                                                        pdfNo: data['PDFNo'] ??
                                                                            '',
                                                                        remark:
                                                                            data['Remark'] ??
                                                                                '',
                                                                        fileurl1:
                                                                            data['File2'] ??
                                                                                '',
                                                                        fileurl2:
                                                                            data['File3'] ??
                                                                                '',
                                                                        fileurl3:
                                                                            data['File4'] ??
                                                                                '',
                                                                        fileurl4:
                                                                            data['File5'] ??
                                                                                '',
                                                                        fileurl5:
                                                                            data['File6'] ??
                                                                                '',
                                                                        fileurl6:
                                                                            data['File7'] ??
                                                                                '',
                                                                        fileurl7:
                                                                            data['File8'] ??
                                                                                '',
                                                                        fileurl8:
                                                                            data['File9'] ??
                                                                                '',
                                                                        fileurl9:
                                                                            data['File10'] ??
                                                                                '',
                                                                        fileurl10:
                                                                            data['File11'] ??
                                                                                '',
                                                                      ));
                                                                },
                                                                icon: const Icon(
                                                                    Icons
                                                                        .file_open,
                                                                    color: Color(
                                                                        0XFF407BFF)),
                                                              ),
                                                              Expanded(
                                                                  child:
                                                                      Container()),
                                                              IconButton(
                                                                onPressed:
                                                                    () async {
                                                                  // Set the email subject
                                                                  const String
                                                                      subject =
                                                                      'Carevista';

                                                                  // Create the email body by concatenating file URLs using string interpolation
                                                                  String body =
                                                                      '${data['File2'] ?? ''} ${data['File3'] ?? ''} ${data['File4'] ?? ''} ${data['File5'] ?? ''} ${data['File6'] ?? ''} ${data['File7'] ?? ''} ${data['File8'] ?? ''} ${data['File9'] ?? ''} ${data['File10'] ?? ''} ${data['File11'] ?? ''}';

                                                                  // Encode the subject and body into a URI format
                                                                  final Uri
                                                                      params =
                                                                      Uri(
                                                                    scheme:
                                                                        'mailto',
                                                                    query:
                                                                        'subject=$subject&body=$body',
                                                                  );

                                                                  // Convert the URI to a string
                                                                  final String
                                                                      url =
                                                                      params
                                                                          .toString();

                                                                  // Launch the email client with the subject and body pre-filled
                                                                  if (await canLaunch(
                                                                      url)) {
                                                                    await launch(
                                                                        url);
                                                                  } else {
                                                                    throw 'Could not launch $url';
                                                                  }
                                                                },
                                                                icon:
                                                                    Image.asset(
                                                                  'Assets/images/gmail (1).png',
                                                                  width: 40,
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  child:
                                                                      Container()),
                                                              IconButton(
                                                                onPressed: () {
                                                                  showDialog(
                                                                      barrierDismissible:
                                                                          false,
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                          title:
                                                                              const Text("Delect This Folder"),
                                                                          content:
                                                                              Text("Are you sure you want to Delect This ${data['FolderName'] ?? ''}"),
                                                                          actions: [
                                                                            IconButton(
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              icon: const Icon(
                                                                                Icons.cancel,
                                                                                color: Colors.red,
                                                                              ),
                                                                            ),
                                                                            IconButton(
                                                                              onPressed: () async {
                                                                                DocumentReference docRef = FirebaseFirestore.instance.collection('users').doc(uid).collection('PatientRecord').doc('${data['FolderName'] ?? ''}');
                                                                                docRef.delete().then((value) => print('Document deleted')).catchError((error) => print('Error deleting document: $error'));
                                                                                Navigator.pop(context);
                                                                              },
                                                                              icon: const Icon(
                                                                                Icons.done,
                                                                                color: Colors.green,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        );
                                                                      });
                                                                },
                                                                icon: const Icon(
                                                                    Icons
                                                                        .delete,
                                                                    color: Color(
                                                                        0XFF407BFF)),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                ]),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10)
                                ],
                              );
                            }).toList(),
                          );
                      }
                    },
                  ),
                ),
              ],
            ),
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
            GestureDetector(
              onTap: () {
                nextScreen(context, const Search());
              },
              child: Icon(
                Icons.search,
                size: 30,
                color: selsctedIconIndex == 1
                    ? Colors.white
                    : MyApp.themeNotifier.value == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                nextScreenReplace(context, const Dashboard());
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
