import 'package:carevista_ver05/SCREEN/addons/secondfit.dart';
import 'package:carevista_ver05/main.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'color.dart' as specialcolor;

class FitnessScreen extends StatefulWidget {
  const FitnessScreen({super.key});

  @override
  State<FitnessScreen> createState() => _FitnessScreenState();
}

int selsctedIconIndex = 2;

class _FitnessScreenState extends State<FitnessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Training',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Expanded(child: Container()),
                  Icon(Icons.arrow_back_ios_rounded,
                      color: MyApp.themeNotifier.value == ThemeMode.light
                          ? specialcolor.AppColor.homePageIcons
                          : Colors.white,
                      size: 17),
                  const SizedBox(width: 5),
                  Icon(Icons.calendar_today_outlined,
                      color: MyApp.themeNotifier.value == ThemeMode.light
                          ? specialcolor.AppColor.homePageIcons
                          : Colors.white,
                      size: 17),
                  const SizedBox(width: 10),
                  Icon(Icons.arrow_forward_ios_rounded,
                      color: MyApp.themeNotifier.value == ThemeMode.light
                          ? specialcolor.AppColor.homePageIcons
                          : Colors.white,
                      size: 17),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  const Text(
                    'Your program',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  Expanded(child: Container()),
                  Text(
                    'Details',
                    style: TextStyle(
                        fontSize: 17,
                        color: specialcolor.AppColor.homePageDetail),
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    Icons.arrow_forward,
                    size: 17,
                    color: MyApp.themeNotifier.value == ThemeMode.light
                        ? specialcolor.AppColor.homePageIcons
                        : Colors.white,
                  )
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 220,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      specialcolor.AppColor.gradientFirst.withOpacity(0.9),
                      specialcolor.AppColor.gradientSecond.withOpacity(0.9)
                    ], begin: Alignment.bottomLeft, end: Alignment.centerRight),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(89)),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(5, 10),
                        blurRadius: 28,
                        color: MyApp.themeNotifier.value == ThemeMode.light
                            ? specialcolor.AppColor.gradientSecond
                                .withOpacity(0.5)
                            : Colors.black87,
                      )
                    ]),
                child: Container(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Next Workout',
                          style: TextStyle(
                              fontSize: 16,
                              color: specialcolor
                                  .AppColor.homePageContainerTextSmall),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Legs Toning',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: specialcolor
                                  .AppColor.homePageContainerTextSmall),
                        ),
                        Text(
                          'and Chest Workout',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: specialcolor
                                  .AppColor.homePageContainerTextSmall),
                        ),
                        const SizedBox(height: 26),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.timer_outlined,
                                    size: 21,
                                    color: specialcolor
                                        .AppColor.homePageContainerTextSmall),
                                const SizedBox(width: 4),
                                Text(
                                  '68 min',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: specialcolor
                                          .AppColor.homePageContainerTextSmall),
                                ),
                              ],
                            ),
                            Expanded(child: Container()),
                            Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            specialcolor.AppColor.gradientFirst,
                                        blurRadius: 10,
                                        offset: const Offset(4, 6))
                                  ]),
                              child: IconButton(
                                icon: const Icon(Icons.play_circle_fill),
                                onPressed: () {
                                  nextScreen(context, const FitSecond());
                                },
                                iconSize: 50,
                                color: specialcolor
                                    .AppColor.homePageContainerTextSmall,
                              ),
                            )
                          ],
                        )
                      ]),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: Stack(children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 128,
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(-1, 10),
                              blurRadius: 28,
                              color:
                                  MyApp.themeNotifier.value == ThemeMode.light
                                      ? specialcolor.AppColor.gradientSecond
                                          .withOpacity(0.5)
                                      : Colors.black87,
                            )
                          ]),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('Assets/images/Running wild-rafiki.png'),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'You are doing greate',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color:
                                        specialcolor.AppColor.homePageDetail),
                              ),
                              const SizedBox(height: 10),
                              RichText(
                                  text: TextSpan(
                                      text: 'keep it up\n',
                                      style: TextStyle(
                                          color: specialcolor
                                              .AppColor.homePagePlanColor,
                                          fontSize: 17),
                                      children: const [
                                    TextSpan(text: 'stick to your plan')
                                  ]))
                            ],
                          ),
                        ],
                      )),
                ]),
              ),
              Row(
                children: const [
                  Text('Area of focus',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ))
                ],
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (_, i) {
                        return Column(
                          children: [
                            Row(
                              children: const [
                                AreaFocusWidget(
                                  image: 'Assets/images/Stretch-pana.png',
                                  title: 'Leg',
                                ),
                                SizedBox(width: 20),
                                AreaFocusWidget(
                                    title: 'Cheste',
                                    image: 'Assets/images/Coach-pana.png')
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: const [
                                AreaFocusWidget(
                                  image: 'Assets/images/Weights-pana.png',
                                  title: 'Hand',
                                  scale: 18,
                                ),
                                SizedBox(width: 20),
                                AreaFocusWidget(
                                    title: 'Chest',
                                    image:
                                        'Assets/images/Personal Trainer-pana.png')
                              ],
                            ),
                          ],
                        );
                      }))
            ],
          )),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor:
            Colors.white.withOpacity(0), //Theme.of(context).cardColor,
        index: selsctedIconIndex,
        buttonBackgroundColor: const Color(0XFF407BFF),
        height: 60.0,
        color: Theme.of(context).canvasColor,
        onTap: (index) {
          setState(() {
            selsctedIconIndex = index;
          });
        },
        animationDuration: const Duration(
          milliseconds: 200,
        ),
        items: <Widget>[
          Icon(
            Icons.play_arrow_outlined,
            size: 30,
            color: selsctedIconIndex == 0
                ? Colors.white
                : MyApp.themeNotifier.value == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
          ),
          Icon(
            Icons.search,
            size: 30,
            color: selsctedIconIndex == 1
                ? Colors.white
                : MyApp.themeNotifier.value == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
          ),
          Icon(
            Icons.home_outlined,
            size: 30,
            color: selsctedIconIndex == 2
                ? Colors.white
                : MyApp.themeNotifier.value == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
          ),
          Icon(
            Icons.favorite_border_outlined,
            size: 30,
            color: selsctedIconIndex == 3
                ? Colors.white
                : MyApp.themeNotifier.value == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
          ),
          Icon(
            Icons.person_outline,
            size: 30,
            color: selsctedIconIndex == 4
                ? Colors.white
                : MyApp.themeNotifier.value == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
          ),
        ],
      ),
    );
  }
}

class AreaFocusWidget extends StatelessWidget {
  const AreaFocusWidget({
    Key? key,
    required this.title,
    required this.image,
    this.scale = 1,
  }) : super(key: key);
  final String title;
  final String image;
  final double scale;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      width: 150,
      height: 160,
      decoration: BoxDecoration(
          color: MyApp.themeNotifier.value == ThemeMode.light
              ? Colors.white
              : Colors.black87,
          boxShadow: [
            BoxShadow(
                blurRadius: 3,
                offset: const Offset(5, 5),
                color: specialcolor.AppColor.gradientSecond.withOpacity(0.1)),
            BoxShadow(
                blurRadius: 3,
                offset: const Offset(-5, -5),
                color: specialcolor.AppColor.gradientSecond.withOpacity(0.1))
          ],
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage(image),
            scale: scale,
          )),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: specialcolor.AppColor.homePageDetail),
        ),
      ),
    );
  }
}
