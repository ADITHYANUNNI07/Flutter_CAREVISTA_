import 'package:carevista_ver05/SCREEN/home/hospital.dart';
import 'package:carevista_ver05/Service/auth_service.dart';
import 'package:carevista_ver05/admin/edithospital.dart';
import 'package:carevista_ver05/main.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:carevista_ver05/SCREEN/addons/color.dart' as specialcolor;

class HospitalInfo extends StatefulWidget {
  const HospitalInfo({super.key, required this.email});
  final String email;
  @override
  State<HospitalInfo> createState() => _HospitalInfoState();
}

AuthService authService = AuthService();
final fromKey = GlobalKey<FormState>();
TextEditingController _searchController = TextEditingController();
String _searchQuery = '';
bool _isLoding = false;
String password = '';
bool passVisible = false;

class _HospitalInfoState extends State<HospitalInfo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController = TextEditingController();
    _searchQuery = '';
    setState(() {
      bool _isLoding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
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
            'Hospital Information',
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
                        .collection('hospitals')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                            child: Lottie.asset(
                                'animation/96949-loading-animation.json',
                                height: 100));
                      }
                      List<DocumentSnapshot> hospital = snapshot.data!.docs;

                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: hospital.length,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot data = hospital[index];
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
                                return Text('Error: ${countSnapshot.error}');
                              }
                              int nohospital = countSnapshot.data ?? 0;

                              return Row(
                                children: [
                                  HospitalInformationListWidget(
                                    size: size,
                                    hospitalname: data['hospitalName'],
                                    location: data['location'],
                                    district: data['district'],
                                    imageurl: data['Logo'],
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
                                            doctordetails:
                                                _buildDoctorList(data),
                                          ));
                                    },
                                    btnPress: () async {
                                      nextScreen(
                                          context,
                                          EditHospital(
                                            doctorspecialistno:
                                                data['uploadDocternumber'],
                                            hospitalname: data['hospitalName'],
                                            district: data['district'],
                                            logo: data['Logo'],
                                            address: data['address'],
                                            affilicated:
                                                data['affiliateduniversity'],
                                            noambulance: data['ambulanceNo'],
                                            nobed: data['bedNo'],
                                            nodoctor: data['doctorsNo'],
                                            emergency:
                                                data['emergencydepartment'],
                                            hospitallink: data['sitLink'],
                                            govtorprivate:
                                                data['GovtorPrivate'],
                                            highlight: data['highlight'],
                                            nearhospital1: data['hospital1'],
                                            nearhospital2: data['hospital2'],
                                            nearhospital3: data['hospital3'],
                                            image1: data['image1'],
                                            image2: data['image2'],
                                            image3: data['image3'],
                                            image4: data['image4'],
                                            image5: data['image5'],
                                            location: data['location'],
                                            overview: data['overview'],
                                            phonenumber: data['phoneno'],
                                            surroundDistance1:
                                                data['surroundingdistance1'],
                                            surroundDistance2:
                                                data['surroundingdistance2'],
                                            service: data['services'],
                                            surround1:
                                                data['surroundingplace1'],
                                            surround2:
                                                data['surroundingplace2'],
                                            surroundTime1:
                                                data['surroundingtime1'],
                                            surroundTime2:
                                                data['surroundingtime2'],
                                            time: data['time'],
                                            type: data['type'],
                                            establisedyear:
                                                data['establishedYear'],
                                            latitude: data['Latitude'],
                                            longitude: data['Longitude'],
                                            doctorname: [
                                              ...getDoctorNames(data),
                                            ],
                                            specialist: [
                                              ...getDoctorSpecialities(data),
                                            ],
                                          ));
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

  /* List<String> doctorName(DocumentSnapshot hospital) {
    List<String> doctorList = [];
    if (hospital['doctorName&Specialist'] != null) {
      List doctors = hospital['doctorName&Specialist'];
      for (var doctor in doctors) {
        doctorList.add(doctor['DoctorName']);
      }
    }
    return doctorList;
  }

  List<String> doctorSpeciality(DocumentSnapshot hospital) {
    List<String> doctorList = [];
    if (hospital['doctorName&Specialist'] != null) {
      List doctors = hospital['doctorName&Specialist'];
      for (var doctor in doctors) {
        doctorList.add(doctor['Specialist']);
      }
    }
    return doctorList;
  }*/
  List<String> getDoctorNames(DocumentSnapshot hospital) {
    List<String> doctorNames = [];
    if (hospital['doctorName&Specialist'] != null) {
      List doctors = hospital['doctorName&Specialist'];
      for (var doctor in doctors) {
        doctorNames.add(doctor['DoctorName']);
      }
    }
    return doctorNames;
  }

  List<String> getDoctorSpecialities(DocumentSnapshot hospital) {
    List<String> specialities = [];
    if (hospital['doctorName&Specialist'] != null) {
      List doctors = hospital['doctorName&Specialist'];
      for (var doctor in doctors) {
        specialities.add(doctor['Specialist']);
      }
    }
    return specialities;
  }
}

class HospitalInformationListWidget extends StatelessWidget {
  const HospitalInformationListWidget({
    super.key,
    required this.size,
    required this.hospitalname,
    required this.location,
    required this.district,
    required this.imageurl,
    required this.onPress,
    required this.btnPress,
  });
  final VoidCallback onPress;
  final VoidCallback btnPress;
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
                        backgroundColor: Colors.green,
                      ),
                      onPressed: btnPress,
                      child: const Text('Edit'),
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
