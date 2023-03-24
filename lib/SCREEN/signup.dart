import 'package:carevista_ver05/Helper/helper_function.dart';
import 'package:carevista_ver05/SCREEN/dashboard.dart';
import 'package:carevista_ver05/SCREEN/login.dart';
import 'package:carevista_ver05/Service/auth_service.dart';
import 'package:carevista_ver05/Service/database_service.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isLoding = false;
  AuthService authService = AuthService();
  final fromKey = GlobalKey<FormState>();
  String fullname = "";
  String password = "";
  String email = "";
  var number = "";
  String adKey = "false";
  // final TextEditingController phoneController = TextEditingController();
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
    // ignore: unused_local_variable

    final size = MediaQuery.of(context).size;
    return Container(
      color: const Color(0xFF04FBC3),
      child: Container(
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
                    padding: const EdgeInsets.symmetric(horizontal: 48),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('Assets/images/Login_pic.png',
                              height: size.height * 0.245),
                          const Text(
                            'Create New Account',
                            style: TextStyle(
                                fontSize: 35, fontFamily: 'brandon_H'),
                          ),
                          Text(
                            'make it work,make it right,make it fast.',
                            style: Theme.of(context).textTheme.bodyText2,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Form(
                            key: fromKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                    decoration: const InputDecoration(
                                        prefixIcon:
                                            Icon(Icons.person_outline_outlined),
                                        labelText: 'Full Name',
                                        border: OutlineInputBorder()),
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
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      hintText: "Enter Phone Number",
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
                                              //color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      suffixIcon: number.length > 9
                                          ? Container(
                                              height: 30,
                                              width: 30,
                                              margin:
                                                  const EdgeInsets.all(10.0),
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
                                    onChanged: (val) {
                                      number = val;
                                    },
                                    validator: (val) {
                                      return RegExp(
                                                  r"(^(?:[+0]9)?[0-9]{10,12}$)")
                                              .hasMatch(val!)
                                          ? null
                                          : "Please enter valid mobile number";
                                    }),
                                const SizedBox(height: 10),
                                TextFormField(
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.email_outlined),
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
                                  decoration: const InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.fingerprint_outlined),
                                    labelText: 'Password',
                                    border: OutlineInputBorder(),
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
                                const SizedBox(height: 10),
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
                                        signup();
                                      },
                                      child: const Text('SIGNUP')),
                                )
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 10),
                              const Text('OR'),
                              const SizedBox(height: 15),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton.icon(
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 13),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                                },
                                child: Text.rich(
                                  TextSpan(
                                    text: "Already have an Account?",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                    children: const [
                                      TextSpan(
                                        text: 'Login',
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
      ),
    );
  }

  signup() async {
    if (fromKey.currentState!.validate()) {
      setState(() {
        _isLoding = true;
      });
      var phoneumber = "+${selectedCountry.phoneCode}$number";
      await authService
          .createUserAccount(fullname, phoneumber, email, password, adKey)
          .then((value) async {
        if (value == true) {
          //saving the shared preference state
          await HelperFunction.saveUserLoggedInStatus(true);
          await HelperFunction.saveUserNameSF(fullname);
          await HelperFunction.saveUserEmailSF(email);
          await HelperFunction.saveUserPhoneSF(phoneumber);
          await HelperFunction.saveUserAdkeyFromSF(adKey);
          QuerySnapshot snapshot =
              await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .gettingUserData(email);
          await HelperFunction.saveUserUIDFromSF(snapshot.docs[0]['uid']);
          // ignore: use_build_context_synchronously
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
