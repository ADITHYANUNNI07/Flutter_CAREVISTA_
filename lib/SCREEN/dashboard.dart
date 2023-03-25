import 'package:carevista_ver05/Helper/helper_function.dart';
import 'package:carevista_ver05/SCREEN/addons/fitness.dart';
import 'package:carevista_ver05/SCREEN/addons/patientrecord.dart';
import 'package:carevista_ver05/SCREEN/home/favorites.dart';
import 'package:carevista_ver05/SCREEN/home/hospital.dart';
import 'package:carevista_ver05/SCREEN/login.dart';
import 'package:carevista_ver05/SCREEN/login_signup.dart';
import 'package:carevista_ver05/SCREEN/profile.dart';
import 'package:carevista_ver05/Service/auth_service.dart';
import 'package:carevista_ver05/Theme/theme.dart';
import 'package:carevista_ver05/admin/addDoctor.dart';
import 'package:carevista_ver05/admin/addHospital.dart';
import 'package:carevista_ver05/main.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:humanitarian_icons/humanitarian_icons.dart';
import 'addons/color.dart' as specialcolor;
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class Dashboard extends StatefulWidget {
  Dashboard({
    super.key,
  });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String userName = "";
  String email = "";
  String uid = "";
  String adminKey = "";
  bool adKey = false;
  String phoneNo = "";
  final scaffoldKey = GlobalKey<ScaffoldState>();
  AuthService authService = AuthService();
  int selsctedIconIndex = 2;
  bool saveIcon = false;
  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    gettingUserData();
  }

  gettingUserData() async {
    await HelperFunction.getUserNameFromSF().then((value) {
      setState(() {
        userName = value!;
      });
    });
    await HelperFunction.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunction.getUserPhoneFromSF().then((value) {
      setState(
        () {
          phoneNo = value!;
        },
      );
    });
    await HelperFunction.getUserAdkeyFromSF().then((value) {
      setState(() {
        adminKey = value!;
      });
      if (adminKey == 'false') {
        adKey = false;
      } else {
        adKey = true;
      }
    });
    await HelperFunction.getUserUIDFromSF().then((value) {
      setState(() {
        uid = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //variables

    final txttheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Container(
      color: const Color(0xFF04FBC3),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
            elevation: 0,
            title: Text.rich(
              TextSpan(
                text: "CARE ",
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'brandon_H',
                    color: Theme.of(context).primaryColorLight),
                children: [
                  TextSpan(
                    text: 'VISTA',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  )
                ],
              ),
            ),
            centerTitle: true,
            actions: [
              Container(
                  margin: const EdgeInsets.only(right: 1),
                  child: IconButton(
                      icon: Icon(MyApp.themeNotifier.value == ThemeMode.light
                          ? LineAwesomeIcons.moon
                          : LineAwesomeIcons.sun),
                      onPressed: () {
                        MyApp.themeNotifier.value =
                            MyApp.themeNotifier.value == ThemeMode.light
                                ? ThemeMode.dark
                                : ThemeMode.light;
                      })),
              Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                  ))
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 30),
              children: <Widget>[
                Icon(
                  Icons.account_circle,
                  size: 150,
                  color: Colors.grey.shade500,
                ),
                const SizedBox(height: 15),
                Text(
                  userName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontFamily: 'brandon_H',
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  email,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 25),
                const Divider(height: 2),
                MenuWidget(
                    title: "Profile",
                    icon: Icons.person,
                    onPress: () {
                      nextScreen(
                          context,
                          ProfilePage(
                              email: email,
                              userName: userName,
                              phoneNo: phoneNo));
                    }),
                MenuWidget(
                    title: "Favorites",
                    icon: Icons.star_border_rounded,
                    onPress: () {
                      nextScreen(context, Favorites());
                    }),
                adKey
                    ? MenuWidget(
                        title: "Add Doctor Details",
                        icon: LineAwesomeIcons.doctor,
                        onPress: () {
                          nextScreen(context, const AddDoctor());
                        },
                      )
                    : const SizedBox(),
                adKey
                    ? MenuWidget(
                        title: "Add Hospital",
                        icon: LineAwesomeIcons.hospital_symbol,
                        onPress: () {
                          nextScreen(
                              context,
                              AddHospital(
                                  username: userName, userphoneno: phoneNo));
                        },
                      )
                    : const SizedBox(),
                const Divider(),
                ListTile(
                  onTap: () {
                    nextScreen(context, const FitnessScreen());
                  },
                  leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: const Color(0xFF00008F).withOpacity(0.2),
                      ),
                      child: const Icon(LineAwesomeIcons
                          .heartbeat) //Image.asset('Assets/images/running.png'),
                      ),
                  title: Text(
                    'Fitness',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  trailing: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey.withOpacity(0.1)),
                    child: const Icon(
                      LineAwesomeIcons.angle_right,
                      size: 18,
                    ),
                  ),
                ),
                const Divider(),
                MenuWidget(
                  title: "Logout",
                  endIcon: false,
                  icon: LineAwesomeIcons.alternate_sign_out,
                  textColor: Colors.red,
                  onPress: () async {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Logout"),
                            content:
                                const Text("Are you sure you want to logout?"),
                            actions: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  authService.signOut().whenComplete(
                                        () => {
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                            // the new route
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  LoginScreen(),
                                            ),

                                            // this function should return true when we're done removing routes
                                            // but because we want to remove all other screens, we make it
                                            // always return false
                                            (Route route) => false,
                                          )
                                        },
                                      );
                                },
                                icon: const Icon(
                                  Icons.done,
                                  color: Colors.green,
                                ),
                              )
                            ],
                          );
                        });
                  },
                )
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Say hello to Kerala's top Hospital.",
                    style: txttheme.headline5,
                  ),
                  const Text(
                    "Find suitable doctors and hospitals",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  //const SizedBox(height: 20),
                  SizedBox(
                    height: 60,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        DiseaseHospitalListScroll(
                            txttheme: txttheme,
                            title: "Cancer",
                            hospitalno: "10 Hospital",
                            imageicon: 'Assets/images/cancer.png',
                            onPress: () {}),
                        DiseaseHospitalListScroll(
                          txttheme: txttheme,
                          title: 'Heart',
                          hospitalno: '10 Hospital',
                          imageicon: 'Assets/images/heart128.png',
                          onPress: () {},
                        ),
                        DiseaseHospitalListScroll(
                          txttheme: txttheme,
                          title: 'Eye',
                          hospitalno: '10 Hospital',
                          imageicon: 'Assets/images/eye.png',
                          onPress: () {},
                        ),
                        DiseaseHospitalListScroll(
                          txttheme: txttheme,
                          title: 'Dental',
                          hospitalno: '10 Hospital',
                          imageicon: 'Assets/images/dental.png',
                          onPress: () {},
                        ),
                        DiseaseHospitalListScroll(
                          txttheme: txttheme,
                          title: 'Lungs',
                          hospitalno: '10 Hospital',
                          imageicon: 'Assets/images/lungs.png',
                          onPress: () {},
                        ),
                        DiseaseHospitalListScroll(
                          txttheme: txttheme,
                          title: 'Knee-replacement',
                          hospitalno: '10 Hospital',
                          imageicon: 'Assets/images/knee.png',
                          onPress: () {},
                        ),
                        DiseaseHospitalListScroll(
                            txttheme: txttheme,
                            title: 'Kidney',
                            hospitalno: '10 Hospital',
                            imageicon: 'Assets/images/kidney.png',
                            onPress: () {}),
                        DiseaseHospitalListScroll(
                            txttheme: txttheme,
                            title: 'Spine',
                            hospitalno: '10 Hospital',
                            imageicon: 'Assets/images/spine.png',
                            onPress: () {}),
                        DiseaseHospitalListScroll(
                            txttheme: txttheme,
                            title: 'Skin',
                            hospitalno: '10 Hospital',
                            imageicon: 'Assets/images/skin.png',
                            onPress: () {}),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                      height: 300,
                      child: SizedBox(
                        width: 340,
                        height: 300,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: MyApp.themeNotifier.value ==
                                            ThemeMode.light
                                        ? Colors.white
                                        : Colors.black,
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: const Offset(5, 10),
                                        blurRadius: 28,
                                        color: MyApp.themeNotifier.value ==
                                                ThemeMode.light
                                            ? specialcolor
                                                .AppColor.gradientSecond
                                                .withOpacity(0.5)
                                            : Colors.black87,
                                      )
                                    ]),
                                padding: const EdgeInsets.only(
                                    top: 38, left: 10, right: 10, bottom: 38),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        LargeContainerOptionsWidget(
                                          icon: LineAwesomeIcons.first_aid,
                                          title: 'First AID Treatement',
                                          onPress: () {},
                                        ),
                                        LargeContainerOptionsWidget(
                                          icon: Icons.fitness_center_outlined,
                                          title: 'Fitness',
                                          onPress: () {
                                            nextScreen(
                                                context, FitnessScreen());
                                          },
                                        ),
                                        LargeContainerOptionsWidget(
                                          icon: Icons.alarm_add,
                                          title: 'Medicine Reminder',
                                          onPress: () {},
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        LargeContainerOptionsWidget(
                                          icon: Icons.library_books_outlined,
                                          title: 'Patient Record',
                                          onPress: () {
                                            nextScreen(
                                                context, PatientRecord());
                                          },
                                        ),
                                        LargeContainerOptionsWidget(
                                          icon: LineAwesomeIcons.heartbeat,
                                          title: 'Disease Complication',
                                          onPress: () {},
                                        ),
                                        LargeContainerOptionsWidget(
                                          icon: Icons.favorite,
                                          title: 'Favorites',
                                          onPress: () {},
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 20),
                  Text(
                    'Top Hospitals',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 240,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('hospitals')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        List<DocumentSnapshot> hospitals = snapshot.data!.docs;
                        List<DocumentSnapshot> thiruvananthapuramHospitals =
                            hospitals
                                .where((hospital) =>
                                    hospital['district'] == 'Trivandrum')
                                .toList();
                        List<DocumentSnapshot> kollamHospitals = hospitals
                            .where(
                                (hospital) => hospital['district'] == 'Kollam')
                            .toList();
                        List<DocumentSnapshot> pathanamthittaHospitals =
                            hospitals
                                .where((hospital) =>
                                    hospital['district'] == 'Pathanamthitta')
                                .toList();
                        List<DocumentSnapshot> alaHospitals = hospitals
                            .where((hospital) =>
                                hospital['district'] == 'Alappuzha')
                            .toList();
                        List<DocumentSnapshot> KottayamHospitals = hospitals
                            .where((hospital) =>
                                hospital['district'] == 'Kottayam')
                            .toList();
                        List<DocumentSnapshot> IdukkiHospitals = hospitals
                            .where(
                                (hospital) => hospital['district'] == 'Idukki')
                            .toList();
                        List<DocumentSnapshot> ErnakulamHospitals = hospitals
                            .where((hospital) =>
                                hospital['district'] == 'Ernakulam')
                            .toList();
                        List<DocumentSnapshot> ThrissurHospitals = hospitals
                            .where((hospital) =>
                                hospital['district'] == 'Thrissur')
                            .toList();
                        List<DocumentSnapshot> PalakkadHospitals = hospitals
                            .where((hospital) =>
                                hospital['district'] == 'Palakkad')
                            .toList();
                        List<DocumentSnapshot> MalappuramHospitals = hospitals
                            .where((hospital) =>
                                hospital['district'] == 'Malappuram')
                            .toList();
                        List<DocumentSnapshot> KozhikodeHospitals = hospitals
                            .where((hospital) =>
                                hospital['district'] == 'Kozhikode')
                            .toList();
                        List<DocumentSnapshot> WayanadHospitals = hospitals
                            .where(
                                (hospital) => hospital['district'] == 'Wayanad')
                            .toList();
                        List<DocumentSnapshot> KannurHospitals = hospitals
                            .where(
                                (hospital) => hospital['district'] == 'Kannur')
                            .toList();
                        List<DocumentSnapshot> KasaragodHospitals = hospitals
                            .where((hospital) =>
                                hospital['district'] == 'Kasaragod')
                            .toList();
                        List<DocumentSnapshot> sortedHospitals = [
                          ...thiruvananthapuramHospitals,
                          ...kollamHospitals,
                          ...pathanamthittaHospitals,
                          ...alaHospitals,
                          ...KottayamHospitals,
                          ...IdukkiHospitals,
                          ...ErnakulamHospitals,
                          ...ThrissurHospitals,
                          ...PalakkadHospitals,
                          ...MalappuramHospitals,
                          ...KozhikodeHospitals,
                          ...WayanadHospitals,
                          ...KannurHospitals,
                          ...KasaragodHospitals
                        ];
                        return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: sortedHospitals.length,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot data = sortedHospitals[index];
                            return Row(
                              children: [
                                TopHospitalListScroll(
                                  hospitalName: data['hospitalName'],
                                  district: data['district'],
                                  imageSrc: data['Logo'],
                                  onPressIcon: () {
                                    setState(() {
                                      if (saveIcon == true) {
                                        saveIcon = false;
                                      } else {
                                        saveIcon = true;
                                      }
                                    });
                                  },
                                  Adkey: adKey,
                                  uploaderName: data['uploaderName'],
                                  sIcon: saveIcon,
                                  txttheme: txttheme,
                                  onPress: () {
                                    nextScreen(
                                        context,
                                        HospitalPage(
                                          hospitalName: data['hospitalName'],
                                          district: data['district'],
                                          logo: data['Logo'],
                                          address: data['address'],
                                          affiliatted:
                                              data['affiliateduniversity'],
                                          ambulanceNo: data['ambulanceNo'],
                                          bedNo: data['bedNo'],
                                          doctorsNo: data['doctorsNo'],
                                          emergencydpt:
                                              data['emergencydepartment'],
                                          sitlink: data['sitLink'],
                                          govtprivate: data['GovtorPrivate'],
                                          highlight: data['highlight'],
                                          hospital1: data['hospital1'],
                                          hospital2: data['hospital2'],
                                          hospital3: data['hospital3'],
                                          image1url: data['image1'],
                                          image2url: data['image2'],
                                          image3url: data['image3'],
                                          image4url: data['image4'],
                                          image5url: data['image5'],
                                          length: data['uploadDocternumber'],
                                          location: data['location'],
                                          overview: data['overview'],
                                          phoneno: data['phoneno'],
                                          sdistance1:
                                              data['surroundingdistance1'],
                                          sdistance2:
                                              data['surroundingdistance2'],
                                          service: data['services'],
                                          splace1: data['surroundingplace1'],
                                          splace2: data['surroundingplace2'],
                                          stime1: data['surroundingtime1'],
                                          stime2: data['surroundingtime2'],
                                          time: data['time'],
                                          type: data['type'],
                                          year: data['establishedYear'],
                                          doctorSpeciality: List.from(
                                              data['doctorName&Specialist']),
                                          doctordetails: _buildDoctorList(data),
                                        ));
                                  },
                                ),
                                const SizedBox(width: 20),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.transparent,
            index: selsctedIconIndex,
            buttonBackgroundColor: const Color(0XFF407BFF),
            color: Theme.of(context).canvasColor,
            height: 60.0,
            onTap: (index) {
              setState(() {
                selsctedIconIndex = index;
              });
            },
            animationDuration: const Duration(
              milliseconds: 200,
            ),
            items: <Widget>[
              IconButton(
                onPressed: () {
                  nextScreen(context, PatientRecord());
                },
                icon: const Icon(Icons.library_books_outlined, size: 30),
                color: selsctedIconIndex == 0
                    ? Colors.white
                    : MyApp.themeNotifier.value == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search, size: 30),
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
              IconButton(
                onPressed: () {
                  nextScreen(context, Favorites());
                },
                icon: const Icon(Icons.favorite_border_outlined, size: 30),
                color: selsctedIconIndex == 3
                    ? Colors.white
                    : MyApp.themeNotifier.value == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
              ),
              IconButton(
                onPressed: () {
                  nextScreen(
                      context,
                      ProfilePage(
                          phoneNo: phoneNo, email: email, userName: userName));
                },
                icon: const Icon(Icons.person_outline, size: 30),
                color: selsctedIconIndex == 4
                    ? Colors.white
                    : MyApp.themeNotifier.value == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
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

class TopHospitalListScroll extends StatefulWidget {
  const TopHospitalListScroll({
    Key? key,
    required this.txttheme,
    required this.onPress,
    required this.onPressIcon,
    required this.sIcon,
    required this.hospitalName,
    required this.district,
    required this.imageSrc,
    required this.uploaderName,
    required this.Adkey,
  }) : super(key: key);
  final VoidCallback onPress;
  final VoidCallback onPressIcon;
  final bool sIcon;
  final bool Adkey;
  final TextTheme txttheme;
  final String hospitalName;
  final String district;
  final String uploaderName;
  final String imageSrc;
  @override
  State<TopHospitalListScroll> createState() => _TopHospitalListScrollState();
}

class _TopHospitalListScrollState extends State<TopHospitalListScroll> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 325,
      height: 229,
      child: InkWell(
        onTap: widget.onPress,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              gradient: purpleGradient,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(5, 10),
                  blurRadius: 28,
                  color: MyApp.themeNotifier.value == ThemeMode.light
                      ? specialcolor.AppColor.gradientSecond.withOpacity(0.5)
                      : Colors.black87,
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Flexible(child: Container()),
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: CircleAvatar(
                      backgroundImage: Image.network(widget.imageSrc).image,
                      radius: 50,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              Text(
                widget.hospitalName,
                style: GoogleFonts.montserrat(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: specialcolor.AppColor.homePageContainerTextSmall),
                textAlign: TextAlign.center,
              ),
              Text(widget.district,
                  style: TextStyle(
                      fontSize: 16,
                      color: specialcolor.AppColor.homePageContainerTextSmall)),
              const SizedBox(height: 5),
              widget.Adkey == true
                  ? Text(widget.uploaderName,
                      style: TextStyle(
                          fontSize: 10,
                          color:
                              specialcolor.AppColor.homePageContainerTextSmall))
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class DiseaseHospitalListScroll extends StatelessWidget {
  const DiseaseHospitalListScroll({
    Key? key,
    required this.txttheme,
    required this.title,
    required this.hospitalno,
    required this.imageicon,
    required this.onPress,
  }) : super(key: key);

  final TextTheme txttheme;
  final VoidCallback onPress;
  final String title;
  final String hospitalno;
  final String imageicon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      height: 45,
      child: Row(
        children: [
          GestureDetector(
            onTap: onPress,
            child: Container(
              padding: const EdgeInsets.all(4),
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    specialcolor.AppColor.gradientFirst.withOpacity(0.9),
                    specialcolor.AppColor.gradientSecond.withOpacity(0.9)
                  ], begin: Alignment.bottomLeft, end: Alignment.centerRight),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(1),
                      bottomRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(1))),
              child: Image.asset(imageicon),
            ),
          ),
          const SizedBox(width: 5),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    style: txttheme.headline6, overflow: TextOverflow.ellipsis),
                Text(hospitalno,
                    style: txttheme.bodyText2, overflow: TextOverflow.ellipsis),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class LargeContainerOptionsWidget extends StatelessWidget {
  const LargeContainerOptionsWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 100,
        width: 100,
        padding: const EdgeInsets.only(top: 10, left: 10),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: MyApp.themeNotifier.value == ThemeMode.light
                    ? const Color(0xFF00008F).withOpacity(0.2)
                    : const Color(0xFFFB4C5B).withOpacity(0.7),
              ),
              child: Icon(icon),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color(0xFF00008F).withOpacity(0.2),
        ),
        child: Icon(icon),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1?.apply(color: textColor),
      ),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey.withOpacity(0.1)),
              child: const Icon(
                LineAwesomeIcons.angle_right,
                size: 18,
              ),
            )
          : null,
    );
  }
}
