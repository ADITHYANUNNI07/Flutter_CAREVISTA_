import 'package:carevista_ver05/SCREEN/login.dart';
import 'package:carevista_ver05/SCREEN/signup.dart';
import 'package:carevista_ver05/main.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginSignUpScreen extends StatelessWidget {
  const LoginSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      color: const Color(0xFF04FBC3),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyApp.themeNotifier.value == ThemeMode.light
              ? Colors.white
              : Theme.of(context).canvasColor,
          body: Container(
              color: MyApp.themeNotifier.value == ThemeMode.light
                  ? Colors.white
                  : Theme.of(context).canvasColor,
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyApp.themeNotifier.value == ThemeMode.light
                      ? Container(
                          height: 500, // set the height of the container to 300
                          width: 500, // set the width of the container to 300
                          color: MyApp.themeNotifier.value == ThemeMode.light
                              ? Colors.white
                              : Theme.of(context).canvasColor,
                          child: FractionallySizedBox(
                            widthFactor:
                                1, // set the width factor to 0.8 to take 80% of the container's width
                            heightFactor:
                                1, // set the height factor to 0.8 to take 80% of the container's height
                            child: Lottie.asset(
                              'animation/73386-problem-solving-team.json',
                            ),
                          ),
                        )
                      : Container(
                          height: 500, // set the height of the container to 300
                          width: 500, // set the width of the container to 300
                          color: Theme.of(context).canvasColor,
                          child: FractionallySizedBox(
                            widthFactor:
                                1, // set the width factor to 0.8 to take 80% of the container's width
                            heightFactor:
                                1, // set the height factor to 0.8 to take 80% of the container's height
                            child: Lottie.network(
                              'https://assets7.lottiefiles.com/packages/lf20_l13zwx3i.json',
                            ),
                          ),
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
                          textAlign: TextAlign.center),
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
