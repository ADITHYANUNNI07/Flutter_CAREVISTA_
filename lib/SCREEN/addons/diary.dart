import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:carevista_ver05/Helper/helper_function.dart';
import 'package:carevista_ver05/SCREEN/addons/patientrecord.dart';
import 'package:carevista_ver05/Service/database_service.dart';
import 'package:carevista_ver05/main.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'color.dart' as specialcolor;

class Diary extends StatefulWidget {
  const Diary({super.key});

  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String oldtitle = '';
  String oldNotes = '';
  String olddiaryTitle = '';
  String olddiaryNotes = '';
  bool editDiary = false;
  String Uid = FirebaseAuth.instance.currentUser?.uid ?? '';
  final fromKey = GlobalKey<FormState>();
  bool createDiary = false;
  bool loading = false;
  String diaryTitle = '';
  String diaryNotes = '';
  String uid = '';
  @override
  void initState() {
    super.initState();
    gettingUserData();
    _controller = AnimationController(vsync: this);
    editDiary = false;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
    if (Uid != uid) {
      Uid = uid;
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            ),
          )
        : editDiary
            ? Container(
                color: const Color(0xFF04FBC3),
                child: SafeArea(
                  child: Scaffold(
                    appBar: AppBar(
                      backgroundColor:
                          Theme.of(context).appBarTheme.backgroundColor,
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
                        'Diary',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25,
                            //fontFamily: 'brandon_H',
                            color: Theme.of(context).primaryColorDark),
                      ),
                    ),
                    body: SingleChildScrollView(
                      child: Container(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          height: 400 + 245,
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
                              Container(
                                padding: const EdgeInsets.all(10),
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
                                      Text(oldtitle,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2),
                                      const SizedBox(height: 20),
                                      TextFormField(
                                        initialValue: oldtitle,
                                        decoration: const InputDecoration(
                                            prefixIcon:
                                                Icon(Icons.title_rounded),
                                            labelText: 'Title',
                                            border: OutlineInputBorder()),
                                        onChanged: (val) {
                                          olddiaryTitle = val;
                                        },
                                        // check tha validation
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return "Please Enter Title";
                                          }
                                        },
                                      ),
                                      const SizedBox(height: 15),
                                      TextFormField(
                                        initialValue: oldNotes,
                                        maxLines: 20,
                                        decoration: const InputDecoration(
                                          prefixIcon:
                                              Icon(Icons.note_alt_rounded),
                                          labelText: 'Note',
                                          border: OutlineInputBorder(),
                                        ),
                                        onChanged: (value) {
                                          olddiaryNotes = value;
                                        },
                                        validator: (p0) {
                                          if (p0!.isEmpty) {
                                            return "Please Enter Notes";
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
                                              setState(() {
                                                loading = true;
                                              });
                                              createUpdateDiary();
                                            },
                                            child: const Text(
                                              'ADD',
                                            )),
                                      ),
                                      const SizedBox(height: 5),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 13),
                                              foregroundColor: Colors.white,
                                              backgroundColor: Colors.redAccent,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                editDiary = false;
                                              });
                                            },
                                            child: const Text(
                                              'Cancel',
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Container(
                color: const Color(0xFF04FBC3),
                child: SafeArea(
                    child: Scaffold(
                  appBar: AppBar(
                    backgroundColor:
                        Theme.of(context).appBarTheme.backgroundColor,
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
                      'Diary',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25,
                          //fontFamily: 'brandon_H',
                          color: Theme.of(context).primaryColorDark),
                    ),
                  ),
                  body: SingleChildScrollView(
                      child: Container(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              createDiary = true;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            height: createDiary == false ? 49 : 400 + 215 + 90,
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
                                      'Add New Dairy',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Expanded(child: Container()),
                                    IconButton(
                                        onPressed: () {
                                          if (createDiary == false) {
                                            setState(() {
                                              createDiary = true;
                                            });
                                          } else {
                                            setState(() {
                                              createDiary = false;
                                            });
                                          }
                                        },
                                        icon: createDiary == false
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
                                createDiary == true
                                    ? Container(
                                        height: 255 + 88 + 222 + 10,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: MyApp.themeNotifier.value ==
                                                    ThemeMode.light
                                                ? Colors.white
                                                : Colors.black.withOpacity(1),
                                            borderRadius: const BorderRadius
                                                    .only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10))),
                                        child: Form(
                                          key: fromKey,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              Text(
                                                  'Enter New Diary Title and Notes',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2),
                                              const SizedBox(height: 20),
                                              TextFormField(
                                                decoration: const InputDecoration(
                                                    prefixIcon: Icon(
                                                        Icons.title_rounded),
                                                    labelText: 'Title',
                                                    border:
                                                        OutlineInputBorder()),
                                                onChanged: (val) {
                                                  diaryTitle = val;
                                                },
                                                // check tha validation
                                                validator: (val) {
                                                  if (val!.isEmpty) {
                                                    return "Please Enter Title";
                                                  }
                                                },
                                              ),
                                              const SizedBox(height: 15),
                                              TextFormFieldAreaWidget(
                                                  labelText: 'Note',
                                                  onChange: (value) {
                                                    diaryNotes = value;
                                                  },
                                                  validator: (p0) {
                                                    if (p0!.isEmpty) {
                                                      return "Please Enter Notes";
                                                    }
                                                  },
                                                  icon: Icons.note_alt_rounded),
                                              const SizedBox(height: 15),
                                              SizedBox(
                                                width: double.infinity,
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 13),
                                                      foregroundColor:
                                                          Colors.white,
                                                      backgroundColor:
                                                          const Color(
                                                              0XFF407BFF),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        loading = true;
                                                      });
                                                      createNewDiary();
                                                    },
                                                    child: const Text(
                                                      'ADD',
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
                                .collection('Diary')
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
                                      Map<String, dynamic> data = document
                                          .data() as Map<String, dynamic>;
                                      return Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 318,
                                                height: menubool == false
                                                    ? 110
                                                    : 190,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    nextScreen(
                                                        context,
                                                        DiarySecond(
                                                            title:
                                                                data['Title'] ??
                                                                    '',
                                                            content:
                                                                data['Diary'] ??
                                                                    ''));
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 30,
                                                            right: 10,
                                                            top: 5),
                                                    decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                            colors: [
                                                              specialcolor
                                                                  .AppColor
                                                                  .gradientFirst
                                                                  .withOpacity(
                                                                      0.9),
                                                              specialcolor
                                                                  .AppColor
                                                                  .gradientSecond
                                                                  .withOpacity(
                                                                      0.9)
                                                            ],
                                                            begin: Alignment
                                                                .bottomLeft,
                                                            end: Alignment
                                                                .centerRight),
                                                        color: const Color(
                                                            0XFF407BFF),
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .only(
                                                                bottomLeft:
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10))),
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  data['Title'] ??
                                                                      '',
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          27,
                                                                      color: Colors
                                                                          .white)),
                                                              Expanded(
                                                                  child:
                                                                      Container()),
                                                              IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    if (menubool ==
                                                                        false) {
                                                                      setState(
                                                                          () {
                                                                        menubool =
                                                                            true;
                                                                      });
                                                                    } else {
                                                                      setState(
                                                                          () {
                                                                        menubool =
                                                                            false;
                                                                      });
                                                                    }
                                                                  },
                                                                  icon: menubool ==
                                                                          false
                                                                      ? const Icon(
                                                                          Icons
                                                                              .menu,
                                                                          color:
                                                                              Colors.white,
                                                                        )
                                                                      : const Icon(
                                                                          Icons
                                                                              .menu_open,
                                                                          color:
                                                                              Colors.white,
                                                                        ))
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                  child:
                                                                      Container()),
                                                              Text(
                                                                  data['Date'] ??
                                                                      '',
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      fontSize:
                                                                          10,
                                                                      color: Colors
                                                                          .white)),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 20),
                                                          menubool == false
                                                              ? Container()
                                                              : Container(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 10,
                                                                      right:
                                                                          10),
                                                                  height: 50,
                                                                  width: double
                                                                      .infinity,
                                                                  decoration: const BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius: BorderRadius.only(
                                                                          bottomLeft: Radius.circular(
                                                                              10),
                                                                          bottomRight: Radius.circular(
                                                                              10),
                                                                          topLeft: Radius.circular(
                                                                              10),
                                                                          topRight:
                                                                              Radius.circular(10))),
                                                                  child: Row(
                                                                    children: [
                                                                      IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            oldtitle =
                                                                                data['Title'] ?? '';
                                                                            oldNotes =
                                                                                data['Diary'] ?? '';
                                                                            editDiary =
                                                                                true;
                                                                          });
                                                                        },
                                                                        icon: const Icon(
                                                                            Icons
                                                                                .edit_document,
                                                                            color:
                                                                                Color(0XFF407BFF)),
                                                                      ),
                                                                      Expanded(
                                                                          child:
                                                                              Container()),
                                                                      IconButton(
                                                                        onPressed:
                                                                            () async {
                                                                          // Set the email subject
                                                                          String
                                                                              subject =
                                                                              '${data['Title'] ?? ''}';

                                                                          // Create the email body by concatenating file URLs using string interpolation
                                                                          String
                                                                              body =
                                                                              '${data['Diary'] ?? ''}';

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
                                                                              params.toString();

                                                                          // Launch the email client with the subject and body pre-filled
                                                                          if (await canLaunch(
                                                                              url)) {
                                                                            await launch(url);
                                                                          } else {
                                                                            throw 'Could not launch $url';
                                                                          }
                                                                        },
                                                                        icon: Image
                                                                            .asset(
                                                                          'Assets/images/gmail (1).png',
                                                                          width:
                                                                              40,
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                          child:
                                                                              Container()),
                                                                      IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          showDialog(
                                                                              barrierDismissible: false,
                                                                              context: context,
                                                                              builder: (context) {
                                                                                return AlertDialog(
                                                                                  title: const Text("Delect This Folder"),
                                                                                  content: Text("Are you sure you want to Delect This ${data['FolderName'] ?? ''}"),
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
                                                                                        DocumentReference docRef = FirebaseFirestore.instance.collection('users').doc(uid).collection('Diary').doc('${data['Title'] ?? ''}');
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
                                                                            color:
                                                                                Color(0XFF407BFF)),
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
                  )),
                )),
              );
  }

  createNewDiary() async {
    if (fromKey.currentState!.validate()) {
      await DatabaseService(uid: uid).diaryDB(diaryTitle, diaryNotes);
      // ignore: use_build_context_synchronously
      setState(() {
        loading = false;
      });
      newshowSnackbar(context, 'Add New Diary',
          'create new Diary successfully :)', ContentType.success);
      setState(() {
        createDiary = false;
      });
    }
  }

  createUpdateDiary() async {
    if (fromKey.currentState!.validate()) {
      if (oldtitle == olddiaryTitle && oldNotes == olddiaryNotes) {
      } else {
        if (olddiaryNotes.isEmpty) {
          olddiaryNotes = oldNotes;
        }
        if (olddiaryTitle.isEmpty) {
          olddiaryTitle = oldtitle;
          await DatabaseService(uid: uid).diaryDB(olddiaryTitle, olddiaryNotes);
          // ignore: use_build_context_synchronously
          setState(() {
            oldtitle = olddiaryTitle;
            oldNotes = olddiaryNotes;
          });
          setState(() {
            loading = false;
          });
          newshowSnackbar(context, 'Update Your Diary',
              'Update Your Diary successfully :)', ContentType.success);
        } else {
          DocumentReference docRef = FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .collection('Diary')
              .doc(oldtitle);
          docRef
              .delete()
              .then((value) => print('Document deleted'))
              .catchError((error) => print('Error deleting document: $error'));
          await DatabaseService(uid: uid).diaryDB(olddiaryTitle, olddiaryNotes);
          // ignore: use_build_context_synchronously
          setState(() {
            oldtitle = olddiaryTitle;
            oldNotes = olddiaryNotes;
          });
          setState(() {
            loading = false;
          });
          newshowSnackbar(context, 'Update Your Diary',
              'Update Your Diary successfully :)', ContentType.success);
        }
      }
    }
  }
}

class DiarySecond extends StatelessWidget {
  DiarySecond({super.key, required this.title, required this.content});
  String title;
  String content;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: const Color(0xFF04FBC3),
      child: SafeArea(
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
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25,
                //fontFamily: 'brandon_H',
                color: Theme.of(context).primaryColorDark),
          ),
        ),
        body: Center(
          child: Container(
            padding:
                const EdgeInsets.only(top: 20, left: 15, right: 10, bottom: 10),
            width: size.width - 40,
            height: size.height - 110,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  specialcolor.AppColor.gradientFirst.withOpacity(0.9),
                  specialcolor.AppColor.gradientSecond.withOpacity(0.9)
                ], begin: Alignment.bottomLeft, end: Alignment.centerRight),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    content,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
