import 'dart:io';
import 'package:carevista_ver05/admin/addHospital.dart';
import 'package:carevista_ver05/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class MedicineReminder extends StatefulWidget {
  const MedicineReminder({super.key});

  @override
  State<MedicineReminder> createState() => _MedicineReminderState();
}

bool addMedicine = false;
final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
final fromKey = GlobalKey<FormState>();
bool loading = false;
bool imagebool = false;
File? image;
String medicineType = "";
// ignore: unused_element
String _medicinetype = "";
bool monbool = false;
bool tuebool = false;
bool wedbool = false;
bool thubool = false;
bool fribool = false;
bool satbool = false;
bool sunbool = false;
bool? morningDose = false;
bool? eveningDose = false;
double height = 0;

class _MedicineReminderState extends State<MedicineReminder> {
  final morningdateController = TextEditingController();
  final morningtimeController = TextEditingController();
  final eveningdateController = TextEditingController();
  final eveningtimeController = TextEditingController();
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
        : Container(
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
                  'Medicine Reminder',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      //fontFamily: 'brandon_H',
                      color: Theme.of(context).primaryColorDark),
                ),
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        addMedicine = true;
                      });
                      setState(() {
                        monbool = false;
                        tuebool = false;
                        wedbool = false;
                        thubool = false;
                        fribool = false;
                        satbool = false;
                        sunbool = false;
                      });
                    },
                    child: Container(
                      height: addMedicine ? 700 + 68 + 20 + height : 50,
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 10, right: 10),
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
                                'Add New Medicine Reminder',
                                style: TextStyle(color: Colors.white),
                              ),
                              Expanded(child: Container()),
                              IconButton(
                                onPressed: () {
                                  if (addMedicine == false) {
                                    setState(() {
                                      addMedicine = true;
                                    });
                                    setState(() {
                                      monbool = false;
                                      tuebool = false;
                                      wedbool = false;
                                      thubool = false;
                                      fribool = false;
                                      satbool = false;
                                      sunbool = false;
                                    });
                                  } else {
                                    setState(() {
                                      addMedicine = false;
                                    });
                                  }
                                },
                                icon: addMedicine == false
                                    ? const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      )
                                    : const Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                      ),
                              )
                            ],
                          ),
                          addMedicine == true
                              ? Container(
                                  height: 700 + 20 + 10 + height,
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
                                        Text('Medicine Reminder',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2),
                                        const SizedBox(height: 20),
                                        TextFormField(
                                          decoration: const InputDecoration(
                                              prefixIcon: Icon(
                                                  Icons.medication_outlined),
                                              labelText: 'Medicine Name',
                                              border: OutlineInputBorder()),
                                          onChanged: (val) {},
                                          // check tha validation
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return "Please Enter Medicine Name";
                                            }
                                          },
                                        ),
                                        const SizedBox(height: 15),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          width: double.infinity,
                                          height: 139,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Theme.of(context).cardColor,
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'Medicine Image',
                                                    style: TextStyle(
                                                        color:
                                                            MyApp.themeNotifier
                                                                        .value ==
                                                                    ThemeMode
                                                                        .light
                                                                ? Colors.black
                                                                : Colors.white),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: SizedBox(
                                                      width: 100,
                                                      height: 100,
                                                      child: imagebool == false
                                                          ? ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100),
                                                              child: const Icon(
                                                                Icons.photo,
                                                              ))
                                                          : CircleAvatar(
                                                              backgroundImage:
                                                                  FileImage(
                                                                      image!),
                                                              radius: 50,
                                                            ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      side: BorderSide.none,
                                                      shape:
                                                          const StadiumBorder(),
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 13,
                                                          horizontal: 22),
                                                      foregroundColor:
                                                          Colors.white,
                                                      backgroundColor:
                                                          const Color(
                                                              0XFF407BFF),
                                                    ),
                                                    onPressed: () async {},
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(Icons.photo),
                                                        Text(
                                                          'Select Image',
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(width: 1),
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        side: BorderSide.none,
                                                        shape:
                                                            const CircleBorder(),
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 10),
                                                        foregroundColor:
                                                            Colors.white,
                                                        backgroundColor:
                                                            const Color(
                                                                0XFF407BFF),
                                                      ),
                                                      onPressed: () async {},
                                                      child: const Icon(
                                                        Icons.cloud_upload,
                                                        size: 30,
                                                      )),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          width: double.infinity,
                                          height: 120,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color:
                                                  Theme.of(context).cardColor),
                                          child: Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      'Medicine Type',
                                                      style: TextStyle(
                                                          color: MyApp.themeNotifier
                                                                      .value ==
                                                                  ThemeMode
                                                                      .light
                                                              ? Colors.black
                                                              : Colors.white),
                                                    ),
                                                  ),
                                                  Expanded(child: Container()),
                                                  Expanded(child: Container()),
                                                  const Icon(
                                                    Icons
                                                        .arrow_circle_right_outlined,
                                                    size: 21,
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(1),
                                                child: SizedBox(
                                                  height: 50,
                                                  child: ListView(
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    children: [
                                                      TimeWidget(
                                                          time: "Pills",
                                                          radioBtn: Radio(
                                                            value: 'Pills',
                                                            groupValue:
                                                                _medicinetype,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                _medicinetype =
                                                                    value!;
                                                                medicineType =
                                                                    "Private";
                                                              });
                                                            },
                                                          )),
                                                      const SizedBox(width: 10),
                                                      TimeWidget(
                                                        time: "Ointments",
                                                        radioBtn: Radio(
                                                          value: 'Ointments',
                                                          groupValue:
                                                              _medicinetype,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              _medicinetype =
                                                                  value!;
                                                              medicineType =
                                                                  "Ointments";
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      TimeWidget(
                                                        time: "Syrup",
                                                        radioBtn: Radio(
                                                          value: 'Syrup',
                                                          groupValue:
                                                              _medicinetype,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              _medicinetype =
                                                                  value!;
                                                              medicineType =
                                                                  "Syrup";
                                                            });
                                                          },
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          width: double.infinity,
                                          height: 60,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color:
                                                  Theme.of(context).cardColor),
                                          child: ListView(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            children: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: monbool
                                                      ? const Color(0XFF407BFF)
                                                      : Colors.white,
                                                  foregroundColor: monbool
                                                      ? Colors.white
                                                      : Colors.black,
                                                  shape: const CircleBorder(),
                                                ),
                                                onPressed: () {
                                                  if (monbool == false) {
                                                    setState(() {
                                                      monbool = true;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      monbool = false;
                                                    });
                                                  }
                                                },
                                                child: const Text('Mon'),
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: tuebool
                                                      ? const Color(0XFF407BFF)
                                                      : Colors.white,
                                                  foregroundColor: tuebool
                                                      ? Colors.white
                                                      : Colors.black,
                                                  shape: const CircleBorder(),
                                                ),
                                                onPressed: () {
                                                  if (tuebool == false) {
                                                    setState(() {
                                                      tuebool = true;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      tuebool = false;
                                                    });
                                                  }
                                                },
                                                child: const Text('Tue'),
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: wedbool
                                                      ? const Color(0XFF407BFF)
                                                      : Colors.white,
                                                  foregroundColor: wedbool
                                                      ? Colors.white
                                                      : Colors.black,
                                                  shape: const CircleBorder(),
                                                ),
                                                onPressed: () {
                                                  if (wedbool == false) {
                                                    setState(() {
                                                      wedbool = true;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      wedbool = false;
                                                    });
                                                  }
                                                },
                                                child: const Text('Wed'),
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: thubool
                                                      ? const Color(0XFF407BFF)
                                                      : Colors.white,
                                                  foregroundColor: thubool
                                                      ? Colors.white
                                                      : Colors.black,
                                                  shape: const CircleBorder(),
                                                ),
                                                onPressed: () {
                                                  if (thubool == false) {
                                                    setState(() {
                                                      thubool = true;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      thubool = false;
                                                    });
                                                  }
                                                },
                                                child: const Text('Thu'),
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: fribool
                                                      ? const Color(0XFF407BFF)
                                                      : Colors.white,
                                                  foregroundColor: fribool
                                                      ? Colors.white
                                                      : Colors.black,
                                                  shape: const CircleBorder(),
                                                ),
                                                onPressed: () {
                                                  if (fribool == false) {
                                                    setState(() {
                                                      fribool = true;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      fribool = false;
                                                    });
                                                  }
                                                },
                                                child: const Text('Fri'),
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: satbool
                                                      ? const Color(0XFF407BFF)
                                                      : Colors.white,
                                                  foregroundColor: satbool
                                                      ? Colors.white
                                                      : Colors.black,
                                                  shape: const CircleBorder(),
                                                ),
                                                onPressed: () {
                                                  if (satbool == false) {
                                                    setState(() {
                                                      satbool = true;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      satbool = false;
                                                    });
                                                  }
                                                },
                                                child: const Text('Sat'),
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: sunbool
                                                      ? const Color(0XFF407BFF)
                                                      : Colors.white,
                                                  foregroundColor: sunbool
                                                      ? Colors.white
                                                      : Colors.black,
                                                  shape: const CircleBorder(),
                                                ),
                                                onPressed: () {
                                                  if (sunbool == false) {
                                                    setState(() {
                                                      sunbool = true;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      sunbool = false;
                                                    });
                                                  }
                                                },
                                                child: const Text('Sun'),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          width: double.infinity,
                                          height: morningDose == false
                                              ? 40 + 38
                                              : 200 + 10,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color:
                                                  Theme.of(context).cardColor),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'Morning Dose',
                                                    style: TextStyle(
                                                        color:
                                                            MyApp.themeNotifier
                                                                        .value ==
                                                                    ThemeMode
                                                                        .light
                                                                ? Colors.black
                                                                : Colors.white),
                                                  ),
                                                  Expanded(child: Container()),
                                                  Checkbox(
                                                    value: morningDose,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        morningDose = value;
                                                        if (morningDose ==
                                                            true) {
                                                          height = height + 130;
                                                        } else {
                                                          height = height - 130;
                                                        }
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              morningDose!
                                                  ? Column(
                                                      children: [
                                                        TextField(
                                                          readOnly: true,
                                                          controller:
                                                              morningdateController,
                                                          decoration:
                                                              const InputDecoration(
                                                            hintText:
                                                                'Pick Date',
                                                            border:
                                                                OutlineInputBorder(),
                                                          ),
                                                          onTap: () async {
                                                            var date = await showDatePicker(
                                                                context:
                                                                    context,
                                                                initialDate:
                                                                    DateTime
                                                                        .now(),
                                                                firstDate:
                                                                    DateTime(
                                                                        1900),
                                                                lastDate:
                                                                    DateTime(
                                                                        2100));
                                                            if (date != null) {
                                                              morningdateController
                                                                      .text =
                                                                  DateFormat(
                                                                          'MM/dd/yyyy')
                                                                      .format(
                                                                          date);
                                                            }
                                                          },
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        TextField(
                                                          readOnly: true,
                                                          controller:
                                                              morningtimeController,
                                                          decoration:
                                                              const InputDecoration(
                                                            border:
                                                                OutlineInputBorder(),
                                                            hintText:
                                                                'Pick Time',
                                                          ),
                                                          onTap: () async {
                                                            final TimeOfDay?
                                                                timeOfDay =
                                                                await showTimePicker(
                                                              context: context,
                                                              initialTime:
                                                                  TimeOfDay
                                                                      .now(),
                                                            );
                                                            if (timeOfDay !=
                                                                null) {
                                                              morningtimeController
                                                                      .text =
                                                                  timeOfDay.format(
                                                                      context);
                                                            }
                                                          },
                                                        )
                                                      ],
                                                    )
                                                  : const SizedBox(height: 0),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          width: double.infinity,
                                          height: eveningDose == false
                                              ? 40 + 38
                                              : 200 + 10,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color:
                                                  Theme.of(context).cardColor),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'Evening Dose',
                                                    style: TextStyle(
                                                        color:
                                                            MyApp.themeNotifier
                                                                        .value ==
                                                                    ThemeMode
                                                                        .light
                                                                ? Colors.black
                                                                : Colors.white),
                                                  ),
                                                  Expanded(child: Container()),
                                                  Checkbox(
                                                    value: eveningDose,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        eveningDose = value;
                                                        if (eveningDose ==
                                                            true) {
                                                          height = height + 130;
                                                        } else {
                                                          height = height - 130;
                                                        }
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              eveningDose!
                                                  ? Column(
                                                      children: [
                                                        TextField(
                                                          readOnly: true,
                                                          controller:
                                                              eveningdateController,
                                                          decoration:
                                                              const InputDecoration(
                                                            hintText:
                                                                'Pick Date',
                                                            border:
                                                                OutlineInputBorder(),
                                                          ),
                                                          onTap: () async {
                                                            var date = await showDatePicker(
                                                                context:
                                                                    context,
                                                                initialDate:
                                                                    DateTime
                                                                        .now(),
                                                                firstDate:
                                                                    DateTime(
                                                                        1900),
                                                                lastDate:
                                                                    DateTime(
                                                                        2100));
                                                            if (date != null) {
                                                              eveningdateController
                                                                      .text =
                                                                  DateFormat(
                                                                          'MM/dd/yyyy')
                                                                      .format(
                                                                          date);
                                                            }
                                                          },
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        TextField(
                                                          readOnly: true,
                                                          controller:
                                                              eveningtimeController,
                                                          decoration:
                                                              const InputDecoration(
                                                            border:
                                                                OutlineInputBorder(),
                                                            hintText:
                                                                'Pick Time',
                                                          ),
                                                          onTap: () async {
                                                            final TimeOfDay?
                                                                timeOfDay =
                                                                await showTimePicker(
                                                              context: context,
                                                              initialTime:
                                                                  TimeOfDay
                                                                      .now(),
                                                            );
                                                            if (timeOfDay !=
                                                                null) {
                                                              eveningtimeController
                                                                      .text =
                                                                  timeOfDay.format(
                                                                      context);
                                                            }
                                                          },
                                                        )
                                                      ],
                                                    )
                                                  : const SizedBox(height: 0),
                                            ],
                                          ),
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
                                                createNewReminder();
                                                setState(() {
                                                  loading = false;
                                                });
                                              },
                                              child: const Text(
                                                'Create',
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
                ),
              ),
            )),
          );
  }

  createNewReminder() async {}
}
