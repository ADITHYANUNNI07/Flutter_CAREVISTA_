import 'package:carevista_ver05/widget/widget.dart';
import 'package:flutter/material.dart';
import 'color.dart' as specialcolor;

class FitSecond extends StatefulWidget {
  const FitSecond({super.key});

  @override
  State<FitSecond> createState() => _FitSecondState();
}

class _FitSecondState extends State<FitSecond> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          specialcolor.AppColor.gradientFirst.withOpacity(0.8),
          specialcolor.AppColor.gradientSecond.withOpacity(0.9)
        ], begin: const FractionalOffset(0.0, 0.4), end: Alignment.topRight),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 44, left: 15, right: 15),
            width: MediaQuery.of(context).size.width,
            height: 280,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        nextScreenPop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 27,
                        color: specialcolor.AppColor.secondPageIconColor,
                      ),
                    ),
                    Expanded(child: Container()),
                    Icon(
                      Icons.info_outline,
                      size: 27,
                      color: specialcolor.AppColor.secondPageIconColor,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Text(
                  'Legs Toning',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: specialcolor.AppColor.secondPageTitleColor),
                ),
                Text(
                  'and Cheste Workout',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: specialcolor.AppColor.secondPageTitleColor),
                ),
                const SizedBox(height: 26),
                Row(
                  children: const [
                    TagWidget(
                      icon: Icons.timer_outlined,
                      title: "68 min",
                      height: 30,
                      width: 100,
                    ),
                    SizedBox(width: 10),
                    TagWidget(
                        height: 30,
                        width: 220,
                        title: 'Resistent band, kettebell',
                        icon: Icons.handyman_outlined)
                  ],
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(70))),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Circuit 1 : Legs Toning",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Expanded(child: Container()),
                    Row(
                      children: [
                        Icon(
                          Icons.loop,
                          size: 24,
                          color: specialcolor.AppColor.loopColor,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '3 sets',
                          style: TextStyle(
                              fontSize: 15,
                              color: specialcolor.AppColor.setsColor),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          )),
        ],
      ),
    ));
  }
}

class TagWidget extends StatelessWidget {
  const TagWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.width,
    required this.height,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
              specialcolor.AppColor.secondPageContainerGradient1stColor,
              specialcolor.AppColor.secondPageContainerGradient2ndColor
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 23,
            color: specialcolor.AppColor.secondPageIconColor,
          ),
          const SizedBox(width: 5),
          Text(
            title,
            style: TextStyle(
                fontSize: 15,
                color: specialcolor.AppColor.homePageContainerTextSmall),
          ),
        ],
      ),
    );
  }
}
