import 'package:carevista_ver05/SCREEN/login_signup.dart';
import 'package:carevista_ver05/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ScreenWelcome extends StatefulWidget {
  const ScreenWelcome({super.key});

  @override
  State<ScreenWelcome> createState() => _ScreenWelcomeState();
}

class _ScreenWelcomeState extends State<ScreenWelcome> {
  final LiqController = LiquidController();

  int CurrentPage = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            onPageChangeCallback: onPageChangedCallback,
            liquidController: LiqController,
            //slideIconWidget: const Icon(Icons.arrow_back_ios),
            //enableSideReveal: false,
            pages: [
              Container(
                //FIRST SLIDE PAGE

                padding: const EdgeInsets.all(25.0),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 400, // set the height of the container to 300
                      width: 400, // set the width of the container to 300
                      color: MyApp.themeNotifier.value == ThemeMode.light
                          ? Colors.white
                          : Theme.of(context).canvasColor,
                      child: FractionallySizedBox(
                        widthFactor:
                            1, // set the width factor to 0.8 to take 80% of the container's width
                        heightFactor:
                            1, // set the height factor to 0.8 to take 80% of the container's height
                        child: Lottie.asset(
                          'animation/welcome2.json',
                        ),
                      ),
                    ),
                    Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text(
                          'Welcome to',
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'brandon_N',
                          ),
                        ),
                        const Text(
                          'CARE VISTA',
                          style:
                              TextStyle(fontSize: 40, fontFamily: 'brandon_H'),
                        ),
                        Text(
                          "Say hello to Kerala's top Hospital.",
                          style: GoogleFonts.monda(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          "Find suitable doctors and hospitals",
                          style:
                              GoogleFonts.monda(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    const Text('1/3',
                        style:
                            TextStyle(fontSize: 19, fontFamily: 'brandon_N')),
                    const SizedBox(height: 50)
                  ],
                ),
              ),
              Container(
                //SEACOND SLIDE PAGE

                padding: const EdgeInsets.all(25.0),
                color: const Color(0xFF82bcff),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 400, // set the height of the container to 300
                      width: 400, // set the width of the container to 300
                      color: MyApp.themeNotifier.value == ThemeMode.light
                          ? const Color(0xFF82bcff)
                          : Theme.of(context).canvasColor,
                      child: FractionallySizedBox(
                        widthFactor:
                            1, // set the width factor to 0.8 to take 80% of the container's width
                        heightFactor:
                            1, // set the height factor to 0.8 to take 80% of the container's height
                        child: Lottie.network(
                          'https://assets8.lottiefiles.com/private_files/lf30_oclvo23h.json',
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        const Text(
                          'ADDONS',
                          style:
                              TextStyle(fontSize: 24, fontFamily: 'brandon_H'),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '24 x 7 Service Support.\nMedicine Reminder: Reminds you about your medicines\nPatient Record: Record of your previous treatments.\nDisease compilation: Information about common diseases ',
                          style:
                              GoogleFonts.monda(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    const Text(
                      '2/3',
                      style: TextStyle(fontSize: 19, fontFamily: 'brandon_N'),
                    ),
                    const SizedBox(height: 50)
                  ],
                ),
              ),
              Container(
                //THIRD SLIDE PAGE

                padding: const EdgeInsets.all(30.0),
                color: const Color(0xFF1c7b8f),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 400, // set the height of the container to 300
                      width: 400, // set the width of the container to 300
                      color: MyApp.themeNotifier.value == ThemeMode.light
                          ? const Color(0xFF1c7b8f)
                          : Theme.of(context).canvasColor,
                      child: FractionallySizedBox(
                        widthFactor:
                            1, // set the width factor to 0.8 to take 80% of the container's width
                        heightFactor:
                            1, // set the height factor to 0.8 to take 80% of the container's height
                        child: Lottie.asset(
                          'animation/welcome3.json',
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Users can add information about hosptals near them.',
                          style: GoogleFonts.monda(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      '3/3',
                      style: TextStyle(fontSize: 19, fontFamily: 'brandon_N'),
                    ),
                    const SizedBox(height: 50)
                  ],
                ),
              )
            ],
          ),
          Positioned(
            bottom: 70,
            child: OutlinedButton(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                if (CurrentPage != 2) {
                  int nextPage = LiqController.currentPage + 1;
                  LiqController.animateToPage(page: nextPage);
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginSignUpScreen()));
                }
              },
              style: ElevatedButton.styleFrom(
                  shadowColor: Colors.black26,
                  side: const BorderSide(color: Colors.black26),
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(10)),
            ),
          ),
          Positioned(
            top: 40,
            right: 10,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoginSignUpScreen()));
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                    color: Color.fromARGB(255, 16, 16, 16),
                    fontSize: 20,
                    fontFamily: 'brandon_N'),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            child: AnimatedSmoothIndicator(
              activeIndex: LiqController.currentPage,
              count: 3,
              effect: const WormEffect(
                  activeDotColor: Color(0xFF272727), dotHeight: 5),
            ),
          )
        ],
      ),
    );
  }

  void onPageChangedCallback(int activePageIndex) {
    setState(() {
      CurrentPage = activePageIndex;
    });
  }
}
