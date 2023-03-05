import 'package:carevista_ver05/SCREEN/login.dart';
import 'package:carevista_ver05/SCREEN/signup.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:flutter/material.dart';

class LoginSignUpScreen extends StatelessWidget {
  const LoginSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      color: const Color(0xFF04FBC3),
      child: SafeArea(
        child: Scaffold(
          body: Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    'Assets/images/Login_SignUp_pic.png',
                    height: height * 0.6,
                  ),
                  Column(
                    children: [
                      const Text(
                        'CARE VISTA',
                        style: TextStyle(fontSize: 40, fontFamily: 'brandon_H'),
                      ),
                      Text(
                        'Personalized Healthcare Assistant for all your health needs including services @home.',
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              shape: const RoundedRectangleBorder(),
                              foregroundColor: Colors.black,
                              side: const BorderSide(
                                color: Colors.black,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12)),
                          onPressed: () {
                            nextScreenReplace(context, LoginScreen());
                          },
                          child: const Text('LOGIN'),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: const RoundedRectangleBorder(),
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.black,
                                  side: const BorderSide(
                                    color: Color(0xFF00008F),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12)),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => SignupScreen(),
                                  ),
                                );
                              },
                              child: const Text('SIGNUP')))
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
