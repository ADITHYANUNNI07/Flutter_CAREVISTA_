import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:carevista_ver05/Helper/helper_function.dart';
import 'package:carevista_ver05/SCREEN/addons/patientrecord.dart';
import 'package:carevista_ver05/Service/database_service.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:carevista_ver05/utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class RecordDetails extends StatefulWidget {
  RecordDetails({
    super.key,
    required this.folderName,
    required this.date,
    required this.folderCreatedate,
    required this.imageNo,
    required this.pdfNo,
    required this.remark,
    required this.fileurl1,
    required this.fileurl2,
    required this.fileurl3,
    required this.fileurl4,
    required this.fileurl5,
    required this.fileurl6,
    required this.fileurl7,
    required this.fileurl8,
    required this.fileurl9,
    required this.fileurl10,
  });
  String folderName;
  String date;
  String folderCreatedate;
  String imageNo;
  String pdfNo;
  String remark;
  String fileurl1;
  String fileurl2;
  String fileurl3;
  String fileurl4;
  String fileurl5;
  String fileurl6;
  String fileurl7;
  String fileurl8;
  String fileurl9;
  String fileurl10;
  @override
  State<RecordDetails> createState() => _RecordDetailsState();
}

File? pdffile;
File? image;
String userName = "";
String email = "";
String uid = "";
String phoneNo = "";
String imageUrl = "";
String FileUrl = "";
bool uploadfile = false;
bool imagEmty = false;
String imageNumber = '';
String pdfNumber = '';
bool fileUpload = false;

class _RecordDetailsState extends State<RecordDetails> {
  @override
  void initState() {
    super.initState();
    gettingUserData();
    imageNumber = widget.imageNo;
    pdfNumber = widget.pdfNo;
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
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
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
                          child: imageNumber == '5' && pdfNumber == '11'
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
                                            style:
                                                TextStyle(color: Colors.white),
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
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft: Radius
                                                              .circular(10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10),
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10))),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText2),
                                                      const SizedBox(
                                                          height: 30),
                                                      imageNumber == '5'
                                                          ? Container()
                                                          : GestureDetector(
                                                              onTap: () async {
                                                                //image
                                                                image =
                                                                    await pickImage(
                                                                        context);
                                                                setState(() {
                                                                  fileUpload =
                                                                      false;
                                                                });

                                                                // ignore: use_build_context_synchronously
                                                                newshowSnackbar(
                                                                    context,
                                                                    'Upload Image',
                                                                    'Please..! upload the image',
                                                                    ContentType
                                                                        .warning);
                                                                setState(() {
                                                                  imagEmty =
                                                                      true;
                                                                });
                                                              },
                                                              child: Container(
                                                                width: 260,
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(5),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color: Colors
                                                                        .grey
                                                                        .shade200),
                                                                child: Row(
                                                                  // ignore: prefer_const_literals_to_create_immutables
                                                                  children: [
                                                                    const Icon(
                                                                      Icons
                                                                          .photo_outlined,
                                                                      size: 40,
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            5),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      // ignore: prefer_const_literals_to_create_immutables

                                                                      children: [
                                                                        const Text(
                                                                          'Image',
                                                                          style: TextStyle(
                                                                              fontSize: 19,
                                                                              fontFamily: 'brandon_H'),
                                                                        ),
                                                                        Text(
                                                                          'Select image one by one',
                                                                          style: Theme.of(context)
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
                                                                            padding: const EdgeInsets.symmetric(
                                                                                vertical:
                                                                                    10),
                                                                            foregroundColor: Colors
                                                                                .white,
                                                                            backgroundColor: const Color(
                                                                                0XFF407BFF)),
                                                                        onPressed:
                                                                            () async {
                                                                          if (imagEmty ==
                                                                              true) {
                                                                            setState(() {
                                                                              _isLoding = true;
                                                                            });
                                                                            if (image ==
                                                                                null)
                                                                              return;
                                                                            String
                                                                                uuid =
                                                                                const Uuid().v4();
                                                                            Reference
                                                                                referenceRoot =
                                                                                FirebaseStorage.instance.ref();
                                                                            Reference
                                                                                referenceDirImages =
                                                                                referenceRoot.child('user/PatientRecord/$uuid');

                                                                            //Create a reference for the image to be stored
                                                                            Reference
                                                                                referenceImageToUpload =
                                                                                referenceDirImages.child('${uuid}image$imageNumber');

                                                                            //Handle errors/success
                                                                            try {
                                                                              //Store the file
                                                                              await referenceImageToUpload.putFile(File(image!.path));
                                                                              imageUrl = await referenceImageToUpload.getDownloadURL();
                                                                            } catch (error) {
                                                                              //Some error occurred
                                                                            }
                                                                            if (imageUrl.isEmpty) {
                                                                              newshowSnackbar(context, 'Failed', 'Please try again...That image  is not upload..', ContentType.failure);
                                                                              setState(() {
                                                                                _isLoding = false;
                                                                              });
                                                                            } else {
                                                                              uplodDBImage();
                                                                              // ignore: use_build_context_synchronously
                                                                              newshowSnackbar(context, 'Upload Successfully', 'Image  Upload Successfully', ContentType.success);
                                                                              nextScreenReplace(context, PatientRecord());
                                                                              setState(() {
                                                                                _isLoding = false;
                                                                              });
                                                                            }
                                                                          } else {
                                                                            newshowSnackbar(
                                                                                context,
                                                                                'Warning',
                                                                                'please select image',
                                                                                ContentType.warning);
                                                                          }
                                                                        },
                                                                        child:
                                                                            const Icon(
                                                                          Icons
                                                                              .cloud_upload,
                                                                          size:
                                                                              20,
                                                                        )),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                      const SizedBox(
                                                          height: 20),
                                                      pdfNumber == '11'
                                                          ? Container()
                                                          : GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  fileUpload =
                                                                      true;
                                                                });
                                                                //pdf
                                                                getPdf();
                                                              },
                                                              child: Container(
                                                                width: 260,
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(5),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color: Colors
                                                                        .grey
                                                                        .shade200),
                                                                child: Row(
                                                                  // ignore: prefer_const_literals_to_create_immutables
                                                                  children: [
                                                                    const Icon(
                                                                      Icons
                                                                          .picture_as_pdf,
                                                                      size: 40,
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            5),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      // ignore: prefer_const_literals_to_create_immutables

                                                                      children: [
                                                                        const Text(
                                                                          'Pdf',
                                                                          style: TextStyle(
                                                                              fontSize: 19,
                                                                              fontFamily: 'brandon_H'),
                                                                        ),
                                                                        Text(
                                                                          'Select Pdf one by one',
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyText1,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            19),
                                                                    ElevatedButton(
                                                                        style: ElevatedButton.styleFrom(
                                                                            side: BorderSide
                                                                                .none,
                                                                            shape:
                                                                                const CircleBorder(),
                                                                            padding: const EdgeInsets.symmetric(
                                                                                vertical:
                                                                                    10),
                                                                            foregroundColor: Colors
                                                                                .white,
                                                                            backgroundColor: Color(
                                                                                0XFF407BFF)),
                                                                        onPressed:
                                                                            () async {
                                                                          setState(
                                                                              () {
                                                                            _isLoding =
                                                                                true;
                                                                          });
                                                                          final pdfName =
                                                                              '${userName}pdf$pdfNumber';
                                                                          final ref = FirebaseStorage
                                                                              .instance
                                                                              .ref()
                                                                              .child('user/PatientRecord/${widget.folderName}/$pdfName');
                                                                          final uploadTask =
                                                                              ref.putFile(pdffile!);
                                                                          final snapshot =
                                                                              await uploadTask;
                                                                          FileUrl = await snapshot
                                                                              .ref
                                                                              .getDownloadURL();
                                                                          print(
                                                                              FileUrl);
                                                                          if (FileUrl
                                                                              .isEmpty) {
                                                                            setState(() {
                                                                              _isLoding = false;
                                                                            });
                                                                            newshowSnackbar(
                                                                                context,
                                                                                'Warning',
                                                                                'please select PDF',
                                                                                ContentType.warning);
                                                                          } else {
                                                                            uploadDBFile();
                                                                            nextScreenReplace(context,
                                                                                PatientRecord());
                                                                            setState(() {
                                                                              _isLoding = false;
                                                                            });
                                                                            newshowSnackbar(
                                                                                context,
                                                                                'Upload Successfully',
                                                                                'PDF  Upload Successfully',
                                                                                ContentType.success);
                                                                          }
                                                                        },
                                                                        child:
                                                                            const Icon(
                                                                          Icons
                                                                              .cloud_upload,
                                                                          size:
                                                                              20,
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
                        ),
                        const SizedBox(height: 15),
                        widget.fileurl1.isNotEmpty
                            ? GestureDetector(
                                onTap: () async {
                                  if (await canLaunch(widget.fileurl1)) {
                                    await launch(widget.fileurl1);
                                  } else {
                                    throw 'Could not launch ${widget.fileurl1}';
                                  }
                                },
                                child: Image(
                                  image: Image.network(
                                    widget.fileurl1,
                                  ).image,
                                ),
                              )
                            : Container(),
                        const SizedBox(height: 15),
                        widget.fileurl2.isNotEmpty
                            ? GestureDetector(
                                onTap: () async {
                                  if (await canLaunch(widget.fileurl2)) {
                                    await launch(widget.fileurl2);
                                  } else {
                                    throw 'Could not launch${widget.fileurl2}';
                                  }
                                },
                                child: Image(
                                  image: Image.network(
                                    widget.fileurl2,
                                  ).image,
                                ),
                              )
                            : Container(),
                        const SizedBox(height: 15),
                        widget.fileurl3.isNotEmpty
                            ? GestureDetector(
                                onTap: () async {
                                  if (await canLaunch(widget.fileurl3)) {
                                    await launch(widget.fileurl3);
                                  } else {
                                    throw 'Could not launch ${widget.fileurl3}';
                                  }
                                },
                                child: Image(
                                  image: Image.network(
                                    widget.fileurl3,
                                  ).image,
                                ),
                              )
                            : Container(),
                        const SizedBox(height: 15),
                        widget.fileurl4.isNotEmpty
                            ? GestureDetector(
                                onTap: () async {
                                  if (await canLaunch(widget.fileurl4)) {
                                    await launch(widget.fileurl4);
                                  } else {
                                    throw 'Could not launch ${widget.fileurl4}';
                                  }
                                },
                                child: Image(
                                  image: Image.network(
                                    widget.fileurl4,
                                  ).image,
                                ),
                              )
                            : Container(),
                        const SizedBox(height: 15),
                        widget.fileurl5.isNotEmpty
                            ? GestureDetector(
                                onTap: () async {
                                  if (await canLaunch(widget.fileurl5)) {
                                    await launch(widget.fileurl5);
                                  } else {
                                    throw 'Could not launch ${widget.fileurl5}';
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  height: 50,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      color: Color(0XFF407BFF),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10))),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Download PDF',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Expanded(child: Container()),
                                      const Icon(Icons.picture_as_pdf,
                                          color: Colors.white),
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                        const SizedBox(height: 15),
                        widget.fileurl6.isNotEmpty
                            ? GestureDetector(
                                onTap: () async {
                                  if (await canLaunch(widget.fileurl6)) {
                                    await launch(widget.fileurl6);
                                  } else {
                                    throw 'Could not launch ${widget.fileurl5}';
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  height: 50,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      color: Color(0XFF407BFF),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10))),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Download PDF',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Expanded(child: Container()),
                                      const Icon(Icons.picture_as_pdf,
                                          color: Colors.white),
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                        const SizedBox(height: 15),
                        widget.fileurl7.isNotEmpty
                            ? GestureDetector(
                                onTap: () async {
                                  if (await canLaunch(widget.fileurl7)) {
                                    await launch(widget.fileurl7);
                                  } else {
                                    throw 'Could not launch ${widget.fileurl7}';
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  height: 50,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      color: Color(0XFF407BFF),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10))),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Download PDF',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Expanded(child: Container()),
                                      const Icon(Icons.picture_as_pdf,
                                          color: Colors.white),
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                        const SizedBox(height: 15),
                        widget.fileurl8.isNotEmpty
                            ? GestureDetector(
                                onTap: () async {
                                  if (await canLaunch(widget.fileurl8)) {
                                    await launch(widget.fileurl8);
                                  } else {
                                    throw 'Could not launch ${widget.fileurl8}';
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  height: 50,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      color: Color(0XFF407BFF),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10))),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Download PDF',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Expanded(child: Container()),
                                      const Icon(Icons.picture_as_pdf,
                                          color: Colors.white),
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                        const SizedBox(height: 15),
                        widget.fileurl9.isNotEmpty
                            ? GestureDetector(
                                onTap: () async {
                                  if (await canLaunch(widget.fileurl9)) {
                                    await launch(widget.fileurl9);
                                  } else {
                                    throw 'Could not launch ${widget.fileurl9}';
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  height: 50,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      color: Color(0XFF407BFF),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10))),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Download PDF',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Expanded(child: Container()),
                                      const Icon(Icons.picture_as_pdf,
                                          color: Colors.white),
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                        const SizedBox(height: 15),
                        widget.fileurl10.isNotEmpty
                            ? GestureDetector(
                                onTap: () async {
                                  if (await canLaunch(widget.fileurl10)) {
                                    await launch(widget.fileurl10);
                                  } else {
                                    throw 'Could not launch ${widget.fileurl10}';
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  height: 50,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      color: Color(0XFF407BFF),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10))),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Download PDF',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Expanded(child: Container()),
                                      const Icon(Icons.picture_as_pdf,
                                          color: Colors.white),
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  Future<void> getPdf() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null && result.files.isNotEmpty) {
      final pdf = result.files.single;
      setState(() {
        pdffile = File(pdf.path!);
      });
    }
  }

  uplodDBImage() async {
    if (imageNumber == '1') {
      setState(() {
        imageNumber = '2';
      });
    } else if (imageNumber == '2') {
      setState(() {
        imageNumber = '3';
      });
    } else if (imageNumber == '3') {
      setState(() {
        imageNumber = '4';
      });
    } else if (imageNumber == '4') {
      setState(() {
        imageNumber = '5';
      });
    }

    await DatabaseService(uid: uid).updateFolderDB(
        widget.folderName,
        widget.folderName,
        widget.remark,
        widget.date,
        imageNumber,
        pdfNumber,
        'File$imageNumber',
        imageUrl);
  }

  uploadDBFile() async {
    if (pdfNumber == '5') {
      setState(() {
        pdfNumber = '6';
      });
    } else if (pdfNumber == '6') {
      setState(() {
        pdfNumber = '7';
      });
    } else if (pdfNumber == '7') {
      setState(() {
        pdfNumber = '8';
      });
    } else if (pdfNumber == '8') {
      setState(() {
        pdfNumber = '9';
      });
    } else if (pdfNumber == '9') {
      setState(() {
        pdfNumber = '10';
      });
    } else if (pdfNumber == '10') {
      setState(() {
        pdfNumber = '11';
      });
    }
    await DatabaseService(uid: uid).updateFolderDB(
        widget.folderName,
        widget.folderName,
        widget.remark,
        widget.date,
        imageNumber,
        pdfNumber,
        'File$pdfNumber',
        FileUrl);
  }
}
