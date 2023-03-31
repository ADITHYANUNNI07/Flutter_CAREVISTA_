import 'package:auto_size_text/auto_size_text.dart';
import 'package:carevista_ver05/SCREEN/profile.dart';
import 'package:carevista_ver05/Theme/theme.dart';
import 'package:carevista_ver05/main.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carevista_ver05/SCREEN/addons/color.dart' as specialcolor;
import 'package:google_fonts/google_fonts.dart';
import 'package:humanitarian_icons/humanitarian_icons.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HospitalPage extends StatefulWidget {
  HospitalPage({
    required this.hospitalName,
    required this.district,
    required this.logo,
    required this.location,
    required this.time,
    required this.address,
    required this.highlight,
    required this.phoneno,
    required this.year,
    required this.doctorsNo,
    required this.bedNo,
    required this.ambulanceNo,
    required this.sitlink,
    required this.govtprivate,
    required this.type,
    required this.affiliatted,
    required this.emergencydpt,
    required this.splace1,
    required this.sdistance1,
    required this.stime1,
    required this.splace2,
    required this.sdistance2,
    required this.stime2,
    required this.length,
    //required this.doctorname,
    //required this.specialist,
    required this.hospital1,
    required this.hospital2,
    required this.hospital3,
    required this.overview,
    required this.service,
    required this.image1url,
    required this.image2url,
    required this.image3url,
    required this.image4url,
    required this.image5url,
    required this.doctorSpeciality,
    required this.doctordetails,
    super.key,
  });
  String hospitalName;
  String district;
  String logo;
  String location;
  String time;
  String address;
  String highlight;
  String phoneno;
  String year;
  String doctorsNo;
  String bedNo;
  String ambulanceNo;
  String sitlink;
  String govtprivate;
  String type;
  String affiliatted;
  String emergencydpt;
  String splace1;
  String sdistance1;
  String stime1;
  String splace2;
  String sdistance2;
  String stime2;
  int length;
  //List specialist;
  String hospital1;
  String hospital2;
  String hospital3;
  String overview;
  String service;
  String image1url;
  String image2url;
  String image3url;
  String image4url;
  String image5url;
  List doctorSpeciality;
  List<Widget> doctordetails;
  @override
  State<HospitalPage> createState() => _HospitalPageState();
}

bool favkey = false;

class Hospital {
  final List<Map<String, dynamic>> doctorNameSpecialist;

  Hospital({required this.doctorNameSpecialist});

  factory Hospital.fromFirestore(DocumentSnapshot doc) {
    return Hospital(
      doctorNameSpecialist:
          List<Map<String, dynamic>>.from(doc['doctorNameSpecialist']),
    );
  }
}

class _HospitalPageState extends State<HospitalPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        gradient: purpleGradient,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 21, left: 10, right: 10),
            width: MediaQuery.of(context).size.width,
            height: 415,
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
                        size: 30,
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
                Stack(
                  children: [
                    SizedBox(
                      width: 130,
                      height: 130,
                      child: CircleAvatar(
                        backgroundImage: Image.network(
                          widget.logo,
                        ).image,
                        radius: 50,
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.hospitalName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: specialcolor.AppColor.secondPageTitleColor),
                ),
                Text(
                  widget.time,
                  style: TextStyle(
                      fontSize: 15,
                      color: specialcolor.AppColor.secondPageTitleColor),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HigTagWidget(
                      firstColor: const Color.fromARGB(255, 105, 112, 85),
                      secondColor: const Color.fromARGB(255, 202, 128, 118),
                      tooltapMess: '',
                      icon: Icons.star_border_purple500,
                      title: widget.type,
                      height: 30,
                      width: 200 + 39,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HigTagWidget(
                        title: widget.location,
                        icon: Icons.location_on,
                        width: 250 + 20,
                        height: 30,
                        tooltapMess: 'Location',
                        firstColor: const Color.fromARGB(255, 95, 44, 116),
                        secondColor: const Color.fromARGB(255, 156, 94, 145))
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HigTagWidget(
                      firstColor: const Color.fromARGB(255, 187, 255, 0),
                      secondColor: const Color.fromARGB(255, 249, 32, 4),
                      tooltapMess: 'Established Year',
                      icon: LineAwesomeIcons.building,
                      title: widget.year,
                      height: 30,
                      width: 90,
                    ),
                    const SizedBox(width: 10),
                    HigTagWidget(
                      firstColor: const Color.fromARGB(255, 187, 255, 0),
                      secondColor: const Color.fromARGB(255, 249, 32, 4),
                      tooltapMess: '',
                      icon: Icons.star_border_purple500,
                      title: widget.govtprivate,
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
                      title: widget.ambulanceNo,
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
                        title: widget.bedNo,
                        icon: Icons.bed_sharp),
                    const SizedBox(width: 10),
                    HigTagWidget(
                      firstColor: specialcolor
                          .AppColor.secondPageContainerGradient1stColor,
                      secondColor: specialcolor
                          .AppColor.secondPageContainerGradient2ndColor,
                      tooltapMess: 'Doctors',
                      icon: LineAwesomeIcons.stethoscope,
                      title: widget.doctorsNo,
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
            padding: const EdgeInsets.only(left: 15, right: 15),
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
                            onPressed: () => MapsLauncher.launchQuery(
                                widget.hospitalName + '\n' + widget.district),

                            /*()async {
                              if (await canLaunchUrlString(widget.sitlink)) {
                                await launchUrlString(widget.sitlink);
                              } else {}
                            },*/
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
                            onPressed: () async {
                              Uri phoneno = Uri.parse('tel:' + widget.phoneno);
                              if (await launchUrl(phoneno)) {
                                launchUrl(phoneno);
                              } else {
                                //dailer is not opened
                              }
                            },
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
                    ContentWidget(content: widget.overview),
                    const SizedBox(height: 15),
                    const HeadingWidget(title: 'Services'),
                    const SizedBox(height: 10),
                    ContentWidget(content: widget.service),
                    const HeadingWidget(title: 'Timings'),
                    const SizedBox(height: 10),
                    ContentWidget(content: widget.time),
                    const SizedBox(height: 15),
                    const HeadingWidget(title: 'Surroundings'),
                    const SizedBox(height: 10),
                    ContentWidget(
                        content:
                            "${widget.splace1}\n     Distance :-${widget.sdistance1}\n     Time :- ${widget.stime1}\n${widget.splace2}\n     Distance :-${widget.sdistance2}\n     Time :- ${widget.stime2}"),
                    const SizedBox(height: 15),
                    const HeadingWidget(title: 'Additional Information'),
                    const SizedBox(height: 10),
                    ContentWidget(
                      // ignore: prefer_interpolation_to_compose_strings
                      content: "Address :-"
                              "  "
                              '\n' +
                          widget.address +
                          '\n' +
                          '\n' +
                          "Affiliated university :-" +
                          "  " +
                          '\n' +
                          widget.affiliatted +
                          '\n' +
                          '\n' +
                          "Emergency department :-" +
                          "  " +
                          widget.emergencydpt +
                          '\n' +
                          '\n' +
                          "Highlight :-" +
                          "  " +
                          '\n' +
                          widget.highlight,
                    ),
                    const SizedBox(height: 15),
                    const HeadingWidget(title: 'Doctors'),
                    const SizedBox(height: 10),
                    Column(
                      children: widget.doctordetails,
                    ),
                    //const SizedBox(height: 15),
                    TextButton(
                      onPressed: () async {
                        if (await canLaunchUrlString(widget.sitlink)) {
                          await launchUrlString(widget.sitlink);
                        } else {}
                      },
                      child: Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          // ignore: prefer_adjacent_string_concatenation
                          text: "More details visit" + " ",
                          style: Theme.of(context).textTheme.bodyText1,
                          children: [
                            TextSpan(
                              text: "${widget.hospitalName},${widget.district}",
                              style: const TextStyle(color: Colors.blue),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const HeadingWidget(title: 'Nearby Hospitals'),
                    const SizedBox(height: 10),
                    ContentWidget(
                        content:
                            "1. ${widget.hospital1}\n \n2. ${widget.hospital2}\n \n3. ${widget.hospital3}"),
                    const SizedBox(height: 15),
                    const HeadingWidget(title: 'Photos'),
                    SizedBox(
                        width: 350,
                        height: 250,
                        child: Image(
                          image: Image.network(
                            widget.image1url,
                          ).image,
                        )),
                    SizedBox(
                        width: 350,
                        height: 250,
                        child: Image(
                          image: Image.network(
                            widget.image2url,
                          ).image,
                        )),
                    SizedBox(
                        width: 350,
                        height: 250,
                        child: Image(
                          image: Image.network(
                            widget.image3url,
                          ).image,
                        )),
                    SizedBox(
                        width: 350,
                        height: 250,
                        child: Image(
                          image: Image.network(
                            widget.image4url,
                          ).image,
                        )),
                    SizedBox(
                        width: 350,
                        height: 250,
                        child: Image(
                          image: Image.network(
                            widget.image5url,
                          ).image,
                        )),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    ));
  }

  List<Widget> _buildDoctorList(DocumentSnapshot hospital) {
    List<Widget> doctorList = [];
    if (hospital['doctorName&Specialist'] != null) {
      List doctors = hospital['doctorName&Specialist'];
      for (var doctor in doctors) {
        doctorList.add(ListTile(
          title: Text(doctor['DoctorName']),
          subtitle: Text(doctor['Specialist']),
        ));
      }
    }
    return doctorList;
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
