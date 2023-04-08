import 'package:carevista_ver05/Helper/helper_function.dart';
import 'package:carevista_ver05/SCREEN/dashboard.dart';
import 'package:carevista_ver05/SCREEN/forgotpass.dart';
import 'package:carevista_ver05/SCREEN/login_with_phone.dart';
import 'package:carevista_ver05/SCREEN/send_otp.dart';
import 'package:carevista_ver05/SCREEN/signup.dart';
import 'package:carevista_ver05/Service/auth_service.dart';
import 'package:carevista_ver05/Service/database_service.dart';

import 'package:carevista_ver05/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool passVisible = false;

class _LoginScreenState extends State<LoginScreen> {
  AuthService authService = AuthService();
  bool _isLoding = false;
  final fromKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  bool adkey = false;
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final size = MediaQuery.of(context).size;
    return Container(
      color: const Color(0xFF04FBC3),
      child: SafeArea(
        child: Scaffold(
          body: _isLoding
              ? Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(35),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'Assets/images/Login_pic.png',
                          height: size.height * 0.27,
                        ),
                        const Text(
                          'Welcome Back.',
                          style: TextStyle(
                            fontFamily: 'brandon_H',
                            fontSize: 40,
                          ),
                        ),
                        Text(
                          'Make it work,make it right,make it fast.',
                          style: Theme.of(context).textTheme.subtitle1,
                          textAlign: TextAlign.center,
                        ),
                        Form(
                          key: fromKey,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                TextFormField(
                                  decoration: const InputDecoration(
                                      prefixIcon:
                                          Icon(Icons.person_outline_outlined),
                                      labelText: 'E-Mail',
                                      border: OutlineInputBorder()),
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
                                  obscureText: passVisible ? false : true,
                                  decoration: InputDecoration(
                                    prefixIcon:
                                        const Icon(Icons.fingerprint_outlined),
                                    labelText: 'Password',
                                    border: const OutlineInputBorder(),
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
                                          ? const Icon(LineAwesomeIcons.eye)
                                          : const Icon(
                                              LineAwesomeIcons.eye_slash),
                                    ),
                                  ),
                                  onChanged: (val) {
                                    password = val;
                                  },
                                  validator: (val) {
                                    if (val!.length < 6) {
                                      return "Password must be at least 6 characters";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                //const SizedBox(height: 0),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        builder: (context) => Container(
                                          padding: const EdgeInsets.all(34),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              const Text(
                                                'Make Selection!',
                                                style: TextStyle(
                                                    fontSize: 40,
                                                    fontFamily: 'brandon_H'),
                                              ),
                                              Text(
                                                  'Select one of the options given below to reset your password.',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2),
                                              const SizedBox(height: 30),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const Forgot() /*ForgotPwdEmail()*/));
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color:
                                                          Colors.grey.shade200),
                                                  child: Row(
                                                    // ignore: prefer_const_literals_to_create_immutables
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .mail_outline_rounded,
                                                        size: 60,
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        // ignore: prefer_const_literals_to_create_immutables

                                                        children: [
                                                          const Text(
                                                            'E-Mail',
                                                            style: TextStyle(
                                                                fontSize: 19,
                                                                fontFamily:
                                                                    'brandon_H'),
                                                          ),
                                                          Text(
                                                            'Reset via E-Mail Verification.',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1,
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              LoginWithPhone()
                                                          //const ForgotPwdPhone()
                                                          ));
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color:
                                                          Colors.grey.shade200),
                                                  child: Row(
                                                    // ignore: prefer_const_literals_to_create_immutables
                                                    children: [
                                                      const Icon(
                                                        Icons.phone_outlined,
                                                        size: 60,
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        // ignore: prefer_const_literals_to_create_immutables

                                                        children: [
                                                          const Text(
                                                            'Phone No',
                                                            style: TextStyle(
                                                                fontSize: 19,
                                                                fontFamily:
                                                                    'brandon_H'),
                                                          ),
                                                          Text(
                                                            'Reset via Phone Verification.',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1,
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Forgot Password?',
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 13),
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.black,
                                      ),
                                      onPressed: () {
                                        login();
                                      },
                                      child: const Text(
                                        'LOGIN',
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('OR'),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 13),
                                  foregroundColor: Colors.black,
                                  side: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                onPressed: () {},
                                icon: Image.asset(
                                  'Assets/images/Google_Icon.png',
                                  width: 21,
                                ),
                                label: Text('Sign-in with Google',
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
                              ),
                            ),
                            //const SizedBox(height: 10),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SignupScreen()));
                              },
                              child: Text.rich(
                                TextSpan(
                                  text: "Don't have an Account?",
                                  style: Theme.of(context).textTheme.bodyText1,
                                  children: const [
                                    TextSpan(
                                      text: 'Signup',
                                      style: TextStyle(color: Colors.blue),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  login() async {
    if (fromKey.currentState!.validate()) {
      setState(() {
        _isLoding = true;
      });
      await authService.loginUserAccount(email, password).then((value) async {
        if (value == true) {
          QuerySnapshot snapshot =
              await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .gettingUserData(email);
          // saving the values to our shared preferences
          await HelperFunction.saveUserLoggedInStatus(true);
          await HelperFunction.saveUserNameSF(snapshot.docs[0]['fullName']);
          await HelperFunction.saveUserEmailSF(email);
          await HelperFunction.saveUserPhoneSF(snapshot.docs[0]['phoneNo']);
          await HelperFunction.saveUserAdkeyFromSF(snapshot.docs[0]['AdKey']);
          await HelperFunction.saveUserUIDFromSF(snapshot.docs[0]['uid']);
          // ignore: use_build_context_synchronously
          //provide_phoneotp.dart...update..profile
          nextScreenReplace(context, Dashboard());
        } else {
          setState(() {
            showSnackbar(context, Colors.red, value);
            _isLoding = false;
          });
        }
      });
    }
  }
}
