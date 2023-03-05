import 'package:carevista_ver05/SCREEN/login_signup.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
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

                padding: const EdgeInsets.all(30.0),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'Assets/images/welcomeScrn1.png',
                      height: size.height * 0.5,
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

                padding: const EdgeInsets.all(30.0),
                color: Color.fromARGB(255, 211, 211, 234),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'Assets/images/welcomeScrn2.png',
                      height: size.height * 0.5,
                    ),
                    Column(
                      children: [
                        Text(
                          'Welcome to',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          'CARE VISTA',
                          style: Theme.of(context).textTheme.headline2,
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
                color: Color.fromARGB(255, 193, 223, 216),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'Assets/images/welcomeScrn3.png',
                      height: size.height * 0.5,
                    ),
                    Column(
                      children: [
                        Text(
                          'Welcome to',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          'CARE VISTA',
                          style: Theme.of(context).textTheme.headline2,
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
                int nextPage = LiqController.currentPage + 1;
                LiqController.animateToPage(page: nextPage);
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
                    builder: (context) => LoginSignUpScreen()));
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
