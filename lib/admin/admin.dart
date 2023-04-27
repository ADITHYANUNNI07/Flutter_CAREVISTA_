import 'package:carevista_ver05/Administration/mainpageAdmin.dart';
import 'package:carevista_ver05/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:lottie/lottie.dart';
import 'package:carevista_ver05/widget/widget.dart';

class AdminKeyEnableScreen extends StatefulWidget {
  AdminKeyEnableScreen({required this.administrationphoneno, super.key});
  String administrationphoneno;
  @override
  State<AdminKeyEnableScreen> createState() => _AdminKeyEnableScreenState();
}

final fromKey = GlobalKey<FormState>();
TextEditingController phoneController = TextEditingController();
TextEditingController otpController = TextEditingController();

FirebaseAuth auth = FirebaseAuth.instance;
bool AnimatedLoading = false;
bool otpVisibility = false;
String phoneno = '';
String verificationID = "";

class _AdminKeyEnableScreenState extends State<AdminKeyEnableScreen> {
  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    otpController = TextEditingController();
    AnimatedLoading = false;
    otpVisibility = false;
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
            child: SafeArea(
                child: Scaffold(
            backgroundColor: MyApp.themeNotifier.value == ThemeMode.light
                ? Colors.white
                : Theme.of(context).canvasColor,
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
                  padding: const EdgeInsets.all(25),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyApp.themeNotifier.value == ThemeMode.light
                            ? Lottie.asset(
                                'animation/9573-analytics.json',
                                // path to your Lottie animation file
                                repeat:
                                    true, // whether the animation should loop
                                reverse:
                                    false, // whether the animation should play in reverse
                                animate:
                                    true, // whether the animation should start playing automatically
                              )
                            : Lottie.asset(
                                'animation/adminlight.json',
                                // path to your Lottie animation file
                                repeat:
                                    true, // whether the animation should loop
                                reverse:
                                    false, // whether the animation should play in reverse
                                animate:
                                    true, // whether the animation should start playing automatically
                              ),
                        const SizedBox(height: 1),
                        const Text(
                          'Admin Control Panel',
                          style:
                              TextStyle(fontFamily: 'brandon_H', fontSize: 45),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Admin Verification.Enter the Phone No. & OTP',
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
                                      prefixIcon: Icon(Icons.password_outlined),
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
                            child: Text(otpVisibility ? "Verify" : "Check"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  MyApp.themeNotifier.value == ThemeMode.light
                                      ? Colors.black
                                      : const Color(0xFFFB4C5B),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 13),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )));
  }

  void loginWithPhone() async {
    setState(() {
      AnimatedLoading = true;
    });
    phoneno = '+91' + phoneController.text;
    if (phoneno == widget.administrationphoneno) {
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
    } else {
      setState(() {
        newshowSnackbar(context, 'Invalid Phone Number',
            'Please Enter the correct Phone No.', ContentType.failure);
        AnimatedLoading = false;
      });
    }
  }

  void verifyOTP() async {
    setState(() {
      AnimatedLoading = true;
    });
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then((value) async {
      nextScreenReplace(context, const AdminMainPage());
    }).catchError((e) {
      setState(() {
        newshowSnackbar(context, 'Incorrect OTP',
            'Please Enter the correct OTP', ContentType.failure);
        AnimatedLoading = false;
      });
    });
  }
}
