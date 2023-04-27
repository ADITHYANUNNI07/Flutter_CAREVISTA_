import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:carevista_ver05/admin/addHospital.dart';
import 'package:carevista_ver05/main.dart';
import 'package:carevista_ver05/utils/utils.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:humanitarian_icons/humanitarian_icons.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

enum DistrictEnum {
  tvm,
  klm,
  ala,
  kott,
  path,
  iduk,
  erna,
  thri,
  pala,
  mala,
  kozhi,
  waya,
  kann,
  kasa
}

class EditHospital extends StatefulWidget {
  const EditHospital(
      {super.key,
      required this.hospitalname,
      required this.govtorprivate,
      required this.type,
      required this.establisedyear,
      required this.affilicated,
      required this.emergency,
      required this.location,
      required this.latitude,
      required this.longitude,
      required this.district,
      required this.address,
      required this.highlight,
      required this.phonenumber,
      required this.time,
      required this.surround1,
      required this.surroundDistance1,
      required this.surroundTime1,
      required this.surround2,
      required this.surroundDistance2,
      required this.surroundTime2,
      required this.doctorname,
      required this.specialist,
      required this.nearhospital1,
      required this.nearhospital2,
      required this.nearhospital3,
      required this.nodoctor,
      required this.noambulance,
      required this.nobed,
      required this.hospitallink,
      required this.overview,
      required this.service,
      required this.logo,
      required this.image1,
      required this.image2,
      required this.image3,
      required this.image4,
      required this.image5,
      required this.doctorspecialistno});
  final String hospitalname;
  final String govtorprivate;
  final String type;
  final int doctorspecialistno;
  final String establisedyear;
  final String affilicated;
  final String emergency;
  final String location;
  final String latitude;
  final String longitude;
  final String district;
  final String address;
  final String highlight;
  final String phonenumber;
  final String time;
  final String surround1;
  final String surroundDistance1;
  final String surroundTime1;
  final String surround2;
  final String surroundDistance2;
  final String surroundTime2;
  final List<String> doctorname;
  final List<String> specialist;
  final String nearhospital1;
  final String nearhospital2;
  final String nearhospital3;
  final String nodoctor;
  final String noambulance;
  final String nobed;
  final String hospitallink;
  final String overview;
  final String service;
  final String logo;
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final String image5;
  @override
  State<EditHospital> createState() => _EditHospitalState();
}

class _EditHospitalState extends State<EditHospital> {
  final List<TextEditingController> _DoctorName = [];
  final List<TextEditingController> _Specialist = [];
  final List<TextEditingController> _DoctorPhoto = [];
  final fromKey = GlobalKey<FormState>();
  TimeOfDay pickedTime = TimeOfDay(hour: 8, minute: 30);
  String hospitalname = "";
  String lat = '';
  String long = "";
  String district = "";
  String location = "";
  DistrictEnum? _districtEnum;
  String phone = "";
  String highlight = "";
  double addtimeSize = 0;
  String address = '';
  String email = "";
  String startTime = "";
  String lastTime = "";
  String noDoctors = "";
  bool isVisible = false;
  bool addTime = false;
  String time = "";
  String hospitalsite = "";
  String quali = "";
  String noambulance = "";
  String establisedYr = "";
  String bed = "";
  String _time = "";
  String gp = "";
  String _gp = "";
  String _emergency = "";
  String type = "";
  String affUniversity = "";
  String emergency = "";
  String overview = "";
  String surround1 = "";
  String surroundDistance1 = "";
  String surroundTime1 = "";
  String surround2 = "";
  String surroundDistance2 = "";
  String surroundTime2 = "";
  double count = -1;
  String logoUrl = "";
  String image1Url = "";
  String image2Url = "";
  String image3Url = "";
  String image4Url = "";
  String image5Url = "";
  String nearhospital1 = '';
  String nearhospital2 = '';
  String nearhospital3 = '';
  bool imagebool = false;
  bool imagebool1 = false;
  bool imagebool2 = false;
  bool imagebool3 = false;
  bool imagebool4 = false;
  bool imagebool5 = false;
  File? hospitalimage1;
  File? hospitalimage2;
  File? hospitalimage3;
  File? hospitalimage4;
  File? hospitalimage5;
  File? file;
  String services = '';

  TextEditingController timeinput = TextEditingController();
  TextEditingController timeinputlast = TextEditingController();
  void initState() {
    timeinput.text = ""; // set the initial value of text field
    super.initState();
    int listLength = widget.doctorname.length; // get the length of the lists
    for (int i = 0; i < listLength; i++) {
      if (i < widget.doctorspecialistno) {
        _DoctorName.add(TextEditingController(
            text: widget
                .doctorname[i])); // Set initial value from widget.doctorname
        _Specialist.add(TextEditingController(
            text: widget
                .specialist[i])); // Set initial value from widget.specialist
        count = (listLength.toDouble() - 1);
        print(count);
      } else {
        // If the index is greater than or equal to widget.doctorspecialistno,
        // add empty controllers to _DoctorName and _Specialist lists
        _DoctorName.add(TextEditingController());
        _Specialist.add(TextEditingController());
      }
    }
  }

  addDoctorDetails() {
    setState(() {
      _DoctorName.add(TextEditingController());
      _Specialist.add(TextEditingController());
      _DoctorPhoto.add(TextEditingController());
      count++;
    });
  }

  removeDoctorDetails(i) {
    setState(() {
      _DoctorName.removeAt(i);
      _Specialist.removeAt(i);

      count--;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            'Add Hospital Details',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'brandon_H',
                color: Theme.of(context).primaryColorDark),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: imagebool == false
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(widget.logo),
                            )
                          : CircleAvatar(
                              backgroundImage: FileImage(file!),
                              radius: 50,
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
                                if (hospitalname.isEmpty) {
                                  newshowSnackbar(
                                      context,
                                      'Warning',
                                      'please fill the hospital Name',
                                      ContentType.warning);
                                } else {
                                  file = await pickImage(context);
                                  setState(() {
                                    imagebool = true;
                                  });
                                  if (file == null) return;

                                  Reference referenceRoot =
                                      FirebaseStorage.instance.ref();
                                  Reference referenceDirImages =
                                      referenceRoot.child(
                                          'hospital images/$hospitalname/logo');

                                  //Create a reference for the image to be stored
                                  Reference referenceImageToUpload =
                                      referenceDirImages
                                          .child('${hospitalname}logo');

                                  //Handle errors/success
                                  try {
                                    //Store the file
                                    await referenceImageToUpload
                                        .putFile(File(file!.path));
                                    logoUrl = await referenceImageToUpload
                                        .getDownloadURL();
                                  } catch (error) {
                                    //Some error occurred
                                  }
                                  if (logoUrl.isEmpty) {
                                    newshowSnackbar(
                                        context,
                                        'Failed',
                                        'Please try again...That logo is not upload..',
                                        ContentType.failure);
                                  } else {
                                    newshowSnackbar(
                                        context,
                                        'Upload Successfully',
                                        'Hospital Logo Upload Successfully',
                                        ContentType.success);
                                  }
                                }
                              },
                              icon: const Icon(
                                LineAwesomeIcons.camera,
                                color: Colors.white,
                              )),
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
                            initialValue: widget.hospitalname,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                    LineAwesomeIcons.hospital_symbol),
                                labelText: 'Hospital Name',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100))),
                            onChanged: (val) {
                              hospitalname = val;
                            },
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter Hospital Name";
                              } else {
                                return RegExp(
                                            r'[!@#<>?:_`"~;[\]\\|=+)(*&^%0-9-]')
                                        .hasMatch(val)
                                    ? "Please enter valid Hospital Name"
                                    : null;
                              }
                            }),
                        const SizedBox(height: 10),
                        Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 105,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).cardColor),
                            child: Column(children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                      child: Text(
                                    'Govt Or Private',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  )),
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
                                            TimeWidget(
                                                time: "Private",
                                                radioBtn: Radio(
                                                  value: 'Private',
                                                  groupValue: _gp,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _gp = value!;
                                                      gp = "Private";
                                                    });
                                                  },
                                                )),
                                            const SizedBox(width: 10),
                                            TimeWidget(
                                                time: "Govt",
                                                radioBtn: Radio(
                                                  value: 'Govt',
                                                  groupValue: _gp,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _gp = value!;
                                                      gp = "Govt.";
                                                    });
                                                  },
                                                ))
                                          ]))),
                            ])),
                        const SizedBox(height: 10),
                        TextFormFieldOvalEditWidget(
                            intialvalue: widget.type,
                            labelText: "Type",
                            onChange: (value) {
                              type = value;
                            },
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter Hospital type";
                              } else {
                                return null;
                              }
                            },
                            icon: Icons.type_specimen_outlined),
                        const SizedBox(height: 10),
                        TextFormFieldOvalNumberEditWidget(
                            intialvalue: widget.establisedyear,
                            labelText: 'Established Year',
                            onChange: (value) {
                              establisedYr = value;
                            },
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Please Established Year';
                              } else {
                                return null;
                              }
                            },
                            icon: LineAwesomeIcons.hospital_1),
                        const SizedBox(height: 10),
                        TextFormFieldOvalEditWidget(
                            intialvalue: widget.affilicated,
                            labelText: "Affiliated university",
                            onChange: (value) {
                              affUniversity = value;
                            },
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Please Affiliated university';
                              } else {
                                return null;
                              }
                            },
                            icon: HumanitarianIcons.university),
                        const SizedBox(height: 10),
                        Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 105,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).cardColor),
                            child: Column(children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                      child: Text(
                                    'Emergency department',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  )),
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
                                            TimeWidget(
                                                time: "Yes",
                                                radioBtn: Radio(
                                                  value: 'yes',
                                                  groupValue: _emergency,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _emergency = value!;
                                                      emergency = "Yes";
                                                    });
                                                  },
                                                )),
                                            const SizedBox(width: 10),
                                            TimeWidget(
                                                time: "NO",
                                                radioBtn: Radio(
                                                  value: 'No',
                                                  groupValue: _emergency,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _emergency = value!;
                                                      emergency = "No";
                                                    });
                                                  },
                                                ))
                                          ]))),
                            ])),
                        const SizedBox(height: 10),
                        TextFormFieldOvalEditWidget(
                            intialvalue: widget.location,
                            labelText: 'Location',
                            onChange: (value) {
                              location = value;
                            },
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Please Established Year';
                              } else {
                                return null;
                              }
                            },
                            icon: Icons.location_on),
                        const SizedBox(height: 15),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 20, left: 10, right: 10),
                          width: double.infinity,
                          height: 280,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).cardColor),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                      child: Text(
                                    'Latitude & Longitude',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  )),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                      child: TextFormFieldOvalEditWidget(
                                          intialvalue: widget.latitude,
                                          labelText: 'Latitude',
                                          onChange: (value) {
                                            lat = value;
                                          },
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return "Enter Latitude";
                                            } else {}
                                          },
                                          icon: Icons.place_outlined))
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                      child: TextFormFieldOvalEditWidget(
                                          intialvalue: widget.longitude,
                                          labelText: 'Longitude',
                                          onChange: (value) {
                                            long = value;
                                          },
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return "Enter Latitude";
                                            } else {}
                                          },
                                          icon: Icons.place_outlined))
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          height: 105,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).cardColor),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                      child: Text(
                                    'District',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  )),
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
                                      DistrictWidget(
                                          districtName: 'TRIVANDRUM',
                                          radioBtn: Radio(
                                            value: DistrictEnum.tvm,
                                            groupValue: _districtEnum,
                                            onChanged: (value) {
                                              setState(() {
                                                district = 'Trivandrum';
                                                _districtEnum = value;
                                              });
                                            },
                                          )),
                                      const SizedBox(width: 5),
                                      DistrictWidget(
                                          districtName: 'KOLLAM',
                                          radioBtn: Radio(
                                            value: DistrictEnum.klm,
                                            groupValue: _districtEnum,
                                            onChanged: (value) {
                                              setState(() {
                                                district = 'Kollam';
                                                _districtEnum = value;
                                              });
                                            },
                                          )),
                                      const SizedBox(width: 5),
                                      DistrictWidget(
                                          districtName: 'PATHANAMTHITTA',
                                          radioBtn: Radio(
                                            value: DistrictEnum.path,
                                            groupValue: _districtEnum,
                                            onChanged: (value) {
                                              setState(() {
                                                _districtEnum = value;
                                                district = 'Pathanamthitta';
                                              });
                                            },
                                          )),
                                      const SizedBox(width: 5),
                                      DistrictWidget(
                                          districtName: 'ALAPPUZHA',
                                          radioBtn: Radio(
                                            value: DistrictEnum.ala,
                                            groupValue: _districtEnum,
                                            onChanged: (value) {
                                              setState(() {
                                                _districtEnum = value;
                                                district = 'Alappuzha';
                                              });
                                            },
                                          )),
                                      const SizedBox(width: 5),
                                      DistrictWidget(
                                          districtName: 'KOTTAYAM',
                                          radioBtn: Radio(
                                            value: DistrictEnum.kott,
                                            groupValue: _districtEnum,
                                            onChanged: (value) {
                                              setState(() {
                                                _districtEnum = value;
                                                district = 'Kottayam';
                                              });
                                            },
                                          )),
                                      const SizedBox(width: 5),
                                      DistrictWidget(
                                          districtName: 'IDUKKI',
                                          radioBtn: Radio(
                                            value: DistrictEnum.iduk,
                                            groupValue: _districtEnum,
                                            onChanged: (value) {
                                              setState(() {
                                                _districtEnum = value;
                                                district = 'Idukki';
                                              });
                                            },
                                          )),
                                      const SizedBox(width: 5),
                                      DistrictWidget(
                                          districtName: 'ERNAKULAM',
                                          radioBtn: Radio(
                                            value: DistrictEnum.erna,
                                            groupValue: _districtEnum,
                                            onChanged: (value) {
                                              setState(() {
                                                _districtEnum = value;
                                                district = 'Ernakulam';
                                              });
                                            },
                                          )),
                                      const SizedBox(width: 5),
                                      DistrictWidget(
                                          districtName: 'THRISSUR',
                                          radioBtn: Radio(
                                            value: DistrictEnum.thri,
                                            groupValue: _districtEnum,
                                            onChanged: (value) {
                                              setState(() {
                                                _districtEnum = value;
                                                district = 'Thrissur';
                                              });
                                            },
                                          )),
                                      const SizedBox(width: 5),
                                      DistrictWidget(
                                          districtName: 'PALAKKAD',
                                          radioBtn: Radio(
                                            value: DistrictEnum.pala,
                                            groupValue: _districtEnum,
                                            onChanged: (value) {
                                              setState(() {
                                                _districtEnum = value;
                                                district = 'Palakkad';
                                              });
                                            },
                                          )),
                                      const SizedBox(width: 5),
                                      DistrictWidget(
                                          districtName: 'MALAPPURAM',
                                          radioBtn: Radio(
                                            value: DistrictEnum.mala,
                                            groupValue: _districtEnum,
                                            onChanged: (value) {
                                              setState(() {
                                                _districtEnum = value;
                                                district = 'Malappuram';
                                              });
                                            },
                                          )),
                                      const SizedBox(width: 5),
                                      DistrictWidget(
                                          districtName: 'KOZHIKODE',
                                          radioBtn: Radio(
                                            value: DistrictEnum.kozhi,
                                            groupValue: _districtEnum,
                                            onChanged: (value) {
                                              setState(() {
                                                _districtEnum = value;
                                                district = 'Kozhikode';
                                              });
                                            },
                                          )),
                                      const SizedBox(width: 5),
                                      DistrictWidget(
                                          districtName: 'WAYANAD',
                                          radioBtn: Radio(
                                            value: DistrictEnum.waya,
                                            groupValue: _districtEnum,
                                            onChanged: (value) {
                                              setState(() {
                                                _districtEnum = value;
                                                district = 'Wayanad';
                                              });
                                            },
                                          )),
                                      const SizedBox(width: 5),
                                      DistrictWidget(
                                          districtName: 'KANNUR',
                                          radioBtn: Radio(
                                            value: DistrictEnum.kann,
                                            groupValue: _districtEnum,
                                            onChanged: (value) {
                                              setState(() {
                                                _districtEnum = value;
                                                district = 'Kannur';
                                              });
                                            },
                                          )),
                                      const SizedBox(width: 5),
                                      DistrictWidget(
                                          districtName: 'KASARAGOD',
                                          radioBtn: Radio(
                                            value: DistrictEnum.kasa,
                                            groupValue: _districtEnum,
                                            onChanged: (value) {
                                              setState(() {
                                                _districtEnum = value;
                                                district = 'Kasaragod';
                                              });
                                            },
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormFieldOvalEditWidget(
                            intialvalue: widget.address,
                            labelText: 'Address',
                            onChange: (value) {
                              address = value;
                            },
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter hospital Address";
                              } else {
                                return null;
                              }
                            },
                            icon: LineAwesomeIcons.address_card),
                        const SizedBox(height: 10),
                        TextFormFieldOvalEditWidget(
                            intialvalue: widget.highlight,
                            labelText: 'Highlight',
                            onChange: (value) {
                              highlight = value;
                            },
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter one hospital Highlight";
                              } else {
                                return null;
                              }
                            },
                            icon: Icons.highlight_alt),
                        const SizedBox(height: 10),
                        TextFormFieldOvalNumberEditWidget(
                            intialvalue: widget.phonenumber,
                            onChange: (val) {
                              phone = val;
                            },
                            validator: (val) {
                              return RegExp(r"(^(?:[+0]9)?[0-9]{10,12}$)")
                                      .hasMatch(val!)
                                  ? null
                                  : "Please enter valid mobile number";
                            },
                            labelText: 'Phone Number',
                            icon: Icons.phone_enabled_outlined),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          height: isVisible ? 200 + addtimeSize : 129,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).cardColor),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                      child: Text(
                                    'Time',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  )),
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
                                      TimeWidget(
                                          time: 'Open 24 x 7',
                                          radioBtn: Radio(
                                            value: 'Open 24 x 7',
                                            groupValue: _time,
                                            onChanged: (value) {
                                              setState(() {
                                                _time = value!;
                                                time = _time;
                                                print(time);
                                                isVisible = false;
                                              });
                                            },
                                          )),
                                      const SizedBox(width: 5),
                                      TimeWidget(
                                          time: 'Other',
                                          radioBtn: Radio(
                                            value: 'other',
                                            groupValue: _time,
                                            onChanged: (value) {
                                              setState(() {
                                                isVisible = true;
                                                _time = value!;
                                                print(_time);
                                              });
                                            },
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                margin: const EdgeInsets.only(top: 0, left: 0),
                                child: Visibility(
                                  visible: isVisible,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 308,
                                        child: TextFormField(
                                          controller: timeinput,
                                          readOnly: true,
                                          onTap: () async {
                                            await showTimePicker(
                                              initialTime: TimeOfDay.now(),
                                              context: context,
                                            ).then((value) {
                                              setState(() {
                                                pickedTime = value!;
                                              });
                                            });

                                            if (pickedTime != null) {
                                              setState(() {
                                                timeinput.text =
                                                    pickedTime.format(context);
                                                time = "Open " + timeinput.text;
                                                print(time);
                                              });
                                            } else {
                                              print("Time is not selected");
                                            }
                                          },
                                          decoration: const InputDecoration(
                                            prefixIcon:
                                                Icon(LineAwesomeIcons.clock),
                                            labelText: 'Open Time',
                                            border: OutlineInputBorder(),
                                          ),
                                          validator: (value) {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 420,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).cardColor),
                            child: Column(children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                      child: Text(
                                    'Surroundings',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  )),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                      child: TextFormFieldOvalEditWidget(
                                          intialvalue: widget.surround1,
                                          labelText: 'Surrounding Place 1',
                                          onChange: (value) {
                                            surround1 = value;
                                          },
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return "Enter Surroundings Place ";
                                            } else {
                                              return RegExp(
                                                          r'[!@#<>?:_`"~;[\]\\|=+)(*&^%0-9-]')
                                                      .hasMatch(val)
                                                  ? "Please enter Surroundings Place"
                                                  : null;
                                            }
                                          },
                                          icon: Icons.place_outlined))
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                      child: TextFormFieldOvalEditWidget(
                                          intialvalue: widget.surroundDistance1,
                                          labelText: 'Distance',
                                          onChange: (value) {
                                            surroundDistance1 = value;
                                          },
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return "Enter Distance";
                                            } else {
                                              return null;
                                            }
                                          },
                                          icon: Icons.place_outlined)),
                                  const SizedBox(width: 5),
                                  Flexible(
                                      child: TextFormFieldOvalEditWidget(
                                          intialvalue: widget.surroundTime1,
                                          labelText: 'Time',
                                          onChange: (value) {
                                            surroundTime1 = value;
                                          },
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return "Enter time";
                                            } else {
                                              return null;
                                            }
                                          },
                                          icon: Icons.timer_outlined))
                                ],
                              ),
                              const SizedBox(height: 25),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                      child: TextFormFieldOvalEditWidget(
                                          intialvalue: widget.surround2,
                                          labelText: 'Surrounding Place 2',
                                          onChange: (value) {
                                            surround2 = value;
                                          },
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return "Enter Surroundings Place";
                                            } else {
                                              return null;
                                            }
                                          },
                                          icon: Icons.place_outlined))
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                      child: TextFormFieldOvalEditWidget(
                                          intialvalue: widget.surroundDistance2,
                                          labelText: 'Distance',
                                          onChange: (value) {
                                            surroundDistance2 = value;
                                          },
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return "Enter Distance";
                                            } else {
                                              return null;
                                            }
                                          },
                                          icon: Icons.place_outlined)),
                                  const SizedBox(width: 5),
                                  Flexible(
                                      child: TextFormFieldOvalEditWidget(
                                          intialvalue: widget.surroundTime2,
                                          labelText: 'Time',
                                          onChange: (value) {
                                            surroundTime2 = value;
                                          },
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return "Enter Time";
                                            } else {
                                              return null;
                                            }
                                          },
                                          icon: Icons.timer_outlined))
                                ],
                              ),
                            ])),
                        const SizedBox(height: 10),
                        Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 320 + (230 * count),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).cardColor),
                            child: Column(children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Row(
                                      children: [
                                        Text(
                                          'Doctors Name & Specialist',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                        IconButton(
                                            color: Colors.green,
                                            onPressed: () {
                                              addDoctorDetails();
                                            },
                                            icon: const Icon(Icons.add_circle))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              for (int i = 0; i < _DoctorName.length; i++)
                                Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      width: double.infinity,
                                      height: 220,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: MyApp.themeNotifier.value ==
                                                ThemeMode.light
                                            ? Colors.white
                                            : Colors.black45,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Row(
                                              children: [
                                                Expanded(child: Container()),
                                                IconButton(
                                                  onPressed: () {
                                                    removeDoctorDetails(i);
                                                  },
                                                  icon: const Icon(
                                                    color: Colors.redAccent,
                                                    Icons.remove_circle,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Row(
                                              children: [
                                                Flexible(
                                                  child:
                                                      TextFormFieldOvalControllerWidget(
                                                    // Fix: Access element using index
                                                    labelText: 'Doctor Name',
                                                    controller: _DoctorName[i],
                                                    validator: (val) {
                                                      if (val!.isEmpty) {
                                                        return "Enter Doctor Name";
                                                      } else {
                                                        return RegExp(
                                                                    r'[!@#<>?:_`"~;[\]\\|=+)(*&^%0-9-]')
                                                                .hasMatch(val)
                                                            ? "Please enter Doctor Name"
                                                            : null;
                                                      }
                                                    },
                                                    icon: LineAwesomeIcons
                                                        .stethoscope,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Flexible(
                                            child: Column(
                                              children: [
                                                Flexible(
                                                  child:
                                                      TextFormFieldOvalControllerWidget(
                                                    // Fix: Access element using index
                                                    controller: _Specialist[i],
                                                    labelText: 'Specialist',
                                                    validator: (val) {
                                                      if (val!.isEmpty) {
                                                        return "Enter Specialist";
                                                      } else {
                                                        return RegExp(
                                                                    r'[!@#<>?:_`"~;[\]\\|=+)(*&^%0-9-]')
                                                                .hasMatch(val)
                                                            ? "Please enter Specialist"
                                                            : null;
                                                      }
                                                    },
                                                    icon: Icons.folder_special,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                            ])),
                        const SizedBox(height: 10),
                        Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 327,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).cardColor),
                            child: Column(children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                      child: Text(
                                    'Nearby Hospitals',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  )),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                      child: TextFormFieldOvalEditWidget(
                                          intialvalue: widget.nearhospital1,
                                          labelText: 'Hospital 1',
                                          onChange: (value) {
                                            nearhospital1 = value;
                                          },
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return "Enter Hospital name";
                                            } else {}
                                          },
                                          icon: Icons.place_outlined))
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                      child: TextFormFieldOvalEditWidget(
                                          intialvalue: widget.nearhospital2,
                                          labelText: 'Hospital 2',
                                          onChange: (value) {
                                            nearhospital2 = value;
                                          },
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return "Enter Hospital name";
                                            } else {}
                                          },
                                          icon: Icons.place_outlined))
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                      child: TextFormFieldOvalEditWidget(
                                          intialvalue: widget.nearhospital3,
                                          labelText: 'Hospital 3',
                                          onChange: (value) {
                                            nearhospital3 = value;
                                          },
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return "Enter Hospital name";
                                            } else {}
                                          },
                                          icon: Icons.place_outlined))
                                ],
                              ),
                            ])),
                        const SizedBox(height: 15),
                        TextFormFieldOvalNumberEditWidget(
                            intialvalue: widget.nodoctor,
                            labelText: 'No of Doctors',
                            onChange: (value) {
                              noDoctors = value;
                            },
                            validator: (p0) {},
                            icon: LineAwesomeIcons.stethoscope),
                        const SizedBox(height: 10),
                        TextFormFieldOvalNumberEditWidget(
                            intialvalue: widget.nobed,
                            labelText: 'No of Bed',
                            onChange: (value) {
                              bed = value;
                            },
                            validator: (p0) {},
                            icon: LineAwesomeIcons.bed),
                        const SizedBox(height: 10),
                        TextFormFieldOvalNumberEditWidget(
                            intialvalue: widget.noambulance,
                            labelText: "Ambulances",
                            onChange: (value) {
                              noambulance = value;
                            },
                            validator: (p0) {},
                            icon: LineAwesomeIcons.ambulance),
                        const SizedBox(height: 10),
                        TextFormFieldOvalEditWidget(
                            intialvalue: widget.hospitallink,
                            labelText: "Hospital Site Link",
                            onChange: (value) {
                              hospitalsite = value;
                            },
                            validator: (p0) {},
                            icon: LineAwesomeIcons.hospital),
                        const SizedBox(height: 10),
                        TextFormFieldAreaEditWidget(
                            intialvalue: widget.overview,
                            labelText: "Overview",
                            onChange: (value) {
                              overview = value;
                            },
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Please  Enter Overview ';
                              } else {
                                return null;
                              }
                            },
                            icon: Icons.view_compact_alt_outlined),
                        const SizedBox(height: 10),
                        TextFormFieldAreaEditWidget(
                            intialvalue: widget.service,
                            labelText: "Services",
                            onChange: (value) {
                              services = value;
                            },
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Please  Enter Services ';
                              } else {
                                return null;
                              }
                            },
                            icon: HumanitarianIcons.services_and_tools),
                        const SizedBox(height: 15),
                        const SizedBox(height: 10),
                        Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 620,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).cardColor),
                            child: Column(children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                      child: Text(
                                    'Upload Hospital Images',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  )),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          width: double.infinity,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: MyApp.themeNotifier.value ==
                                                    ThemeMode.light
                                                ? Colors.white
                                                : Colors.black87,
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: SizedBox(
                                                  width: 100,
                                                  height: 100,
                                                  child: imagebool1 == false
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                          child: Image.network(
                                                              widget.image1))
                                                      : CircleAvatar(
                                                          backgroundImage:
                                                              FileImage(
                                                                  hospitalimage1!),
                                                          radius: 50,
                                                        ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  side: BorderSide.none,
                                                  shape: const StadiumBorder(),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 13,
                                                      horizontal: 22),
                                                  foregroundColor: Colors.white,
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .backgroundColor,
                                                ),
                                                onPressed: () async {
                                                  hospitalimage1 =
                                                      await pickImage(context);
                                                  setState(() {
                                                    imagebool1 = true;
                                                  });
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(Icons.photo),
                                                    Text(
                                                      'Select Image',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 1),
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    side: BorderSide.none,
                                                    shape: const CircleBorder(),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10),
                                                    foregroundColor:
                                                        Colors.white,
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .backgroundColor,
                                                  ),
                                                  onPressed: () async {
                                                    if (hospitalname.isEmpty) {
                                                      newshowSnackbar(
                                                          context,
                                                          'Warning',
                                                          'please fill the hospital Name',
                                                          ContentType.warning);
                                                    } else {
                                                      if (imagebool1 == true) {
                                                        if (hospitalimage1 ==
                                                            null) return;

                                                        Reference
                                                            referenceRoot =
                                                            FirebaseStorage
                                                                .instance
                                                                .ref();
                                                        Reference
                                                            referenceDirImages =
                                                            referenceRoot.child(
                                                                'hospital images/$hospitalname/photos');

                                                        //Create a reference for the image to be stored
                                                        Reference
                                                            referenceImageToUpload =
                                                            referenceDirImages
                                                                .child(
                                                                    '${hospitalname}image1');

                                                        //Handle errors/success
                                                        try {
                                                          //Store the file
                                                          await referenceImageToUpload
                                                              .putFile(File(
                                                                  hospitalimage1!
                                                                      .path));
                                                          image1Url =
                                                              await referenceImageToUpload
                                                                  .getDownloadURL();
                                                        } catch (error) {
                                                          //Some error occurred
                                                        }
                                                        if (image1Url.isEmpty) {
                                                          newshowSnackbar(
                                                              context,
                                                              'Failed',
                                                              'Please try again...That image 1 is not upload..',
                                                              ContentType
                                                                  .failure);
                                                        } else {
                                                          newshowSnackbar(
                                                              context,
                                                              'Upload Successfully',
                                                              'Hospital image 1 Upload Successfully',
                                                              ContentType
                                                                  .success);
                                                        }
                                                      } else {
                                                        newshowSnackbar(
                                                            context,
                                                            'Warning',
                                                            'please select image',
                                                            ContentType
                                                                .warning);
                                                      }
                                                    }
                                                  },
                                                  child: const Icon(
                                                    Icons.cloud_upload,
                                                    size: 30,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          width: double.infinity,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: MyApp.themeNotifier.value ==
                                                    ThemeMode.light
                                                ? Colors.white
                                                : Colors.black87,
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: SizedBox(
                                                  width: 100,
                                                  height: 100,
                                                  child: imagebool2 == false
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                          child: Image.network(
                                                              widget.image2))
                                                      : CircleAvatar(
                                                          backgroundImage:
                                                              FileImage(
                                                                  hospitalimage2!),
                                                          radius: 50,
                                                        ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  side: BorderSide.none,
                                                  shape: const StadiumBorder(),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 13,
                                                      horizontal: 22),
                                                  foregroundColor: Colors.white,
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .backgroundColor,
                                                ),
                                                onPressed: () async {
                                                  hospitalimage2 =
                                                      await pickImage(context);
                                                  setState(() {
                                                    imagebool2 = true;
                                                  });
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(Icons.photo),
                                                    Text(
                                                      'Select Image',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 1),
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    side: BorderSide.none,
                                                    shape: const CircleBorder(),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10),
                                                    foregroundColor:
                                                        Colors.white,
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .backgroundColor,
                                                  ),
                                                  onPressed: () async {
                                                    if (hospitalname.isEmpty) {
                                                      newshowSnackbar(
                                                          context,
                                                          'Warning',
                                                          'please fill the hospital Name',
                                                          ContentType.warning);
                                                    } else {
                                                      if (imagebool2 == true) {
                                                        if (hospitalimage2 ==
                                                            null) return;

                                                        Reference
                                                            referenceRoot =
                                                            FirebaseStorage
                                                                .instance
                                                                .ref();
                                                        Reference
                                                            referenceDirImages =
                                                            referenceRoot.child(
                                                                'hospital images/$hospitalname/photos');

                                                        //Create a reference for the image to be stored
                                                        Reference
                                                            referenceImageToUpload =
                                                            referenceDirImages
                                                                .child(
                                                                    '${hospitalname}image2');

                                                        //Handle errors/success
                                                        try {
                                                          //Store the file
                                                          await referenceImageToUpload
                                                              .putFile(File(
                                                                  hospitalimage2!
                                                                      .path));
                                                          image2Url =
                                                              await referenceImageToUpload
                                                                  .getDownloadURL();
                                                        } catch (error) {
                                                          //Some error occurred
                                                        }
                                                        if (image2Url.isEmpty) {
                                                          newshowSnackbar(
                                                              context,
                                                              'Failed',
                                                              'Please try again...That image 2 is not upload..',
                                                              ContentType
                                                                  .failure);
                                                        } else {
                                                          newshowSnackbar(
                                                              context,
                                                              'Upload Successfully',
                                                              'Hospital image 2 Upload Successfully',
                                                              ContentType
                                                                  .success);
                                                        }
                                                      } else {
                                                        newshowSnackbar(
                                                            context,
                                                            'Warning',
                                                            'please select image',
                                                            ContentType
                                                                .warning);
                                                      }
                                                    }
                                                  },
                                                  child: const Icon(
                                                    Icons.cloud_upload,
                                                    size: 30,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          width: double.infinity,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: MyApp.themeNotifier.value ==
                                                    ThemeMode.light
                                                ? Colors.white
                                                : Colors.black87,
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: SizedBox(
                                                  width: 100,
                                                  height: 100,
                                                  child: imagebool3 == false
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                          child: Image.network(
                                                              widget.image3))
                                                      : CircleAvatar(
                                                          backgroundImage:
                                                              FileImage(
                                                                  hospitalimage3!),
                                                          radius: 50,
                                                        ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  side: BorderSide.none,
                                                  shape: const StadiumBorder(),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 13,
                                                      horizontal: 22),
                                                  foregroundColor: Colors.white,
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .backgroundColor,
                                                ),
                                                onPressed: () async {
                                                  hospitalimage3 =
                                                      await pickImage(context);
                                                  setState(() {
                                                    imagebool3 = true;
                                                  });
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(Icons.photo),
                                                    Text(
                                                      'Select Image',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 1),
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    side: BorderSide.none,
                                                    shape: const CircleBorder(),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10),
                                                    foregroundColor:
                                                        Colors.white,
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .backgroundColor,
                                                  ),
                                                  onPressed: () async {
                                                    if (hospitalname.isEmpty) {
                                                      newshowSnackbar(
                                                          context,
                                                          'Warning',
                                                          'please fill the hospital Name',
                                                          ContentType.warning);
                                                    } else {
                                                      if (imagebool3 == true) {
                                                        if (hospitalimage3 ==
                                                            null) return;

                                                        Reference
                                                            referenceRoot =
                                                            FirebaseStorage
                                                                .instance
                                                                .ref();
                                                        Reference
                                                            referenceDirImages =
                                                            referenceRoot.child(
                                                                'hospital images/$hospitalname/photos');

                                                        //Create a reference for the image to be stored
                                                        Reference
                                                            referenceImageToUpload =
                                                            referenceDirImages
                                                                .child(
                                                                    '${hospitalname}image3');

                                                        //Handle errors/success
                                                        try {
                                                          //Store the file
                                                          await referenceImageToUpload
                                                              .putFile(File(
                                                                  hospitalimage3!
                                                                      .path));
                                                          image3Url =
                                                              await referenceImageToUpload
                                                                  .getDownloadURL();
                                                        } catch (error) {
                                                          //Some error occurred
                                                        }
                                                        if (image3Url.isEmpty) {
                                                          newshowSnackbar(
                                                              context,
                                                              'Failed',
                                                              'Please try again...That image 3 is not upload..',
                                                              ContentType
                                                                  .failure);
                                                        } else {
                                                          newshowSnackbar(
                                                              context,
                                                              'Upload Successfully',
                                                              'Hospital image 3 Upload Successfully',
                                                              ContentType
                                                                  .success);
                                                        }
                                                      } else {
                                                        newshowSnackbar(
                                                            context,
                                                            'Warning',
                                                            'please select image',
                                                            ContentType
                                                                .warning);
                                                      }
                                                    }
                                                  },
                                                  child: const Icon(
                                                    Icons.cloud_upload,
                                                    size: 30,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          width: double.infinity,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: MyApp.themeNotifier.value ==
                                                    ThemeMode.light
                                                ? Colors.white
                                                : Colors.black87,
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: SizedBox(
                                                  width: 100,
                                                  height: 100,
                                                  child: imagebool4 == false
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                          child: Image.network(
                                                              widget.image4))
                                                      : CircleAvatar(
                                                          backgroundImage:
                                                              FileImage(
                                                                  hospitalimage4!),
                                                          radius: 50,
                                                        ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  side: BorderSide.none,
                                                  shape: const StadiumBorder(),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 13,
                                                      horizontal: 22),
                                                  foregroundColor: Colors.white,
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .backgroundColor,
                                                ),
                                                onPressed: () async {
                                                  hospitalimage4 =
                                                      await pickImage(context);
                                                  setState(() {
                                                    imagebool4 = true;
                                                  });
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(Icons.photo),
                                                    Text(
                                                      'Select Image',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 1),
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    side: BorderSide.none,
                                                    shape: const CircleBorder(),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10),
                                                    foregroundColor:
                                                        Colors.white,
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .backgroundColor,
                                                  ),
                                                  onPressed: () async {
                                                    if (hospitalname.isEmpty) {
                                                      newshowSnackbar(
                                                          context,
                                                          'Warning',
                                                          'please fill the hospital Name',
                                                          ContentType.warning);
                                                    } else {
                                                      if (imagebool4 == true) {
                                                        if (hospitalimage4 ==
                                                            null) return;

                                                        Reference
                                                            referenceRoot =
                                                            FirebaseStorage
                                                                .instance
                                                                .ref();
                                                        Reference
                                                            referenceDirImages =
                                                            referenceRoot.child(
                                                                'hospital images/$hospitalname/photos');

                                                        //Create a reference for the image to be stored
                                                        Reference
                                                            referenceImageToUpload =
                                                            referenceDirImages
                                                                .child(
                                                                    '${hospitalname}image4');

                                                        //Handle errors/success
                                                        try {
                                                          //Store the file
                                                          await referenceImageToUpload
                                                              .putFile(File(
                                                                  hospitalimage4!
                                                                      .path));
                                                          image4Url =
                                                              await referenceImageToUpload
                                                                  .getDownloadURL();
                                                        } catch (error) {
                                                          //Some error occurred
                                                        }
                                                        if (image4Url.isEmpty) {
                                                          newshowSnackbar(
                                                              context,
                                                              'Failed',
                                                              'Please try again...That image 4 is not upload..',
                                                              ContentType
                                                                  .failure);
                                                        } else {
                                                          newshowSnackbar(
                                                              context,
                                                              'Upload Successfully',
                                                              'Hospital image 4 Upload Successfully',
                                                              ContentType
                                                                  .success);
                                                        }
                                                      } else {
                                                        newshowSnackbar(
                                                            context,
                                                            'Warning',
                                                            'please select image',
                                                            ContentType
                                                                .warning);
                                                      }
                                                    }
                                                  },
                                                  child: const Icon(
                                                    Icons.cloud_upload,
                                                    size: 30,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          width: double.infinity,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: MyApp.themeNotifier.value ==
                                                    ThemeMode.light
                                                ? Colors.white
                                                : Colors.black87,
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: SizedBox(
                                                  width: 100,
                                                  height: 100,
                                                  child: imagebool5 == false
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                          child: Image.network(
                                                              widget.image5))
                                                      : CircleAvatar(
                                                          backgroundImage:
                                                              FileImage(
                                                                  hospitalimage5!),
                                                          radius: 50,
                                                        ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  side: BorderSide.none,
                                                  shape: const StadiumBorder(),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 13,
                                                      horizontal: 22),
                                                  foregroundColor: Colors.white,
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .backgroundColor,
                                                ),
                                                onPressed: () async {
                                                  hospitalimage5 =
                                                      await pickImage(context);
                                                  setState(() {
                                                    imagebool5 = true;
                                                  });
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(Icons.photo),
                                                    Text(
                                                      'Select Image',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 1),
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    side: BorderSide.none,
                                                    shape: const CircleBorder(),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10),
                                                    foregroundColor:
                                                        Colors.white,
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .backgroundColor,
                                                  ),
                                                  onPressed: () async {
                                                    if (hospitalname.isEmpty) {
                                                      newshowSnackbar(
                                                          context,
                                                          'Warning',
                                                          'please fill the hospital Name',
                                                          ContentType.warning);
                                                    } else {
                                                      if (imagebool5 == true) {
                                                        if (hospitalimage5 ==
                                                            null) return;

                                                        Reference
                                                            referenceRoot =
                                                            FirebaseStorage
                                                                .instance
                                                                .ref();
                                                        Reference
                                                            referenceDirImages =
                                                            referenceRoot.child(
                                                                'hospital images/$hospitalname/photos');

                                                        //Create a reference for the image to be stored
                                                        Reference
                                                            referenceImageToUpload =
                                                            referenceDirImages
                                                                .child(
                                                                    '${hospitalname}image5');

                                                        //Handle errors/success
                                                        try {
                                                          //Store the file
                                                          await referenceImageToUpload
                                                              .putFile(File(
                                                                  hospitalimage5!
                                                                      .path));
                                                          image5Url =
                                                              await referenceImageToUpload
                                                                  .getDownloadURL();
                                                        } catch (error) {
                                                          //Some error occurred
                                                        }
                                                        if (image5Url.isEmpty) {
                                                          newshowSnackbar(
                                                              context,
                                                              'Failed',
                                                              'Please try again...That image 5 is not upload..',
                                                              ContentType
                                                                  .failure);
                                                        } else {
                                                          newshowSnackbar(
                                                              context,
                                                              'Upload Successfully',
                                                              'Hospital image 5 Upload Successfully',
                                                              ContentType
                                                                  .success);
                                                        }
                                                      } else {
                                                        newshowSnackbar(
                                                            context,
                                                            'Warning',
                                                            'please select image',
                                                            ContentType
                                                                .warning);
                                                      }
                                                    }
                                                  },
                                                  child: const Icon(
                                                    Icons.cloud_upload,
                                                    size: 30,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                            ])),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                side: BorderSide.none,
                                shape: const StadiumBorder(),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 13),
                                foregroundColor: Colors.white,
                                backgroundColor:
                                    Theme.of(context).backgroundColor,
                              ),
                              onPressed: () {
                                update();
                              },
                              child: const Text('UPDATE')),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  update() {
    if (fromKey.currentState!.validate()) {
      if (establisedYr.isEmpty) {
        establisedYr = widget.establisedyear;
      } else {
        updateTheFieldCondition(
            widget.hospitalname, 'establishedYear', establisedYr);
      }
      if (location.isEmpty) {
        location = widget.location;
      } else {
        updateTheFieldCondition(widget.hospitalname, 'location', location);
      }
      if (district.isEmpty) {
        district = widget.district;
      } else {
        updateTheFieldCondition(widget.hospitalname, 'district', district);
      }
      if (address.isEmpty) {
        address = widget.address;
      } else {
        updateTheFieldCondition(widget.hospitalname, 'address', address);
      }
      if (highlight.isEmpty) {
        highlight = widget.highlight;
      } else {
        updateTheFieldCondition(widget.hospitalname, 'highlight', highlight);
      }
      if (phone.isEmpty) {
        phone = widget.phonenumber;
      } else {
        updateTheFieldCondition(widget.hospitalname, 'phoneno', phone);
      }
      if (time.isEmpty) {
        time = widget.time;
      } else {
        updateTheFieldCondition(widget.hospitalname, 'time', time);
      }
      if (noDoctors.isEmpty) {
        noDoctors = widget.nodoctor;
      } else {
        updateTheFieldCondition(widget.hospitalname, 'doctorsNo', noDoctors);
      }
      if (bed.isEmpty) {
        bed = widget.nobed;
      } else {
        updateTheFieldCondition(widget.hospitalname, 'bedNo', bed);
      }
      if (noambulance.isEmpty) {
        noambulance = widget.noambulance;
      } else {
        updateTheFieldCondition(
            widget.hospitalname, 'ambulanceNo', noambulance);
      }
      if (hospitalsite.isEmpty) {
        hospitalsite = widget.hospitallink;
      } else {
        updateTheFieldCondition(widget.hospitalname, 'sitLink', hospitalsite);
      }
      if (logoUrl.isEmpty) {
        logoUrl = widget.logo;
      } else {
        updateTheFieldCondition(widget.hospitalname, 'Logo', logoUrl);
      }
      if (gp.isEmpty) {
        gp = widget.govtorprivate;
      } else {
        updateTheFieldCondition(widget.hospitalname, 'GovtorPrivate', gp);
      }
      if (type.isEmpty) {
        type = widget.type;
      } else {
        updateTheFieldCondition(widget.hospitalname, 'type', type);
      }
      if (affUniversity.isEmpty) {
        affUniversity = widget.affilicated;
      } else {
        updateTheFieldCondition(
            widget.hospitalname, 'affiliateduniversity', affUniversity);
      }
      if (emergency.isEmpty) {
        emergency = widget.emergency;
      } else {
        updateTheFieldCondition(
            widget.hospitalname, 'emergencydepartment', emergency);
      }
      if (surround1.isEmpty) {
        surround1 = widget.surround1;
      } else {
        updateTheFieldCondition(
            widget.hospitalname, 'surroundingplace1', surround1);
      }
      if (surroundDistance1.isEmpty) {
        surroundDistance1 = widget.surroundDistance1;
      } else {
        updateTheFieldCondition(
            widget.hospitalname, 'surroundingdistance1', surroundDistance1);
      }
      if (surroundTime1.isEmpty) {
        surroundTime1 = widget.surroundTime1;
      } else {
        updateTheFieldCondition(
            widget.hospitalname, 'surroundingtime1', surroundTime1);
      }
      if (surround2.isEmpty) {
        surround2 = widget.surround2;
      } else {
        updateTheFieldCondition(
            widget.hospitalname, 'surroundingplace2', surround2);
      }
      if (surroundDistance2.isEmpty) {
        surroundDistance2 = widget.surroundDistance2;
      } else {
        updateTheFieldCondition(
            widget.hospitalname, 'surroundingdistance2', surroundDistance2);
      }
      if (surroundTime2.isEmpty) {
        surroundTime2 = widget.surroundTime2;
      } else {
        updateTheFieldCondition(
            widget.hospitalname, 'surroundingtime2', surroundTime2);
      }
      if (nearhospital1.isEmpty) {
        nearhospital1 = widget.nearhospital1;
      } else {
        updateTheFieldCondition(
            widget.hospitalname, 'hospital1', nearhospital1);
      }
      if (nearhospital2.isEmpty) {
        nearhospital2 = widget.nearhospital2;
      } else {
        updateTheFieldCondition(
            widget.hospitalname, 'hospital2', nearhospital2);
      }
      if (nearhospital3.isEmpty) {
        nearhospital3 = widget.nearhospital3;
      } else {
        updateTheFieldCondition(
            widget.hospitalname, 'hospital3', nearhospital3);
      }
      if (overview.isEmpty) {
        overview = widget.overview;
      } else {
        updateTheFieldCondition(widget.hospitalname, 'overview', overview);
      }
      if (services.isEmpty) {
        services = widget.service;
      } else {
        updateTheFieldCondition(widget.hospitalname, 'services', services);
      }
      if (image1Url.isEmpty) {
        image1Url = widget.image1;
      } else {
        updateTheFieldCondition(widget.hospitalname, 'image1', image1Url);
      }
      if (image2Url.isEmpty) {
        image2Url = widget.image2;
      } else {
        updateTheFieldCondition(widget.hospitalname, 'image2', image2Url);
      }
      if (image3Url.isEmpty) {
        image3Url = widget.image3;
      } else {
        updateTheFieldCondition(widget.hospitalname, 'image3', image3Url);
      }
      if (image4Url.isEmpty) {
        image4Url = widget.image4;
      } else {
        updateTheFieldCondition(widget.hospitalname, 'image4', image4Url);
      }
      if (image5Url.isEmpty) {
        image5Url = widget.image5;
      } else {
        updateTheFieldCondition(widget.hospitalname, 'image5', image5Url);
      }
      if (lat.isEmpty) {
        lat = widget.latitude;
      } else {
        updateTheFieldCondition(widget.hospitalname, 'Latitude', lat);
      }
      if (long.isEmpty) {
        long = widget.longitude;
      } else {
        updateTheFieldCondition(widget.hospitalname, 'Longitude', long);
      }
      if (hospitalname.isEmpty) {
        hospitalname = widget.hospitalname;
      } else {
        updateTheFieldCondition(
            widget.hospitalname, 'hospitalName', hospitalname);
      }
    }
  }

  Future<void> updateTheFieldCondition(
      String hospitalName, String field, String changeValue) async {
    try {
      // Fetch the documents that match the condition (e.g. phonenumber)
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('hospitals')
          .where('hospitalName', isEqualTo: hospitalName)
          .get();

      // Update the AdKey field value for each document
      List<Future<void>> updateFutures = querySnapshot.docs.map((doc) {
        return doc.reference.update({field: changeValue});
      }).toList();

      // Wait for all updates to complete
      await Future.wait(updateFutures);

      // ignore: use_build_context_synchronously
      newshowSnackbar(context, 'Successfully Update',
          'updated the Hospital details: $hospitalname', ContentType.success);
    } catch (e) {
      newshowSnackbar(
          context,
          'Failed to Update',
          'Failed to updated the Hospital details: $hospitalname',
          ContentType.failure);
    }
  }
}
