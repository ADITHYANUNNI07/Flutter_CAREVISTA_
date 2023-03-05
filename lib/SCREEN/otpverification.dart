import 'package:carevista_ver05/SCREEN/changepass.dart';
import 'package:carevista_ver05/SCREEN/signup.dart';
import 'package:carevista_ver05/Service/provider_phoneotp.dart';
import 'package:carevista_ver05/utils/utils.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';

class OTPVerification extends StatefulWidget {
  final String verificationId;
  const OTPVerification({super.key, required this.verificationId});

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  String? otpCode;
  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Container(
      color: const Color(0xFF04FBC3),
      child: SafeArea(
          child: Scaffold(
        body: isLoading == true
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              )
            : Stack(
                children: [
                  Positioned(
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back, size: 34),
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Image.asset('Assets/images/Otp_pic.png'),
                            const SizedBox(height: 0),
                            const Text(
                              'OTP Verification',
                              style: TextStyle(
                                  fontFamily: 'brandon_H', fontSize: 45),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Enter the Verification code send at support\n @care vista.com.",
                              style: Theme.of(context).textTheme.bodyText2,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            OtpTextField(
                              fieldWidth: 46.1,
                              numberOfFields: 6,
                              filled: true,
                              fillColor: Colors.black.withOpacity(0.1),
                              onSubmit: (value) {
                                setState(() {
                                  otpCode = value;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  {
                                    if (otpCode != null) {
                                      verifyOtp(context, otpCode!);
                                    } else {
                                      showSnackBar(
                                          context, "Enter 6-Digit code");
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.black,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 13)),
                                child: const Text('Verify'),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text("Didn't receive any code?",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black38,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      )),
    );
  } // verify otp

  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
        // checking whether user exists in the db
        ap.checkExistingUser().then(
          (value) async {
            if (value == true) {
              // user exists in our app
              /* ap.getDataFromFirestore().then(
                    (value) => ap.saveUserDataToSP().then(
                          (value) => ap.setSignIn().then(
                                (value) => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomeScreen(),
                                    ),
                                    (route) => false),
                              ),
                        ),
                  );*/
            } else {
              // new user
              nextScreenReplace(context, SignupScreen());
              setState(() {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      'Sorry this number is not found.Please SignUp',
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
          },
        );
      },
    );
  }
}
