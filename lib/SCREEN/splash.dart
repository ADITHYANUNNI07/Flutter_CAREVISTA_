// ignore: file_names
import 'package:carevista_ver05/Helper/helper_function.dart';
import 'package:carevista_ver05/SCREEN/dashboard.dart';
import 'package:carevista_ver05/SCREEN/login.dart';
import 'package:carevista_ver05/SCREEN/welcome.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

bool _isSignedIn = false;
bool animate = false;

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    //gotoLogin();
    animatedShape();
    getUserLoggedInStatus();
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'Assets/images/LOGO.png',
                    height: 210,
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: 430,
                child: Container(
                  width: double.infinity,
                  height: 430,
                ),
              ),
              Container(
                width: double.infinity,
                child: Lottie.asset(
                  'animation/17169-smooth-healthy-animation (1).json',

                  //'animation/9573-analytics.json',
                  // path to your Lottie animation file
                  repeat: true, // whether the animation should loop
                  reverse:
                      false, // whether the animation should play in reverse
                  animate:
                      true, // whether the animation should start playing automatically
                ),
              ),
            ],
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1600),
            bottom: animate ? 0 : -30,
            left: animate ? 0 : -30,
            child: Image.asset(
              'Assets/images/SplashShapeblue.png',
              height: 180,
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1600),
            top: animate ? 0 : -30,
            right: animate ? 0 : -30,
            child: Image.asset(
              'Assets/images/SplashShapeTopBlue.png',
              height: 120,
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF04FBC3),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future animatedShape() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    setState(() => animate = true);
    await Future.delayed(const Duration(milliseconds: 5000));

    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => _isSignedIn ? Dashboard() : const ScreenWelcome(),
      ),
    );
  }

  void getUserLoggedInStatus() async {
    await HelperFunction.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }
}
