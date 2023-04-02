import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:carevista_ver05/Service/database_service.dart';
import 'package:carevista_ver05/utils/utils.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class EditProfile extends StatefulWidget {
  String userName;
  String email;
  String phoneNo;

  EditProfile({
    super.key,
    required this.phoneNo,
    required this.email,
    required this.userName,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final fromKey = GlobalKey<FormState>();
  final dateController = TextEditingController();
  String fullname = "";

  String phone = "";
  String uid = "";
  String email = "";
  String _gender = "";
  String gender = "";
  File? image;
  String dob = "";
  bool imagebool = false;

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
                'Edit Profile',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'brandon_H',
                    color: Theme.of(context).primaryColorDark),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            SelectImage();
                          },
                          child: SizedBox(
                              width: 150,
                              height: 150,
                              child: imagebool == false
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.asset(
                                          'Assets/images/profile-user.jpg'),
                                    )
                                  : CircleAvatar(
                                      backgroundImage: FileImage(image!),
                                      radius: 50,
                                    )),
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
                              child: const Icon(
                                LineAwesomeIcons.camera,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                    const SizedBox(height: 50),
                    Form(
                        key: fromKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                                initialValue: widget.userName,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                        Icons.person_outline_outlined),
                                    labelText: 'Full Name',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100))),
                                onChanged: (val) {
                                  fullname = val;
                                },
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Enter Your Name";
                                  } else {
                                    return RegExp(
                                                r'[!@#<>?:_`"~;[\]\\|=+)(*&^%0-9-]')
                                            .hasMatch(val)
                                        ? "Please enter valid name"
                                        : null;
                                  }
                                }),
                            const SizedBox(height: 10),
                            TextFormField(
                                initialValue: widget.phoneNo,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    prefixIcon:
                                        const Icon(Icons.phone_outlined),
                                    labelText: 'Phone No',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100))),
                                onChanged: (val) {
                                  phone = val;
                                },
                                validator: (val) {
                                  return RegExp(r"(^(?:[+0]9)?[0-9]{10,12}$)")
                                          .hasMatch(val!)
                                      ? null
                                      : "Please enter valid mobile number";
                                }),
                            const SizedBox(height: 10),
                            TextFormField(
                              initialValue: widget.email,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.email_outlined),
                                  labelText: 'E-Mail',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(100))),
                              onChanged: (val) {
                                email = val;
                              },
                              // check tha validation
                              validator: (val) {
                                return RegExp(r"^[a-z0-9]+@gmail+\.com+")
                                        .hasMatch(val!)
                                    ? null
                                    : "Please enter a valid email";
                              },
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.all(10),
                              width: double.infinity,
                              height: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).cardColor),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Gender',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    padding: const EdgeInsets.all(1),
                                    child: SizedBox(
                                      height: 50,
                                      child: ListView(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          ContainerWidget(
                                              title: 'Male',
                                              radioBtn: Radio(
                                                value: 'Male',
                                                groupValue: _gender,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _gender = value!;
                                                    gender = "Male";
                                                  });
                                                },
                                              )),
                                          const SizedBox(width: 5),
                                          ContainerWidget(
                                              title: 'Female',
                                              radioBtn: Radio(
                                                value: 'Female',
                                                groupValue: _gender,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _gender = value!;
                                                    gender = "Female";
                                                  });
                                                },
                                              )),
                                          const SizedBox(width: 5),
                                          ContainerWidget(
                                              title: 'Other',
                                              radioBtn: Radio(
                                                value: 'other',
                                                groupValue: _gender,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _gender = value!;
                                                    gender = "Other";
                                                  });
                                                },
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              readOnly: true,
                              controller: dateController,
                              decoration: InputDecoration(
                                hintText: 'Pick your Date',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                              onTap: () async {
                                var date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100));
                                if (date != null) {
                                  dateController.text =
                                      DateFormat('MM/dd/yyyy').format(date);
                                }
                              },
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    side: BorderSide.none,
                                    shape: const StadiumBorder(),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 13),
                                    foregroundColor: Colors.white,
                                    backgroundColor:
                                        Theme.of(context).backgroundColor,
                                  ),
                                  onPressed: () {
                                    print(dateController.text);
                                    if (gender.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              elevation: 0,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              content: AwesomeSnackbarContent(
                                                  inMaterialBanner: true,
                                                  title: 'Oh Snap..!',
                                                  message:
                                                      'Gender field is Empty',
                                                  contentType:
                                                      ContentType.warning)));
                                    } else {
                                      updateProfile();
                                    }
                                  },
                                  child: const Text('SAVE')),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void SelectImage() async {
    image = await pickImage(context);
    setState(() {
      imagebool = true;
    });
  }

  updateProfile() async {
    print(email);
    if (phone.isEmpty) {
      phone = widget.phoneNo;
    }
    if (email.isEmpty) {
      email = widget.email;
    }
    if (fullname.isEmpty) {
      fullname = widget.userName;
    }
    String dob = dateController.text;
    if (fromKey.currentState!.validate()) {
      //print(widget.password);
      String userid = FirebaseAuth.instance.currentUser!.uid;
      print(userid);
      // uploading image to firebase storage.UserCredential userCredential = await auth.signInWithEmailAndPassword(
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: '123456',
      ); // Upload image to Firebase Storage

      await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
          .updateUserData(fullname, email, phone, gender, dob);
      // ignore: use_build_context_synchronously
      newshowSnackbar(context, 'Update Profile',
          'your profile update successfully', ContentType.success);
    }
  }
}

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({
    Key? key,
    required this.title,
    required this.radioBtn,
  }) : super(key: key);
  final String title;
  final Widget radioBtn;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 103,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).highlightColor,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(4),
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Theme.of(context).cardColor),
              child: radioBtn,
            ),
          ),
          const SizedBox(width: 5),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    style: Theme.of(context).textTheme.bodyText2,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
