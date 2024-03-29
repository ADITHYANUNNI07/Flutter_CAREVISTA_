import 'dart:io';

import 'package:carevista_ver05/Helper/helper_function.dart';
import 'package:carevista_ver05/SCREEN/addons/diary.dart';
import 'package:carevista_ver05/SCREEN/addons/diseasecomplication.dart';
import 'package:carevista_ver05/SCREEN/addons/firstAID.dart';
import 'package:carevista_ver05/SCREEN/addons/medicinereminder.dart';
import 'package:carevista_ver05/SCREEN/addons/patientrecord.dart';
import 'package:carevista_ver05/SCREEN/editprofile.dart';
import 'package:carevista_ver05/SCREEN/home/favorites.dart';
import 'package:carevista_ver05/SCREEN/login.dart';
import 'package:carevista_ver05/SCREEN/profile/settingsnofifavorites.dart';
import 'package:carevista_ver05/SCREEN/profile/usertoaddhospital.dart';
import 'package:carevista_ver05/Service/auth_service.dart';
import 'package:carevista_ver05/admin/addHospital.dart';
import 'package:carevista_ver05/main.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfilePage extends StatefulWidget {
  String userName;
  String email;
  String phoneNo;
  String? imageUrl;
  ProfilePage({
    Key? key,
    required this.phoneNo,
    required this.email,
    required this.userName,
    required this.imageUrl,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

String Uid = FirebaseAuth.instance.currentUser?.uid ?? '';
bool adKey = false;
String adminKey = "";
File? image;
String uid = '';

class _ProfilePageState extends State<ProfilePage> {
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
    await HelperFunction.getUserPhoneFromSF().then((value) {
      setState(
        () {
          phoneNo = value!;
        },
      );
    });
    await HelperFunction.getUserAdkeyFromSF().then((value) {
      setState(() {
        adminKey = value!;
      });
      if (adminKey == 'false') {
        adKey = false;
      } else {
        adKey = true;
      }
    });
    await HelperFunction.getUserUIDFromSF().then((value) {
      setState(() {
        uid = value!;
      });
    });
    if (Uid != uid) {
      Uid = uid;
    }
  }

  Future<String?> getDOBFromUserId(String uid) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot =
        await firestore.collection('users').where('uid', isEqualTo: uid).get();
    if (querySnapshot.docs.isNotEmpty) {
      Map<String, dynamic> data =
          querySnapshot.docs.first.data() as Map<String, dynamic>;
      String? dob = data['DOB'];
      return dob;
    }
    return null;
  }

  Future<String?> getGenderFromUserId(String uid) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot =
        await firestore.collection('users').where('uid', isEqualTo: uid).get();
    if (querySnapshot.docs.isNotEmpty) {
      Map<String, dynamic> data =
          querySnapshot.docs.first.data() as Map<String, dynamic>;
      String? dob = data['Gender'];
      return dob;
    }
    return null;
  }

  Future<String?> getImageURLFromUserId(String uid) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot =
        await firestore.collection('users').where('uid', isEqualTo: uid).get();
    if (querySnapshot.docs.isNotEmpty) {
      Map<String, dynamic> data =
          querySnapshot.docs.first.data() as Map<String, dynamic>;
      String? dob = data['profilepic'];
      return dob;
    }
    return null;
  }

  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
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
              'Profile',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  //fontFamily: 'brandon_H',
                  color: Theme.of(context).primaryColorDark),
            ),
            actions: [
              IconButton(
                  icon: Icon(MyApp.themeNotifier.value == ThemeMode.light
                      ? LineAwesomeIcons.moon
                      : LineAwesomeIcons.sun),
                  onPressed: () {
                    MyApp.themeNotifier.value =
                        MyApp.themeNotifier.value == ThemeMode.light
                            ? ThemeMode.dark
                            : ThemeMode.light;
                  })
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: 150,
                        height: 150,
                        child: Image == null
                            ? CircleAvatar(
                                backgroundImage: FileImage(image!),
                                radius: 50,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: widget.imageUrl == ''
                                    ? Image.asset(
                                        'Assets/images/profile-user.jpg')
                                    : Image(
                                        image: Image.network(
                                          widget.imageUrl!,
                                        ).image,
                                      ),
                              ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 10,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Theme.of(context).backgroundColor),
                            child: IconButton(
                              onPressed: () async {
                                nextScreen(
                                    context,
                                    EditProfile(
                                        imageUrl: widget.imageUrl,
                                        gender: await getGenderFromUserId(Uid),
                                        dob: await getDOBFromUserId(Uid),
                                        adKey: adminKey,
                                        phoneNo: widget.phoneNo,
                                        email: widget.email,
                                        userName: widget.userName));
                              },
                              icon: const Icon(
                                LineAwesomeIcons.alternate_pencil,
                                color: Colors.white,
                              ),
                            ),
                          ))
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.userName,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    widget.email,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () async {
                        nextScreen(
                            context,
                            EditProfile(
                              imageUrl: widget.imageUrl,
                              gender: await getGenderFromUserId(Uid),
                              dob: await getDOBFromUserId(Uid),
                              adKey: adminKey,
                              phoneNo: widget.phoneNo,
                              email: widget.email,
                              userName: widget.userName,
                            ));
                        print(Uid);
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          foregroundColor: Colors.white,
                          backgroundColor: Theme.of(context).backgroundColor,
                          side: BorderSide.none,
                          shape: const StadiumBorder()),
                      child: const Text('Edit Profile'),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Divider(),
                  const SizedBox(height: 5),
                  ProfileMenuWidget(
                    title: "Settings",
                    icon: LineAwesomeIcons.cog,
                    onPress: () {
                      nextScreen(context, const SettingSrn());
                    },
                  ),
                  ProfileMenuWidget(
                      title: "Medical Records",
                      icon: Icons.medical_information_outlined,
                      onPress: () {
                        nextScreen(context, const PatientRecord());
                      }),
                  ProfileMenuWidget(
                      title: "Favorites",
                      icon: Icons.star_border_rounded,
                      onPress: () {
                        nextScreen(context, Favorites());
                      }),
                  ProfileMenuWidget(
                      title: "First AID Treatement",
                      icon: LineAwesomeIcons.first_aid,
                      onPress: () {
                        nextScreen(context, const FirstAID());
                      }),
                  ProfileMenuWidget(
                      title: "Diary",
                      icon: Icons.note_add,
                      onPress: () {
                        nextScreen(context, const Diary());
                      }),
                  ProfileMenuWidget(
                      title: "Medicine Reminder",
                      icon: Icons.alarm_add,
                      onPress: () {
                        nextScreen(
                            context,
                            MedicineReminder(
                              uid: uid,
                            ));
                      }),
                  ProfileMenuWidget(
                      title: "Disease Complication",
                      icon: LineAwesomeIcons.heartbeat,
                      onPress: () {
                        nextScreen(context, const DiseaseComplication());
                      }),
                  adKey == true
                      ? ProfileMenuWidget(
                          title: "Add Hospital Information",
                          icon: Icons.local_hospital,
                          onPress: () {
                            nextScreen(
                                context,
                                AddHospital(
                                    username: widget.userName,
                                    userphoneno: widget.phoneNo));
                          })
                      : Container(),
                  adKey == false
                      ? ProfileMenuWidget(
                          title: "Add Your Nearest Hospital",
                          icon: Icons.local_hospital,
                          onPress: () {
                            nextScreen(
                                context,
                                UserToAddHospital(
                                    username: widget.userName,
                                    userphoneno: widget.phoneNo));
                          })
                      : Container(),
                  const Divider(),
                  ProfileMenuWidget(
                    title: "Logout",
                    endIcon: false,
                    icon: LineAwesomeIcons.alternate_sign_out,
                    textColor: Colors.red,
                    onPress: () async {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Logout"),
                              content: const Text(
                                  "Are you sure you want to logout?"),
                              actions: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("cancel"),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black),
                                  onPressed: () async {
                                    authService.signOut().whenComplete(
                                          () => {
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                              // the new route
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        LoginScreen(),
                                              ),

                                              // this function should return true when we're done removing routes
                                              // but because we want to remove all other screens, we make it
                                              // always return false
                                              (Route route) => false,
                                            )
                                          },
                                        );
                                  },
                                  child: const Text("Yes"),
                                )
                              ],
                            );
                          });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color(0xFF00008F).withOpacity(0.2),
        ),
        child: Icon(icon),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1?.apply(color: textColor),
      ),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey.withOpacity(0.1)),
              child: const Icon(
                LineAwesomeIcons.angle_right,
                size: 18,
              ),
            )
          : null,
    );
  }
}
