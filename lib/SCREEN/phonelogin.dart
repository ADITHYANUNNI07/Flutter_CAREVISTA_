import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:carevista_ver05/Helper/helper_function.dart';
import 'package:carevista_ver05/SCREEN/dashboard.dart';
import 'package:carevista_ver05/Service/database_service.dart';
import 'package:carevista_ver05/main.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';

class LoginPhoneNo extends StatefulWidget {
  const LoginPhoneNo({super.key});

  @override
  State<LoginPhoneNo> createState() => _LoginPhoneNoState();
}

final fromKey = GlobalKey<FormState>();
TextEditingController phoneController = TextEditingController();
TextEditingController otpController = TextEditingController();

FirebaseAuth auth = FirebaseAuth.instance;

bool otpVisibility = false;
String phoneno = '';
String verificationID = "";
bool AnimatedLoading = false;

class _LoginPhoneNoState extends State<LoginPhoneNo> {
  @override
  void initState() {
    super.initState();
    otpVisibility = false;
    phoneController = TextEditingController();
    otpController = TextEditingController();
    setState(() {
      AnimatedLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedLoading
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
                                'Assets/images/Authentication-pana.png'),
                            const SizedBox(height: 1),
                            const Text(
                              'Login with Phone Number',
                              style: TextStyle(
                                  fontFamily: 'brandon_H', fontSize: 45),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Phone Number Verification.',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            const SizedBox(height: 20),
                            Column(
                              children: [
                                TextField(
                                  controller: phoneController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.phone),
                                    border: OutlineInputBorder(),
                                    label: Text('Phone Number'),
                                  ),
                                ),
                                Visibility(
                                  visible: otpVisibility,
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      TextField(
                                        controller: otpController,
                                        decoration: const InputDecoration(
                                          prefixIcon:
                                              Icon(Icons.password_outlined),
                                          border: OutlineInputBorder(),
                                          label: Text('OTP'),
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (phoneController.text.isNotEmpty) {
                                    if (phoneController.text.length == 10) {
                                      if (otpVisibility) {
                                        verifyOTP();
                                      } else {
                                        loginWithPhone();
                                      }
                                    } else {
                                      newshowSnackbar(
                                          context,
                                          'Invalid Phone Number',
                                          'Please Enter Phone Number without Country code',
                                          ContentType.failure);
                                    }
                                  } else {
                                    newshowSnackbar(
                                        context,
                                        'Phone Number',
                                        'Please Enter the Phone Number',
                                        ContentType.failure);
                                  }
                                },
                                // ignore: sort_child_properties_last
                                child: Text(otpVisibility ? "Verify" : "Login"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 13),
                                ),
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

  void loginWithPhone() async {
    setState(() {
      AnimatedLoading = true;
    });
    phoneno = '+91' + phoneController.text;
    auth.verifyPhoneNumber(
      // ignore: prefer_interpolation_to_compose_strings
      phoneNumber: '+91' + phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {});
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {
          AnimatedLoading = false;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP() async {
    setState(() {
      AnimatedLoading = true;
    });
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then((value) async {
      QuerySnapshot snapshot =
          await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
              .gettingUserDatapH(phoneno);
      if (snapshot.docs.isEmpty) {
        // phone number not present in the database
        // ignore: use_build_context_synchronously
        newshowSnackbar(context, 'Incorrect Phone Number',
            'Please sign up to create a new account.', ContentType.failure);
        return false;
      }
      // saving the values to our shared preferences
      await HelperFunction.saveUserLoggedInStatus(true);
      await HelperFunction.saveUserNameSF(snapshot.docs[0]['fullName']);
      await HelperFunction.saveUserEmailSF(snapshot.docs[0]['email']);
      await HelperFunction.saveUserPhoneSF(phoneno);
      await HelperFunction.saveUserAdkeyFromSF(snapshot.docs[0]['AdKey']);
      await HelperFunction.saveUserUIDFromSF(snapshot.docs[0]['uid']);
      await HelperFunction.saveUserImageURLSF(snapshot.docs[0]['profilepic']);
      nextScreenReplace(context, const Dashboard());
    }).catchError((e) {
      newshowSnackbar(context, 'Incorrect OTP', 'Please Enter the correct OTP',
          ContentType.failure);
    });
  }
}
