import 'package:carevista_ver05/Helper/helper_function.dart';
import 'package:carevista_ver05/SCREEN/dashboard.dart';
import 'package:carevista_ver05/SCREEN/phonelogin.dart';
import 'package:carevista_ver05/SCREEN/signup.dart';
import 'package:carevista_ver05/Service/auth_service.dart';
import 'package:carevista_ver05/Service/database_service.dart';
import 'package:carevista_ver05/main.dart';

import 'package:carevista_ver05/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoding = false;
  }

  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final size = MediaQuery.of(context).size;
    return _isLoding
        ? Container(
            height: 300, // set the height of the container to 300
            width: 300, // set the width of the container to 300
            color: MyApp.themeNotifier.value == ThemeMode.light
                ? Colors.white
                : Theme.of(context).canvasColor,
            child: FractionallySizedBox(
              widthFactor:
                  0.4, // set the width factor to 0.8 to take 80% of the container's width
              heightFactor:
                  0.4, // set the height factor to 0.8 to take 80% of the container's height
              child: Lottie.network(
                'https://assets5.lottiefiles.com/packages/lf20_Qkk8MTZ8T4.json',
              ),
            ),
          )
        : Container(
            color: const Color(0xFF04FBC3),
            child: SafeArea(
              child: Scaffold(
                body: Container(
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
                                      nextScreen(context, const LoginPhoneNo());
                                    },
                                    child: Text(
                                      'Other Way To Login?',
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
          await HelperFunction.saveUserImageURLSF(
              snapshot.docs[0]['profilepic']);
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
