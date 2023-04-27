import 'dart:io';

import 'package:carevista_ver05/SCREEN/home/hospital.dart';
import 'package:carevista_ver05/Service/auth_service.dart';
import 'package:carevista_ver05/Service/database_service.dart';
import 'package:carevista_ver05/admin/userhospitalverification.dart';
import 'package:carevista_ver05/main.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:carevista_ver05/SCREEN/addons/color.dart' as specialcolor;
import 'package:url_launcher/url_launcher.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class UserHospitalApprove extends StatefulWidget {
  const UserHospitalApprove({super.key, required this.email});
  final String email;
  @override
  State<UserHospitalApprove> createState() => _UserHospitalApproveState();
}

TextEditingController _searchController = TextEditingController();
String _searchQuery = '';
AuthService authService = AuthService();
final fromKey = GlobalKey<FormState>();

bool _isLoding = false;
String password = '';
bool passVisible = false;

class _UserHospitalApproveState extends State<UserHospitalApprove> {
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController = TextEditingController();
    _searchQuery = '';

    bool _isLoding = false;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return _isLoding
        ? Container(
            height: 300, // set the height of the container to 300
            width: 300, // set the width of the container to 300
            color: MyApp.themeNotifier.value == ThemeMode.light
                ? Colors.white
                : Theme.of(context).canvasColor,
            child: FractionallySizedBox(
              widthFactor:
                  0.4, // set the width factor to 0.8 to take 80% of the container's width
              heightFactor:
                  0.4, // set the height factor to 0.8 to take 80% of the container's height
              child: Lottie.network(
                'https://assets5.lottiefiles.com/packages/lf20_Qkk8MTZ8T4.json',
              ),
            ),
          )
        : Container(
            color: const Color(0xFF04FBC3),
            child: SafeArea(
                child: Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                centerTitle: true,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(
                    LineAwesomeIcons.angle_double_left,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                  'Approve Hospital',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25, color: Theme.of(context).primaryColorDark),
                ),
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          labelText: 'Search',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: size.height,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Userhospitals')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                  child: Lottie.asset(
                                      'animation/96949-loading-animation.json',
                                      height: 100));
                            }
                            List<DocumentSnapshot> hospital =
                                snapshot.data!.docs;
                            List<DocumentSnapshot> verification = hospital
                                .where((data) => data['verification'] == 'true')
                                .toList();

                            List<DocumentSnapshot> sortedHospitals = [
                              ...verification,
                            ];

                            return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: sortedHospitals.length,
                              itemBuilder: (BuildContext context, int index) {
                                DocumentSnapshot data = sortedHospitals[index];
                                if (!_searchQuery.isEmpty &&
                                    !data['hospitalName']
                                        .toLowerCase()
                                        .contains(_searchQuery.toLowerCase())) {
                                  // Skip this hospital if it doesn't match the search query
                                  return SizedBox.shrink();
                                }
                                return FutureBuilder<int>(
                                  builder: (BuildContext context,
                                      AsyncSnapshot<int> countSnapshot) {
                                    if (countSnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      // Show a loading indicator while data is being fetched
                                    }
                                    if (countSnapshot.hasError) {
                                      // Handle error if any
                                      return Text(
                                          'Error: ${countSnapshot.error}');
                                    }
                                    int nohospital = countSnapshot.data ?? 0;

                                    return Row(
                                      children: [
                                        HospitalApproveListWidget(
                                          size: size,
                                          hospitalname: data['hospitalName'],
                                          location: data['location'],
                                          district: data['district'],
                                          imageurl: data['Logo'],
                                          onPress: () {
                                            nextScreen(
                                                context,
                                                HospitalPage(
                                                  hospitalName:
                                                      data['hospitalName'],
                                                  district: data['district'],
                                                  logo: data['Logo'],
                                                  address: data['address'],
                                                  affiliatted: data[
                                                      'affiliateduniversity'],
                                                  ambulanceNo:
                                                      data['ambulanceNo'],
                                                  bedNo: data['bedNo'],
                                                  doctorsNo: data['doctorsNo'],
                                                  emergencydpt: data[
                                                      'emergencydepartment'],
                                                  sitlink: data['sitLink'],
                                                  govtprivate:
                                                      data['GovtorPrivate'],
                                                  highlight: data['highlight'],
                                                  hospital1: data['hospital1'],
                                                  hospital2: data['hospital2'],
                                                  hospital3: data['hospital3'],
                                                  image1url: data['image1'],
                                                  image2url: data['image2'],
                                                  image3url: data['image3'],
                                                  image4url: data['image4'],
                                                  image5url: data['image5'],
                                                  length: data[
                                                      'uploadDocternumber'],
                                                  location: data['location'],
                                                  overview: data['overview'],
                                                  phoneno: data['phoneno'],
                                                  sdistance1: data[
                                                      'surroundingdistance1'],
                                                  sdistance2: data[
                                                      'surroundingdistance2'],
                                                  service: data['services'],
                                                  splace1:
                                                      data['surroundingplace1'],
                                                  splace2:
                                                      data['surroundingplace2'],
                                                  stime1:
                                                      data['surroundingtime1'],
                                                  stime2:
                                                      data['surroundingtime2'],
                                                  time: data['time'],
                                                  type: data['type'],
                                                  year: data['establishedYear'],
                                                  doctorSpeciality: List.from(data[
                                                      'doctorName&Specialist']),
                                                  doctordetails:
                                                      _buildDoctorList(data),
                                                ));
                                          },
                                          btnPress: () async {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      "Approve the hospital"),
                                                  content: Text(
                                                      "Are you to approved ${data['hospitalName']} ?"),
                                                  actions: [
                                                    const SizedBox(height: 3),
                                                    Form(
                                                      key: fromKey,
                                                      child: TextFormField(
                                                        obscureText: passVisible
                                                            ? false
                                                            : true,
                                                        decoration:
                                                            InputDecoration(
                                                          prefixIcon:
                                                              const Icon(Icons
                                                                  .fingerprint_outlined),
                                                          labelText: 'Password',
                                                          border:
                                                              const OutlineInputBorder(),
                                                          suffixIcon:
                                                              IconButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                passVisible =
                                                                    !passVisible; // Toggle the value of passVisible
                                                              });
                                                            },
                                                            icon: passVisible
                                                                ? const Icon(
                                                                    LineAwesomeIcons
                                                                        .eye)
                                                                : const Icon(
                                                                    LineAwesomeIcons
                                                                        .eye_slash),
                                                          ),
                                                        ),
                                                        onChanged: (val) {
                                                          password = val;
                                                        },
                                                        validator: (val) {
                                                          if (val!.length < 6) {
                                                            return "Password must be at least 6 characters";
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Row(
                                                      children: [
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .black),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              "cancel"),
                                                        ),
                                                        const SizedBox(
                                                            width: 18),
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .black),
                                                          child:
                                                              const Text("Yes"),
                                                          onPressed: () async {
                                                            if (fromKey
                                                                .currentState!
                                                                .validate()) {
                                                              setState(() {
                                                                _isLoding =
                                                                    true;
                                                              });
                                                              await authService
                                                                  .loginUserAccount(
                                                                      widget
                                                                          .email,
                                                                      password)
                                                                  .then(
                                                                      (value) async {
                                                                print('login');
                                                                if (value ==
                                                                    true) {
                                                                  Navigator.pop(
                                                                      context);
                                                                  uploadHopital(
                                                                    data[
                                                                        'hospitalName'],
                                                                    data[
                                                                        'establishedYear'],
                                                                    data[
                                                                        'location'],
                                                                    data[
                                                                        'district'],
                                                                    data[
                                                                        'address'],
                                                                    data[
                                                                        'highlight'],
                                                                    data[
                                                                        'phoneno'],
                                                                    data[
                                                                        'time'],
                                                                    data[
                                                                        'doctorsNo'],
                                                                    data[
                                                                        'bedNo'],
                                                                    data[
                                                                        'ambulanceNo'],
                                                                    data[
                                                                        'sitLink'],
                                                                    data[
                                                                        'Logo'],
                                                                    data[
                                                                        'GovtorPrivate'],
                                                                    data[
                                                                        'type'],
                                                                    data[
                                                                        'affiliateduniversity'],
                                                                    data[
                                                                        'emergencydepartment'],
                                                                    data[
                                                                        'surroundingplace1'],
                                                                    data[
                                                                        'surroundingdistance1'],
                                                                    data[
                                                                        'surroundingtime1'],
                                                                    data[
                                                                        'surroundingplace2'],
                                                                    data[
                                                                        'surroundingdistance2'],
                                                                    data[
                                                                        'surroundingtime2'],
                                                                    getDoctorNames(
                                                                        data),
                                                                    getDoctorSpecialities(
                                                                        data),
                                                                    data[
                                                                        'hospital1'],
                                                                    data[
                                                                        'hospital2'],
                                                                    data[
                                                                        'hospital3'],
                                                                    data[
                                                                        'overview'],
                                                                    data[
                                                                        'services'],
                                                                    data[
                                                                        'image1'],
                                                                    data[
                                                                        'image2'],
                                                                    data[
                                                                        'image3'],
                                                                    data[
                                                                        'image4'],
                                                                    data[
                                                                        'image5'],
                                                                    data[
                                                                        'uploaderName'],
                                                                    data[
                                                                        'uploaderPhoneNo'],
                                                                    data[
                                                                        'Latitude'],
                                                                    data[
                                                                        'Longitude'],
                                                                  );
                                                                  setState(() {
                                                                    _isLoding =
                                                                        false;
                                                                  });
                                                                } else {
                                                                  setState(() {
                                                                    showSnackbar(
                                                                        context,
                                                                        Colors
                                                                            .red,
                                                                        value);
                                                                    _isLoding =
                                                                        false;
                                                                  });
                                                                }
                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          CallbtnPress: () async {
                                            Uri phoneno = Uri.parse(
                                                'tel:' + data['phoneno']);
                                            if (await launchUrl(phoneno)) {
                                              launchUrl(phoneno);
                                            } else {
                                              //dailer is not opened
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              padding: const EdgeInsets.only(bottom: 200),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
          );
  }

  List<TextEditingController> getDoctorNames(DocumentSnapshot hospital) {
    List<TextEditingController> doctorNames = [];
    if (hospital['doctorName&Specialist'] != null) {
      List doctors = hospital['doctorName&Specialist'];
      for (var doctor in doctors) {
        doctorNames.add(doctor['DoctorName']);
      }
    }
    return doctorNames;
  }

  List<TextEditingController> getDoctorSpecialities(DocumentSnapshot hospital) {
    List<TextEditingController> specialities = [];
    if (hospital['doctorName&Specialist'] != null) {
      List doctors = hospital['doctorName&Specialist'];
      for (var doctor in doctors) {
        specialities.add(doctor['Specialist']);
      }
    }
    return specialities;
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

  uploadHopital(
      String hospitalname,
      String establisedYr,
      String location,
      String district,
      String address,
      String highlight,
      String phone,
      String time,
      String noDoctors,
      String bed,
      String noambulance,
      String locationMap,
      String logoUrl,
      String gp,
      String type,
      String affUniversity,
      String emergency,
      String surround1,
      String surroundDistance1,
      String surroundTime1,
      String surround2,
      String surroundDistance2,
      String surroundTime2,
      List<TextEditingController> _DoctorName,
      List<TextEditingController> _Specialist,
      String nearhospital1,
      String nearhospital2,
      String nearhospital3,
      String overview,
      String services,
      String image1Url,
      String image2Url,
      String image3Url,
      String image4Url,
      String image5Url,
      String username,
      String userphoneno,
      String lat,
      String long) async {
    await DatabaseServiceHospital().savingHospitaldetails(
        hospitalname,
        establisedYr,
        location,
        district,
        address,
        highlight,
        phone,
        time,
        noDoctors,
        bed,
        noambulance,
        locationMap,
        logoUrl,
        gp,
        type,
        affUniversity,
        emergency,
        surround1,
        surroundDistance1,
        surroundTime1,
        surround2,
        surroundDistance2,
        surroundTime2,
        _DoctorName.length,
        _DoctorName,
        _Specialist,
        nearhospital1,
        nearhospital2,
        nearhospital3,
        overview,
        services,
        image1Url,
        image2Url,
        image3Url,
        image4Url,
        image5Url,
        username,
        userphoneno,
        lat,
        long);
    // ignore: use_build_context_synchronously
    newshowSnackbar(context, 'Successfully',
        'successfully upload the hospital details', ContentType.success);
  }
}

class HospitalApproveListWidget extends StatelessWidget {
  const HospitalApproveListWidget({
    super.key,
    required this.size,
    required this.hospitalname,
    required this.location,
    required this.district,
    required this.imageurl,
    required this.onPress,
    required this.btnPress,
    required this.CallbtnPress,
  });
  final VoidCallback onPress;
  final VoidCallback btnPress;
  final VoidCallback CallbtnPress;
  final String hospitalname;
  final String location;
  final String district;
  final Size size;
  final String imageurl;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPress,
          child: Container(
            padding:
                const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
            width: size.width - 30,
            height: 200,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  specialcolor.AppColor.gradientFirst.withOpacity(0.9),
                  specialcolor.AppColor.gradientSecond.withOpacity(0.9)
                ], begin: Alignment.bottomLeft, end: Alignment.centerRight),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: CircleAvatar(
                          backgroundImage: Image.network(imageurl).image),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        hospitalname,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      district,
                      style: const TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 10,
                          color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: BorderSide.none,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                      ),
                      onPressed: CallbtnPress,
                      child: const Text('Call'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: BorderSide.none,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green,
                      ),
                      onPressed: btnPress,
                      child: const Text('Approved'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}
