import 'package:carevista_ver05/Service/database_service.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:flutter/material.dart';
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

class AddHospital extends StatefulWidget {
  AddHospital({super.key});

  @override
  State<AddHospital> createState() => _AddHospitalState();
}

class _AddHospitalState extends State<AddHospital> {
  final fromKey = GlobalKey<FormState>();
  TimeOfDay pickedTime = TimeOfDay(hour: 8, minute: 30);
  String hospitalname = "";

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
  TextEditingController timeinput = TextEditingController();
  TextEditingController timeinputlast = TextEditingController();
  void initState() {
    timeinput.text = ""; //set the initial value of text field
    super.initState();
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
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset('Assets/images/profile-user.jpg')),
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
                                                      gp = "Government";
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
                                return RegExp(
                                            r'[!@#<>?:_`"~;[\]\\|=+)(*&^%0-9-]')
                                        .hasMatch(val)
                                    ? "Please enter valid Hospital Type"
                                    : null;
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
                                                  groupValue: _gp,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _gp = value!;
                                                      emergency = "Yes";
                                                    });
                                                  },
                                                )),
                                            const SizedBox(width: 10),
                                            TimeWidget(
                                                time: "NO",
                                                radioBtn: Radio(
                                                  value: 'No',
                                                  groupValue: _gp,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _gp = value!;
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
                        const SizedBox(height: 10),
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
                                                district = 'TRIVANDRUM';
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
                                                district = 'KOLLAM';
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
                                                district = 'PATHANAMTHITTA';
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
                                                district = 'ALAPPUZHA';
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
                                                district = 'KOTTAYAM';
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
                                                district = 'IDUKKI';
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
                                                district = 'ERNAKULAM';
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
                                                district = 'THRISSUR';
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
                                                district = 'PALAKKAD';
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
                                                district = 'MALAPPURAM';
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
                                                district = 'KOZHIKODE';
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
                                                district = 'WAYANAD';
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
                                                district = 'KANNUR';
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
                                                district = 'KASARAGOD';
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
                                return RegExp(
                                            r'[!@#<>?:_`"~;[\]\\|=+)(*&^%0-9-]')
                                        .hasMatch(val)
                                    ? "Please enter hospital Address"
                                    : null;
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
                                return RegExp(
                                            r'[!@#<>?:_`"~;[\]\\|=+)(*&^%0-9-]')
                                        .hasMatch(val)
                                    ? "Enter one hospital Highlight"
                                    : null;
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
                                        width: 126,
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
                                                startTime = timeinput.text;
                                                print(startTime);
                                              });
                                            } else {
                                              print("Time is not selected");
                                            }
                                          },
                                          decoration: const InputDecoration(
                                            prefixIcon:
                                                Icon(LineAwesomeIcons.clock),
                                            labelText: 'Time',
                                            border: OutlineInputBorder(),
                                          ),
                                          validator: (value) {},
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      const Text("TO"),
                                      const SizedBox(width: 5),
                                      SizedBox(
                                        width: 126,
                                        child: TextFormField(
                                          controller: timeinputlast,
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
                                                timeinputlast.text =
                                                    pickedTime.format(context);
                                                lastTime = timeinputlast.text;
                                                print(lastTime);
                                              });
                                            } else {
                                              print("Time is not selected");
                                            }
                                          },
                                          decoration: const InputDecoration(
                                            prefixIcon:
                                                Icon(LineAwesomeIcons.clock),
                                            labelText: 'Time',
                                            border: OutlineInputBorder(),
                                          ),
                                          validator: (value) {
                                            if (startTime == lastTime) {
                                              return "Both Time are Same";
                                            }
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 0),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if (addTime == false) {
                                                addTime = true;
                                                addtimeSize = 43;
                                              } else {
                                                addTime = false;
                                                addtimeSize = 0;
                                              }
                                            });
                                          },
                                          icon: Icon(
                                            addTime == false
                                                ? Icons.add_circle
                                                : Icons.remove_circle,
                                            color: addTime == false
                                                ? Colors.green
                                                : Colors.redAccent,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              addTime
                                  ? Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 126,
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
                                                    timeinput.text = pickedTime
                                                        .format(context);
                                                    startTime = timeinput.text;
                                                    print(startTime);
                                                  });
                                                } else {
                                                  print("Time is not selected");
                                                }
                                              },
                                              decoration: const InputDecoration(
                                                prefixIcon: Icon(
                                                    LineAwesomeIcons.clock),
                                                labelText: 'Time',
                                                border: OutlineInputBorder(),
                                              ),
                                              validator: (value) {},
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          const Text("TO"),
                                          const SizedBox(width: 5),
                                          SizedBox(
                                            width: 126,
                                            child: TextFormField(
                                              controller: timeinputlast,
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
                                                    timeinputlast.text =
                                                        pickedTime
                                                            .format(context);
                                                    lastTime =
                                                        timeinputlast.text;
                                                    print(lastTime);
                                                  });
                                                } else {
                                                  print("Time is not selected");
                                                }
                                              },
                                              decoration: const InputDecoration(
                                                prefixIcon: Icon(
                                                    LineAwesomeIcons.clock),
                                                labelText: 'Time',
                                                border: OutlineInputBorder(),
                                              ),
                                              validator: (value) {
                                                if (startTime == lastTime) {
                                                  return "Both Time are Same";
                                                }
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 0),
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  addTime = true;
                                                });
                                              },
                                              icon: Icon(
                                                Icons.add_circle,
                                                color: Colors.green,
                                              )),
                                          const SizedBox(width: 1),
                                        ],
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 341,
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
                                              return RegExp(
                                                          r'[!@#<>?:_`"~;[\]\\|=+)(*&^%0-9-]')
                                                      .hasMatch(val)
                                                  ? "Please enter Distance"
                                                  : null;
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
                                              return RegExp(
                                                          r'[!@#<>?:_`"~;[\]\\|=+)(*&^%0-9-]')
                                                      .hasMatch(val)
                                                  ? "Please enter time"
                                                  : null;
                                            }
                                          },
                                          icon: Icons.timer_outlined))
                                ],
                              ),
                              const SizedBox(height: 10),
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
                                            surroundDistance2 = value;
                                          },
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return "Enter Distance";
                                            } else {
                                              return RegExp(
                                                          r'[!@#<>?:_`"~;[\]\\|=+)(*&^%0-9-]')
                                                      .hasMatch(val)
                                                  ? "Please enter Distance"
                                                  : null;
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
                                              return RegExp(
                                                          r'[!@#<>?:_`"~;[\]\\|=+)(*&^%0-9-]')
                                                      .hasMatch(val)
                                                  ? "Please enter Time"
                                                  : null;
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
                            height: 265,
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
                                    'Doctors Name & Specialist',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  )),
                                ],
                              ),
                              const SizedBox(height: 10),
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
                                          return RegExp(
                                                      r'[!@#<>?:_`"~;[\]\\|=+)(*&^%0-9-]')
                                                  .hasMatch(val)
                                              ? "Please enter Distance"
                                              : null;
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
                                          return RegExp(
                                                      r'[!@#<>?:_`"~;[\]\\|=+)(*&^%0-9-]')
                                                  .hasMatch(val)
                                              ? "Please enter Time"
                                              : null;
                                        }
                                      },
                                      icon: Icons.timer_outlined))
                            ])),
                        const SizedBox(height: 10),
                        Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 265,
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
                                      child: TextFormFieldOvalWidget(
                                          labelText: 'Hospital 1',
                                          onChange: (value) {
                                            surround1 = value;
                                          },
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return "Enter Hospital name";
                                            } else {
                                              return RegExp(
                                                          r'[!@#<>?:_`"~;[\]\\|=+)(*&^%0-9-]')
                                                      .hasMatch(val)
                                                  ? "Please enter Hospital name"
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
                                          labelText: 'Hospital 2',
                                          onChange: (value) {
                                            surround2 = value;
                                          },
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return "Enter Hospital name";
                                            } else {
                                              return RegExp(
                                                          r'[!@#<>?:_`"~;[\]\\|=+)(*&^%0-9-]')
                                                      .hasMatch(val)
                                                  ? "Please enter Hospital name"
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
                                          labelText: 'Hospital 3',
                                          onChange: (value) {
                                            surround2 = value;
                                          },
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return "Enter Hospital name";
                                            } else {
                                              return RegExp(
                                                          r'[!@#<>?:_`"~;[\]\\|=+)(*&^%0-9-]')
                                                      .hasMatch(val)
                                                  ? "Please enter Hospital name"
                                                  : null;
                                            }
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
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Please Established Year';
                              } else {
                                return null;
                              }
                            },
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
                            labelText: "Google Map Link",
                            onChange: (value) {
                              locationMap = value;
                            },
                            validator: (p0) {},
                            icon: LineAwesomeIcons.location_arrow),
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
                                save();
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
    );
  }

  save() async {
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
          locationMap);
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
