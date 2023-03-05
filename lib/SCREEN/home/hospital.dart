import 'package:auto_size_text/auto_size_text.dart';
import 'package:carevista_ver05/Theme/theme.dart';
import 'package:carevista_ver05/main.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:carevista_ver05/SCREEN/addons/color.dart' as specialcolor;
import 'package:google_fonts/google_fonts.dart';
import 'package:humanitarian_icons/humanitarian_icons.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class HospitalPage extends StatefulWidget {
  const HospitalPage({super.key});

  @override
  State<HospitalPage> createState() => _HospitalPageState();
}

bool favkey = false;

class _HospitalPageState extends State<HospitalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        gradient: purpleGradient,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 44, left: 15, right: 15),
            width: MediaQuery.of(context).size.width,
            height: 450,
            child: Column(
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
                    IconButton(
                      tooltip: "Favorites",
                      icon: Icon(
                        favkey == false
                            ? Icons.favorite_border
                            : Icons.favorite,
                        size: 35,
                      ),
                      onPressed: () {
                        setState(() {
                          if (favkey == false) {
                            favkey = true;
                          } else {
                            favkey = false;
                          }
                        });
                      },
                      color: favkey == false
                          ? specialcolor.AppColor.secondPageIconColor
                          : Colors.red,
                    ),
                  ],
                ),
                const SizedBox(height: 0),
                Stack(
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset('Assets/images/profile-user.jpg')),
                    ),
                  ],
                ),
                Text(
                  'Hospital Name',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: specialcolor.AppColor.secondPageTitleColor),
                ),
                Text(
                  '24x7',
                  style: TextStyle(
                      fontSize: 15,
                      color: specialcolor.AppColor.secondPageTitleColor),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    HigTagWidget(
                        title: 'Location',
                        icon: Icons.location_on,
                        width: 200,
                        height: 30,
                        tooltapMess: 'Location',
                        firstColor: Color.fromARGB(255, 95, 44, 116),
                        secondColor: Color.fromARGB(255, 156, 94, 145))
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    HigTagWidget(
                      firstColor: Color.fromARGB(255, 187, 255, 0),
                      secondColor: Color.fromARGB(255, 249, 32, 4),
                      tooltapMess: 'Established Year',
                      icon: LineAwesomeIcons.building,
                      title: "year",
                      height: 30,
                      width: 90,
                    ),
                    SizedBox(width: 10),
                    HigTagWidget(
                      firstColor: Color.fromARGB(255, 187, 255, 0),
                      secondColor: Color.fromARGB(255, 249, 32, 4),
                      tooltapMess: 'Highlight',
                      icon: Icons.star_border_purple500,
                      title: "hig",
                      height: 30,
                      width: 90,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HigTagWidget(
                      firstColor: specialcolor
                          .AppColor.secondPageContainerGradient1stColor,
                      secondColor: specialcolor
                          .AppColor.secondPageContainerGradient2ndColor,
                      tooltapMess: 'Ambulance',
                      icon: HumanitarianIcons.ambulance,
                      title: "amb",
                      height: 30,
                      width: 90,
                    ),
                    const SizedBox(width: 10),
                    HigTagWidget(
                        firstColor: specialcolor
                            .AppColor.secondPageContainerGradient1stColor,
                        secondColor: specialcolor
                            .AppColor.secondPageContainerGradient2ndColor,
                        tooltapMess: 'bed',
                        height: 30,
                        width: 90,
                        title: 'bed',
                        icon: Icons.bed_sharp),
                    const SizedBox(width: 10),
                    HigTagWidget(
                      firstColor: specialcolor
                          .AppColor.secondPageContainerGradient1stColor,
                      secondColor: specialcolor
                          .AppColor.secondPageContainerGradient2ndColor,
                      tooltapMess: 'Doctors',
                      icon: LineAwesomeIcons.stethoscope,
                      title: "doc",
                      height: 30,
                      width: 90,
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
            decoration: BoxDecoration(
                color: MyApp.themeNotifier.value == ThemeMode.light
                    ? Colors.white
                    : Theme.of(context).cardColor,
                borderRadius:
                    const BorderRadius.only(topRight: Radius.circular(70))),
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              foregroundColor: Colors.green,
                              backgroundColor: Colors.white,
                              shadowColor: Colors.black87,
                            ),
                            onPressed: () {},
                            child: Row(
                              children: [
                                const Icon(Icons.location_on),
                                const SizedBox(width: 5),
                                Text(
                                  'Get Location',
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )),
                        const SizedBox(width: 10),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green,
                              shadowColor: Colors.black87,
                            ),
                            onPressed: () {},
                            child: Row(
                              children: [
                                const Icon(Icons.phone),
                                const SizedBox(width: 5),
                                Text('Enquire Now',
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500))
                              ],
                            )),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const HeadingWidget(title: 'Overview'),
                    const SizedBox(height: 10),
                    const ContentWidget(
                        content:
                            "Tata Memorial Hospital, Mumbai, is one of the world's largest and oldest cancer centres. With over 75 years of exceptional experience and innovative cancer research, TMH Mumbai has grown in size and domination.Tata Memorial Hospital believes in giving patients evidence-based, individualised therapy targeted to cancer and the patient's particular physical, psychosocial, and emotional requirements. Tata Memorial Hospital, Mumbai, is a global leader in translational, epidemiologic, and clinical cancer research"),
                    const SizedBox(height: 15),
                    const HeadingWidget(title: 'Timings'),
                    const SizedBox(height: 10),
                    const ContentWidget(content: '24x7'),
                    const SizedBox(height: 15),
                    const HeadingWidget(title: 'Surroundings'),
                    const SizedBox(height: 10),
                    const ContentWidget(content: ''),
                    const SizedBox(height: 15),
                    const HeadingWidget(title: 'Specializations'),
                    const SizedBox(height: 10),
                    const ContentWidget(content: ''),
                    const SizedBox(height: 15),
                    const HeadingWidget(title: 'Amenities'),
                    const SizedBox(height: 10),
                    const ContentWidget(content: ''),
                    const SizedBox(height: 15),
                    const HeadingWidget(title: 'Doctors'),
                    const SizedBox(height: 10),
                    const ContentWidget(content: ''),
                    const SizedBox(height: 15),
                    const HeadingWidget(title: 'Nearby Hospitals'),
                    const SizedBox(height: 10),
                    const ContentWidget(content: ''),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    ));
  }
}

class ContentWidget extends StatelessWidget {
  const ContentWidget({
    Key? key,
    required this.content,
  }) : super(key: key);
  final String content;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.only(left: 15, right: 10),
            child: Text(
              content,
              style: GoogleFonts.poly(
                  color: MyApp.themeNotifier.value == ThemeMode.light
                      ? Colors.black54
                      : Colors.white60,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}

class HeadingWidget extends StatelessWidget {
  const HeadingWidget({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style:
              GoogleFonts.montserrat(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class HigTagWidget extends StatelessWidget {
  const HigTagWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.width,
    required this.height,
    required this.tooltapMess,
    required this.firstColor,
    required this.secondColor,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final double width;
  final double height;
  final Color firstColor;
  final Color secondColor;
  final String tooltapMess;
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltapMess,
      verticalOffset: 20,
      preferBelow: false,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                firstColor,
                secondColor,
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
      ),
    );
  }
}
