import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:carevista_ver05/Service/database_service.dart';
import 'package:carevista_ver05/main.dart';
import 'package:carevista_ver05/utils/utils.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:humanitarian_icons/humanitarian_icons.dart';
import 'package:image_picker/image_picker.dart';
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

class AddHospital extends StatefulWidget {
  AddHospital({super.key, required this.username, required this.userphoneno});
  String username;
  String userphoneno;
  @override
  State<AddHospital> createState() => _AddHospitalState();
}

class _AddHospitalState extends State<AddHospital> {
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
  String locationMap = "";
  String quali = "";
  String noambulance = "";
  String establisedYr = "";
  String bed = "";
  DistrictEnum? _districtEnum;
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
    timeinput.text = ""; //set the initial value of text field
    super.initState();
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
      _DoctorPhoto.removeAt(i);
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
                              child: Image.asset(
                                  'Assets/images/Hospital building-cuate.jpg'),
                            )
                          : CircleAvatar(
                              backgroundImage:
                                  file != null ? FileImage(file!) : null,
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
                          decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(LineAwesomeIcons.hospital_symbol),
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
                              return RegExp(r'[!@#<>?:_`"~;[\]\\|=+)(*&^%0-9-]')
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
                                  style: Theme.of(context).textTheme.headline5,
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
                      TextFormFieldOvalWidget(
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
                      TextFormFieldOvalNumberWidget(
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
                      TextFormFieldOvalWidget(
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
                                  style: Theme.of(context).textTheme.headline5,
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
                      TextFormFieldOvalWidget(
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
                        padding:
                            const EdgeInsets.only(top: 20, left: 10, right: 10),
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
                                  style: Theme.of(context).textTheme.headline5,
                                )),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                    child: TextFormFieldOvalWidget(
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
                                    child: TextFormFieldOvalWidget(
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
                                  style: Theme.of(context).textTheme.headline5,
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
                      TextFormFieldOvalWidget(
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
                      TextFormFieldOvalWidget(
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
                      TextFormFieldOvalNumberWidget(
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
                                  style: Theme.of(context).textTheme.headline5,
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
                                  style: Theme.of(context).textTheme.headline5,
                                )),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                    child: TextFormFieldOvalWidget(
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
                                    child: TextFormFieldOvalWidget(
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
                                    child: TextFormFieldOvalWidget(
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
                                    child: TextFormFieldOvalWidget(
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
                                    child: TextFormFieldOvalWidget(
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
                                    child: TextFormFieldOvalWidget(
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
                                                    Icons.remove_circle)),
                                          ],
                                        )),
                                        Flexible(
                                          child: Row(
                                            children: [
                                              Flexible(
                                                  child:
                                                      TextFormFieldOvalControllerWidget(
                                                          labelText:
                                                              'Doctor Name',
                                                          controller:
                                                              _DoctorName[i],
                                                          validator: (val) {
                                                            if (val!.isEmpty) {
                                                              return "Enter Doctor Name";
                                                            } else {
                                                              return RegExp(
                                                                          r'[!@#<>?:_`"~;[\]\\|=+)(*&^%0-9-]')
                                                                      .hasMatch(
                                                                          val)
                                                                  ? "Please enter Doctor Name"
                                                                  : null;
                                                            }
                                                          },
                                                          icon: LineAwesomeIcons
                                                              .stethoscope)),
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
                                                          controller:
                                                              _Specialist[i],
                                                          labelText:
                                                              'Specialist',
                                                          validator: (val) {
                                                            if (val!.isEmpty) {
                                                              return "Enter Specialist";
                                                            } else {
                                                              return RegExp(
                                                                          r'[!@#<>?:_`"~;[\]\\|=+)(*&^%0-9-]')
                                                                      .hasMatch(
                                                                          val)
                                                                  ? "Please enter Specialist"
                                                                  : null;
                                                            }
                                                          },
                                                          icon: Icons
                                                              .folder_special)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
                                  style: Theme.of(context).textTheme.headline5,
                                )),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                    child: TextFormFieldOvalWidget(
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
                                    child: TextFormFieldOvalWidget(
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
                                    child: TextFormFieldOvalWidget(
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
                      TextFormFieldOvalNumberWidget(
                          labelText: 'No of Doctors',
                          onChange: (value) {
                            noDoctors = value;
                          },
                          validator: (p0) {},
                          icon: LineAwesomeIcons.stethoscope),
                      const SizedBox(height: 10),
                      TextFormFieldOvalNumberWidget(
                          labelText: 'No of Bed',
                          onChange: (value) {
                            bed = value;
                          },
                          validator: (p0) {},
                          icon: LineAwesomeIcons.bed),
                      const SizedBox(height: 10),
                      TextFormFieldOvalNumberWidget(
                          labelText: "Ambulances",
                          onChange: (value) {
                            noambulance = value;
                          },
                          validator: (p0) {},
                          icon: LineAwesomeIcons.ambulance),
                      const SizedBox(height: 10),
                      TextFormFieldOvalWidget(
                          labelText: "Hospital Site Link",
                          onChange: (value) {
                            locationMap = value;
                          },
                          validator: (p0) {},
                          icon: LineAwesomeIcons.hospital),
                      const SizedBox(height: 10),
                      TextFormFieldAreaWidget(
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
                      TextFormFieldAreaWidget(
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
                                  style: Theme.of(context).textTheme.headline5,
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
                                                                .circular(100),
                                                        child: const Icon(
                                                          Icons.photo,
                                                        ))
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
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 1),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  side: BorderSide.none,
                                                  shape: const CircleBorder(),
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  foregroundColor: Colors.white,
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

                                                      Reference referenceRoot =
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
                                                          referenceDirImages.child(
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
                                                          ContentType.warning);
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
                                                                .circular(100),
                                                        child: const Icon(
                                                          Icons.photo,
                                                        ))
                                                    : CircleAvatar(
                                                        backgroundImage:
                                                            FileImage(
                                                                hospitalimage2!),
                                                        radius: 50,
                                                      ),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                side: BorderSide.none,
                                                shape: const StadiumBorder(),
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 1),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  side: BorderSide.none,
                                                  shape: const CircleBorder(),
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  foregroundColor: Colors.white,
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

                                                      Reference referenceRoot =
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
                                                          referenceDirImages.child(
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
                                                          ContentType.warning);
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
                                                                .circular(100),
                                                        child: const Icon(
                                                          Icons.photo,
                                                        ))
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
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 1),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  side: BorderSide.none,
                                                  shape: const CircleBorder(),
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  foregroundColor: Colors.white,
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

                                                      Reference referenceRoot =
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
                                                          referenceDirImages.child(
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
                                                          ContentType.warning);
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
                                                                .circular(100),
                                                        child: const Icon(
                                                          Icons.photo,
                                                        ))
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
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 1),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  side: BorderSide.none,
                                                  shape: const CircleBorder(),
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  foregroundColor: Colors.white,
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

                                                      Reference referenceRoot =
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
                                                          referenceDirImages.child(
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
                                                          ContentType.warning);
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
                                                                .circular(100),
                                                        child: const Icon(
                                                          Icons.photo,
                                                        ))
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
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 1),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  side: BorderSide.none,
                                                  shape: const CircleBorder(),
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  foregroundColor: Colors.white,
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

                                                      Reference referenceRoot =
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
                                                          referenceDirImages.child(
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
                                                          ContentType.warning);
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
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  Theme.of(context).backgroundColor,
                            ),
                            onPressed: () {
                              //upload();
                              save();
                            },
                            child: const Text('SAVE')),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*upload() {
    print(_DoctorName);
    print(_Specialist);
    List ak = _DoctorName;
    print(ak);
    for (int i = 0; i < _DoctorName.length; i++) {
      print(ak.toList()[i].text);
      print(ak.toList()[i].text);
    }
  }*/

  save() async {
    if (logoUrl.isEmpty ||
        image1Url.isEmpty ||
        image2Url.isEmpty ||
        image3Url.isEmpty ||
        image4Url.isEmpty ||
        image5Url.isEmpty) {
      newshowSnackbar(context, 'Hospital Logo', 'please upload hospital logo',
          ContentType.failure);
    } else {
      if (fromKey.currentState!.validate()) {
        await DatabaseServiceHospital().savingHospitaldetails(
            hospitalname,
            establisedYr,
            location,
            district,
            address,
            highlight,
            phone,
            time,
            noDoctors,
            bed,
            noambulance,
            locationMap,
            logoUrl,
            gp,
            type,
            affUniversity,
            emergency,
            surround1,
            surroundDistance1,
            surroundTime1,
            surround2,
            surroundDistance2,
            surroundTime2,
            _DoctorName.length,
            _DoctorName,
            _Specialist,
            nearhospital1,
            nearhospital2,
            nearhospital3,
            overview,
            services,
            image1Url,
            image2Url,
            image3Url,
            image4Url,
            image5Url,
            widget.username,
            widget.userphoneno,
            lat,
            long);
        // ignore: use_build_context_synchronously
        newshowSnackbar(context, 'Successfully',
            'successfully upload the hospital details', ContentType.success);
      } else {
        newshowSnackbar(
            context,
            'Check above Details',
            'the hospital details contain a invalid format please check above the form',
            ContentType.failure);
      }
    }
  }
}

class DistrictWidget extends StatelessWidget {
  const DistrictWidget({
    Key? key,
    required this.districtName,
    required this.radioBtn,
  }) : super(key: key);
  final String districtName;
  final Widget radioBtn;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 179,
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
                Text(districtName,
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

class TimeWidget extends StatelessWidget {
  const TimeWidget({
    Key? key,
    required this.time,
    required this.radioBtn,
  }) : super(key: key);
  final String time;
  final Widget radioBtn;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 150,
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
                Text(time,
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
