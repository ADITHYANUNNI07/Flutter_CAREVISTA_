import 'dart:ffi';
import 'dart:isolate';
import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:carevista_ver05/SCREEN/otpverification.dart';
import 'package:carevista_ver05/Service/database_service.dart';
import 'package:carevista_ver05/utils/utils.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ForgotPwdEmail extends StatefulWidget {
  const ForgotPwdEmail({super.key});

  @override
  State<ForgotPwdEmail> createState() => _ForgotPwdEmailState();
}

class _ForgotPwdEmailState extends State<ForgotPwdEmail> {
  final fromKey = GlobalKey<FormState>();
  String email = "";
  String otpCode = "";
  bool otpfield = false;
  bool submitValid = false;

  /// Text editing controllers to get the value from text fields
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _otpcontroller = TextEditingController();

  // Declare the object
  EmailAuth emailAuth = new EmailAuth(sessionName: "Sample session");
  @override
  void initState() {
    super.initState();
    // Initialize the package

    new EmailAuth(
      sessionName: "Sample session",
    );

    /// Configuring the remote server
    //emailAuth.config(remot);
  }

  /// a void function to verify if the Data provided is true
  /// Convert it into a boolean function to match your needs.
  void verify() {
    print(emailAuth.validateOtp(
        recipientMail: _emailcontroller.value.text,
        userOtp: _otpcontroller.value.text));
  }

  /// a void funtion to send the OTP to the user
  /// Can also be converted into a Boolean function and render accordingly for providers
  void sendOtp() async {
    bool result = await emailAuth.sendOtp(
        recipientMail: _emailcontroller.value.text, otpLength: 5);
    if (result) {
      setState(() {
        submitValid = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF04FBC3),
      child: SafeArea(
        child: Scaffold(
            body: Stack(
          children: [
            Positioned(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back, size: 34),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(35),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'Assets/images/Forgot_Pwd_pic.png',
                      width: 250,
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      'Forgot Password',
                      style: TextStyle(fontFamily: 'brandon_H', fontSize: 45),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Reset via E-Mail Verification.',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: fromKey,
                      child: TextFormField(
                        controller: _emailcontroller,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(),
                          label: Text('E-Mail'),
                        ),
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
                    ),
                    const SizedBox(height: 10),
                    otpfield == true
                        ? OtpTextField(
                            fieldWidth: 42.1,
                            numberOfFields: 6,
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.1),
                            onSubmit: (value) {
                              setState(() {
                                otpCode = value;
                                print(otpCode);
                              });
                            },
                          )
                        : Container(),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          sendOtp();
                          print(otpfield);
                          if (fromKey.currentState!.validate()) {
                            if (otpfield == false) {
                              otpfield = true;
                              print(otpfield);
                            } else {
                              setState(() {
                                if (otpCode == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.transparent,
                                          elevation: 0,
                                          behavior: SnackBarBehavior.floating,
                                          content: AwesomeSnackbarContent(
                                              inMaterialBanner: true,
                                              title: 'OTP Field..!',
                                              message: 'OTP field is Empty',
                                              contentType:
                                                  ContentType.warning)));
                                } else {
                                  verify();
                                }
                              });
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 13),
                        ),
                        child: otpfield == true
                            ? Text('Verify OTP')
                            : Text('Next'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}

class ForgotPwdPhone extends StatefulWidget {
  const ForgotPwdPhone({super.key});

  @override
  State<ForgotPwdPhone> createState() => _ForgotPwdPhoneState();
}

class _ForgotPwdPhoneState extends State<ForgotPwdPhone> {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  var pNumber = '';
  bool result = false;
  final fromKey = GlobalKey<FormState>();
  Country selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );
  @override
  Widget build(BuildContext context) {
    /*number.selection = TextSelection.fromPosition(
      TextPosition(
        offset: number.text.length,
      ),
    );*/
    return Container(
      color: const Color(0xFF04FBC3),
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Positioned(
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back, size: 34),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(35),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('Assets/images/Forgot_Pwd_pic.png'),
                      const SizedBox(height: 25),
                      const Text(
                        'Forgot Password',
                        style: TextStyle(fontFamily: 'brandon_H', fontSize: 45),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Reset via Phone Number Verification.',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      const SizedBox(height: 20),
                      Form(
                        key: fromKey,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            //prefixIcon: Icon(Icons.phone_outlined),
                            border: const OutlineInputBorder(),
                            hintText: "Enter Phone Number",
                            hintStyle: Theme.of(context).textTheme.bodyText1,

                            prefixIcon: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  showCountryPicker(
                                      context: context,
                                      countryListTheme:
                                          const CountryListThemeData(
                                        bottomSheetHeight: 550,
                                      ),
                                      onSelect: (value) {
                                        setState(() {
                                          selectedCountry = value;
                                        });
                                      });
                                },
                                child: Text(
                                  "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            suffixIcon: pNumber.length > 9
                                ? Container(
                                    height: 30,
                                    width: 30,
                                    margin: const EdgeInsets.all(10.0),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green,
                                    ),
                                    child: const Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  )
                                : null,
                          ),
                          onChanged: (value) {
                            pNumber = value;
                            print(pNumber);
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            var Phonenumber = "+91$pNumber";
                            print(Phonenumber);
                            FirebaseFirestore.instance
                                .collection("Users")
                                .where("phoneNo", isEqualTo: Phonenumber)
                                .get()
                                .then((value) => {
                                      print(value.docs.length),
                                      if (value.docs.length == 0)
                                        {
                                          print("its new user"),
                                        }
                                      else
                                        {
                                          print("its old user"),
                                        }
                                    });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 13),
                          ),
                          child: const Text('Next'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*Future checkPhoneNo(phonenumber) async {
    FirebaseFirestore.instance
        .collection("users")
        .where("phoneNo", isEqualTo: phonenumber)
        .get()
        .then((value) {
      if (value != null) {
        return true;
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'This number is found.',
                style: TextStyle(fontSize: 14),
              ),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 5),
              action: SnackBarAction(
                label: "OK",
                onPressed: () {},
                textColor: Colors.white,
              ),
            ),
          );
        });
      }
    });
  }*/

  /*void phoneVali() {
    var Phonenumber = "+91$pNumber";
    print(Phonenumber);
    FirebaseFirestore.instance
        .collection("Users")
        .where("phone", isEqualTo: Phonenumber)
        .get()
        .then((value) => {
              print(value.docs.length),
              if (value.docs.length == 0)
                {
                  print("its new user"),
                }
            });
    /*checkPhoneNo(
        Phonenumber); .then((value) => value > 0
            ? //setState(() {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'This number is found.',
                    style: TextStyle(fontSize: 14),
                  ),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 5),
                  action: SnackBarAction(
                    label: "OK",
                    onPressed: () {},
                    textColor: Colors.white,
                  ),
                ),
              )
            // })
            : //result = false
            //setState(() {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Sorry this number is not found.',
                    style: TextStyle(fontSize: 14),
                  ),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 5),
                  action: SnackBarAction(
                    label: "OK",
                    onPressed: () {},
                    textColor: Colors.white,
                  ),
                ),
              )
        //}),
        );*/
    /*if (result == true) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'This number is found.',
              style: TextStyle(fontSize: 14),
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
            action: SnackBarAction(
              label: "OK",
              onPressed: () {},
              textColor: Colors.white,
            ),
          ),
        );
      });
    } else {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Sorry this number is not found.',
              style: TextStyle(fontSize: 14),
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
            action: SnackBarAction(
              label: "OK",
              onPressed: () {},
              textColor: Colors.white,
            ),
          ),
        );
      });
    }*/
  }*/
}
