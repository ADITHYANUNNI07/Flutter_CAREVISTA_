import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:carevista_ver05/Helper/helper_function.dart';
import 'package:carevista_ver05/SCREEN/dashboard.dart';
import 'package:carevista_ver05/Service/auth_service.dart';
import 'package:carevista_ver05/Service/database_service.dart';
import 'package:carevista_ver05/utils/utils.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class EditProfile extends StatefulWidget {
  String userName;
  String email;
  String phoneNo;
  String adKey;
  String? dob;
  String? gender;
  String? imageUrl;
  EditProfile(
      {super.key,
      required this.phoneNo,
      required this.email,
      required this.userName,
      required this.adKey,
      required this.dob,
      required this.gender,
      required this.imageUrl});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

final fromKey = GlobalKey<FormState>();
late TextEditingController dateController;
String fullname = "";
String Uid = FirebaseAuth.instance.currentUser?.uid ?? '';
String phone = "";
String uid = "";
String email = "";
String _gender = "";
String gender = "";
File? image;
bool imagebool = false;
String imageUrl = '';
bool newEmailbool = false;
String newEmailPassword = '';
bool passVisible = false;
final FirebaseAuth _auth = FirebaseAuth.instance;

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    super.initState();
    gettingUserData();
    dateController = TextEditingController(text: widget.dob);
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
    if (Uid != uid) {
      Uid = uid;
    }
  }

  bool _isLoding = false;
  Widget build(BuildContext context) {
    return _isLoding
        ? Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
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
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: widget.imageUrl == ""
                                              ? Image.asset(
                                                  'Assets/images/profile-user.jpg')
                                              : Image(
                                                  image: Image.network(
                                                    widget.imageUrl!,
                                                  ).image,
                                                ),
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
                                child: IconButton(
                                  onPressed: () {
                                    SelectImage();
                                  },
                                  icon: const Icon(
                                    LineAwesomeIcons.camera,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
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
                                      return RegExp(
                                                  r"(^(?:[+0]9)?[0-9]{10,12}$)")
                                              .hasMatch(val!)
                                          ? null
                                          : "Please enter valid mobile number";
                                    }),
                                const SizedBox(height: 10),
                                TextFormField(
                                  initialValue: widget.email,
                                  decoration: InputDecoration(
                                      prefixIcon:
                                          const Icon(Icons.email_outlined),
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
                                newEmailbool == false
                                    ? Container()
                                    : TextFormField(
                                        obscureText: passVisible ? false : true,
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                              Icons.fingerprint_outlined),
                                          labelText: 'Password',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              if (passVisible) {
                                                setState(() {
                                                  passVisible = false;
                                                });
                                              } else {
                                                setState(() {
                                                  passVisible = true;
                                                });
                                              }
                                            },
                                            icon: passVisible
                                                ? const Icon(
                                                    LineAwesomeIcons.eye)
                                                : const Icon(
                                                    LineAwesomeIcons.eye_slash),
                                          ),
                                        ),
                                        onChanged: (val) {
                                          newEmailPassword = val;
                                        },
                                        validator: (val) {
                                          if (val!.length < 6) {
                                            return "Password must be at least 6 characters";
                                          } else {
                                            return null;
                                          }
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                      widget.gender!.isEmpty
                                          ? Container(
                                              padding: const EdgeInsets.all(1),
                                              child: SizedBox(
                                                height: 50,
                                                child: ListView(
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
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
                                                      ),
                                                    ),
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
                                            )
                                          : Container(
                                              padding: const EdgeInsets.all(1),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                width: double.infinity,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Theme.of(context)
                                                      .highlightColor,
                                                ),
                                                child: Text(
                                                  widget.gender!,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  initialValue: null,
                                  readOnly: true,
                                  controller: dateController,
                                  decoration: InputDecoration(
                                    hintText: 'DOB',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100)),
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
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please Select DOB";
                                    } else {
                                      return null;
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
                                        if (gender.isEmpty) {
                                          gender = widget.gender!;
                                        }
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
                                                      contentType: ContentType
                                                          .warning)));
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

  uploadImage() async {
    if (image == null) return;
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages =
        referenceRoot.child('user/$Uid/profilephoto');

    //Create a reference for the image to be stored
    Reference referenceImageToUpload = referenceDirImages.child('profilephoto');

    //Handle errors/success
    try {
      //Store the file
      await referenceImageToUpload.putFile(File(image!.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (error) {
      //Some error occurred
    }
    if (imageUrl.isEmpty) {
      // ignore: use_build_context_synchronously
      newshowSnackbar(context, 'Failed',
          'Please try again...That logo is not upload..', ContentType.failure);
    }
  }

  updateProfile() async {
    if (fromKey.currentState!.validate()) {
      if (phone.isEmpty) {
        phone = widget.phoneNo;
      }
      if (fullname.isEmpty) {
        fullname = widget.userName;
      }
      uploadImage();
      if (imageUrl.isEmpty) {
        imageUrl = widget.imageUrl!;
      }
      String dob = dateController.text;
      if (email.isEmpty) {
        email = widget.email;
      } else if (email != widget.email) {
        setState(() {
          newEmailbool = true;
        });
        if (newEmailPassword.isEmpty) {
          newshowSnackbar(
              context,
              'New Email Password',
              'Please enter new email password.Then to SAVE',
              ContentType.warning);
          return false;
        } else {
          await AuthService()
              .exchangeUserAccount(fullname, phone, email, newEmailPassword,
                  widget.adKey, gender, dob, imageUrl)
              .then((value) async {
            if (value == true) {
              //saving the shared preference state
              await HelperFunction.saveUserLoggedInStatus(true);
              await HelperFunction.saveUserNameSF(fullname);
              await HelperFunction.saveUserEmailSF(email);
              await HelperFunction.saveUserPhoneSF(phone);
              await HelperFunction.saveUserAdkeyFromSF(widget.adKey);
              QuerySnapshot snapshot = await DatabaseService(
                      uid: FirebaseAuth.instance.currentUser!.uid)
                  .gettingUserData(email);
              await HelperFunction.saveUserUIDFromSF(snapshot.docs[0]['uid']);
              await HelperFunction.saveUserImageURLSF(
                  snapshot.docs[0]['profilepic']);
              // ignore: use_build_context_synchronously
              setState(() {
                _isLoding = false;
              });
              newshowSnackbar(context, 'Successfully change Email',
                  'your Email Change Successfully...', ContentType.success);
            } else {
              setState(() {
                showSnackbar(context, Colors.red, value);
              });
            }
          });
        }
      } else {
        print(Uid);
        await DatabaseService(uid: Uid).updateUser(
            fullname, email, phone, widget.adKey, gender, dob, imageUrl, Uid);
        // ignore: use_build_context_synchronously await HelperFunction.saveUserPhoneSF(snapshot.docs[0]['phoneNo']);
        QuerySnapshot snapshot =
            await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                .gettingUserData(email);
        // saving the values to our shared preferences
        await HelperFunction.saveUserLoggedInStatus(true);
        await HelperFunction.saveUserNameSF(snapshot.docs[0]['fullName']);
        await HelperFunction.saveUserEmailSF(email);
        await HelperFunction.saveUserPhoneSF(snapshot.docs[0]['phoneNo']);
        await HelperFunction.saveUserAdkeyFromSF(snapshot.docs[0]['AdKey']);
        await HelperFunction.saveUserImageURLSF(snapshot.docs[0]['profilepic']);
        setState(() {
          _isLoding = false;
        });

        // ignore: use_build_context_synchronously
        nextScreen(context, const Dashboard());
        // ignore: use_build_context_synchronously
        newshowSnackbar(context, 'Update Profile',
            'your profile update successfully', ContentType.success);
      }
    } else {
      newshowSnackbar(context, 'Check above Details',
          'Invalid format please check above the Details', ContentType.failure);
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
