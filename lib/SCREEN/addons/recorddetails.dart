import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:carevista_ver05/Helper/helper_function.dart';
import 'package:carevista_ver05/Service/database_service.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:carevista_ver05/utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';

// ignore: must_be_immutable
class RecordDetails extends StatefulWidget {
  RecordDetails(
      {super.key,
      required this.folderName,
      required this.date,
      required this.folderCreatedate,
      required this.folderNo,
      required this.remark});
  String folderName;
  String date;
  String folderCreatedate;
  String folderNo;
  String remark;
  @override
  State<RecordDetails> createState() => _RecordDetailsState();
}

File? file;
File? image;
String userName = "";
String email = "";
String uid = "";
String phoneNo = "";
String fileUrl = "";
String imageUrl = "";
bool uploadfile = false;
bool imagEmty = false;
String folderNumber = '';

class _RecordDetailsState extends State<RecordDetails> {
  @override
  void initState() {
    super.initState();
    gettingUserData();
    folderNumber = widget.folderNo;
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
                  widget.folderName,
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
                        onTap: () async {
                          if (uploadfile == false) {
                            setState(() {
                              uploadfile = true;
                            });
                          } else {
                            setState(() {
                              uploadfile = false;
                            });
                          }
                        },
                        child: folderNumber == '10'
                            ? Container()
                            : Container(
                                padding: const EdgeInsets.only(
                                    left: 20, top: 20, right: 20),
                                height: uploadfile == false ? 64 : 400,
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
                                          'Add Image / Pdf',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Expanded(child: Container()),
                                        const Icon(Icons.file_present_sharp,
                                            color: Colors.white),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    uploadfile == true
                                        ? Container(
                                            height: 280,
                                            padding: const EdgeInsets.all(10),
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10))),
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  children: [
                                                    const Text(
                                                      'Choose File',
                                                      style: TextStyle(
                                                          fontSize: 40,
                                                          fontFamily:
                                                              'brandon_H'),
                                                    ),
                                                    Text(
                                                        'Select one of the options given below .',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2),
                                                    const SizedBox(height: 30),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        //image
                                                        image = await pickImage(
                                                            context);

                                                        // ignore: use_build_context_synchronously
                                                        newshowSnackbar(
                                                            context,
                                                            'Upload Image',
                                                            'Please..! upload the image',
                                                            ContentType
                                                                .warning);
                                                        setState(() {
                                                          imagEmty = true;
                                                        });
                                                      },
                                                      child: Container(
                                                        width: 260,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: Colors
                                                                .grey.shade200),
                                                        child: Row(
                                                          // ignore: prefer_const_literals_to_create_immutables
                                                          children: [
                                                            const Icon(
                                                              Icons
                                                                  .photo_outlined,
                                                              size: 40,
                                                            ),
                                                            const SizedBox(
                                                                width: 5),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              // ignore: prefer_const_literals_to_create_immutables

                                                              children: [
                                                                const Text(
                                                                  'Image',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          19,
                                                                      fontFamily:
                                                                          'brandon_H'),
                                                                ),
                                                                Text(
                                                                  'Select image one by one',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText1,
                                                                ),
                                                              ],
                                                            ),
                                                            ElevatedButton(
                                                                style: ElevatedButton.styleFrom(
                                                                    side: BorderSide
                                                                        .none,
                                                                    shape:
                                                                        const CircleBorder(),
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            10),
                                                                    foregroundColor:
                                                                        Colors
                                                                            .white,
                                                                    backgroundColor:
                                                                        const Color(
                                                                            0XFF407BFF)),
                                                                onPressed:
                                                                    () async {
                                                                  if (imagEmty ==
                                                                      true) {
                                                                    setState(
                                                                        () {
                                                                      _isLoding =
                                                                          true;
                                                                    });
                                                                    if (image ==
                                                                        null)
                                                                      return;

                                                                    Reference
                                                                        referenceRoot =
                                                                        FirebaseStorage
                                                                            .instance
                                                                            .ref();
                                                                    Reference
                                                                        referenceDirImages =
                                                                        referenceRoot
                                                                            .child('user/$userName/Patient Record');

                                                                    //Create a reference for the image to be stored
                                                                    Reference
                                                                        referenceImageToUpload =
                                                                        referenceDirImages.child('${userName}image' +
                                                                            folderNumber);

                                                                    //Handle errors/success
                                                                    try {
                                                                      //Store the file
                                                                      await referenceImageToUpload
                                                                          .putFile(
                                                                              File(image!.path));
                                                                      imageUrl =
                                                                          await referenceImageToUpload
                                                                              .getDownloadURL();
                                                                    } catch (error) {
                                                                      //Some error occurred
                                                                    }
                                                                    if (imageUrl
                                                                        .isEmpty) {
                                                                      newshowSnackbar(
                                                                          context,
                                                                          'Failed',
                                                                          'Please try again...That image  is not upload..',
                                                                          ContentType
                                                                              .failure);
                                                                      setState(
                                                                          () {
                                                                        _isLoding =
                                                                            false;
                                                                      });
                                                                    } else {
                                                                      uplodImage();
                                                                      // ignore: use_build_context_synchronously
                                                                      newshowSnackbar(
                                                                          context,
                                                                          'Upload Successfully',
                                                                          'Hospital image 2 Upload Successfully',
                                                                          ContentType
                                                                              .success);
                                                                      setState(
                                                                          () {
                                                                        _isLoding =
                                                                            false;
                                                                      });
                                                                    }
                                                                  } else {
                                                                    newshowSnackbar(
                                                                        context,
                                                                        'Warning',
                                                                        'please select image',
                                                                        ContentType
                                                                            .warning);
                                                                  }
                                                                },
                                                                child:
                                                                    const Icon(
                                                                  Icons
                                                                      .cloud_upload,
                                                                  size: 20,
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    GestureDetector(
                                                      onTap: () {
                                                        //pdf
                                                      },
                                                      child: Container(
                                                        width: 260,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: Colors
                                                                .grey.shade200),
                                                        child: Row(
                                                          // ignore: prefer_const_literals_to_create_immutables
                                                          children: [
                                                            const Icon(
                                                              Icons
                                                                  .picture_as_pdf,
                                                              size: 40,
                                                            ),
                                                            const SizedBox(
                                                                width: 5),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              // ignore: prefer_const_literals_to_create_immutables

                                                              children: [
                                                                const Text(
                                                                  'Pdf',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          19,
                                                                      fontFamily:
                                                                          'brandon_H'),
                                                                ),
                                                                Text(
                                                                  'Select Pdf one by one',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText1,
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                width: 19),
                                                            ElevatedButton(
                                                                style: ElevatedButton.styleFrom(
                                                                    side: BorderSide
                                                                        .none,
                                                                    shape:
                                                                        const CircleBorder(),
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            10),
                                                                    foregroundColor:
                                                                        Colors
                                                                            .white,
                                                                    backgroundColor: Color(
                                                                        0XFF407BFF)),
                                                                onPressed:
                                                                    () async {},
                                                                child:
                                                                    const Icon(
                                                                  Icons
                                                                      .cloud_upload,
                                                                  size: 20,
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  uplodImage() async {
    print(folderNumber);
    if (folderNumber == '1') {
      setState(() {
        folderNumber = '2';
      });
    } else if (folderNumber == '2') {
      setState(() {
        folderNumber = '3';
      });
    } else if (folderNumber == '3') {
      setState(() {
        folderNumber = '4';
      });
    } else if (folderNumber == '4') {
      setState(() {
        folderNumber = '5';
      });
    } else if (folderNumber == '5') {
      setState(() {
        folderNumber = '6';
      });
    } else if (folderNumber == '6') {
      setState(() {
        folderNumber = '7';
      });
    } else if (folderNumber == '7') {
      setState(() {
        folderNumber = '8';
      });
    } else if (folderNumber == '8') {
      setState(() {
        folderNumber = '9';
      });
    } else if (folderNumber == '9') {
      setState(() {
        folderNumber = '10';
      });
    }
    print(folderNumber);
    await DatabaseService(uid: uid).updateFolderDB(
        widget.folderName,
        widget.folderName,
        widget.remark,
        widget.date,
        folderNumber,
        'File$folderNumber',
        imageUrl);
  }
}
