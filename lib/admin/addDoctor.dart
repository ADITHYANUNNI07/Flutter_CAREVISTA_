import 'package:flutter/material.dart';

import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class AddDoctor extends StatefulWidget {
  const AddDoctor({super.key});

  @override
  State<AddDoctor> createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
  final fromKey = GlobalKey<FormState>();
  String fullname = "";
  String phone = "";
  String email = "";
  String yearexp = "";
  String specialist = "";
  String quali = "";
  String hospitalName = "";
  String feeDo = "";
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
            'Add Doctor Details',
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
                                prefixIcon:
                                    const Icon(Icons.person_outline_outlined),
                                labelText: 'Full Name',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100))),
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
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.star_border),
                                labelText: 'Specialist',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100))),
                            onChanged: (val) {
                              specialist = val;
                            },
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
                            }),
                        const SizedBox(height: 10),
                        TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: const Icon(LineAwesomeIcons.quran),
                                labelText: 'Qualification',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100))),
                            onChanged: (val) {
                              specialist = val;
                            },
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
                            }),
                        const SizedBox(height: 10),
                        TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.phone_outlined),
                                labelText: 'Phone No',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100))),
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
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email_outlined),
                              labelText: 'E-Mail',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100))),
                          onChanged: (val) {
                            email = val;
                          },
                          // check tha validation
                          validator: (val) {
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val!)
                                ? null
                                : "Please enter a valid email";
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                    LineAwesomeIcons.hospital_symbol),
                                labelText: 'Hospital Name',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100))),
                            onChanged: (val) {
                              hospitalName = val;
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
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.explore_rounded),
                            labelText: 'Years of experience',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100)),
                          ),
                          onChanged: (val) {
                            yearexp = val;
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please Enter Years of experience";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon:
                                const Icon(LineAwesomeIcons.wavy_money_bill),
                            labelText: 'Fee',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100)),
                          ),
                          onChanged: (val) {
                            feeDo = val;
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return null;
                            } else {
                              return null;
                            }
                          },
                        ),
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
                              onPressed: () {},
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
}
