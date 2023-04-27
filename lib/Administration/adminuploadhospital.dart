import 'package:carevista_ver05/SCREEN/home/hospital.dart';
import 'package:carevista_ver05/SCREEN/home/search.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UploadAdmin extends StatefulWidget {
  UploadAdmin({required this.name, super.key});
  String name;
  @override
  State<UploadAdmin> createState() => _UploadAdminState();
}

class _UploadAdminState extends State<UploadAdmin> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: const Color(0xFF04FBC3),
      child: SafeArea(
          child: Scaffold(
        extendBody: true,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Column(
              children: [
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
                      List<DocumentSnapshot> hospitals = snapshot.data!.docs;
                      List<DocumentSnapshot> thiruvananthapuramHospitals =
                          hospitals
                              .where((hospital) =>
                                  hospital['district'] == 'Trivandrum')
                              .toList();
                      List<DocumentSnapshot> kollamHospitals = hospitals
                          .where((hospital) => hospital['district'] == 'Kollam')
                          .toList();
                      List<DocumentSnapshot> pathanamthittaHospitals = hospitals
                          .where((hospital) =>
                              hospital['district'] == 'Pathanamthitta')
                          .toList();
                      List<DocumentSnapshot> alaHospitals = hospitals
                          .where(
                              (hospital) => hospital['district'] == 'Alappuzha')
                          .toList();
                      List<DocumentSnapshot> KottayamHospitals = hospitals
                          .where(
                              (hospital) => hospital['district'] == 'Kottayam')
                          .toList();
                      List<DocumentSnapshot> IdukkiHospitals = hospitals
                          .where((hospital) => hospital['district'] == 'Idukki')
                          .toList();
                      List<DocumentSnapshot> ErnakulamHospitals = hospitals
                          .where(
                              (hospital) => hospital['district'] == 'Ernakulam')
                          .toList();
                      List<DocumentSnapshot> ThrissurHospitals = hospitals
                          .where(
                              (hospital) => hospital['district'] == 'Thrissur')
                          .toList();
                      List<DocumentSnapshot> PalakkadHospitals = hospitals
                          .where(
                              (hospital) => hospital['district'] == 'Palakkad')
                          .toList();
                      List<DocumentSnapshot> MalappuramHospitals = hospitals
                          .where((hospital) =>
                              hospital['district'] == 'Malappuram')
                          .toList();
                      List<DocumentSnapshot> KozhikodeHospitals = hospitals
                          .where(
                              (hospital) => hospital['district'] == 'Kozhikode')
                          .toList();
                      List<DocumentSnapshot> WayanadHospitals = hospitals
                          .where(
                              (hospital) => hospital['district'] == 'Wayanad')
                          .toList();
                      List<DocumentSnapshot> KannurHospitals = hospitals
                          .where((hospital) => hospital['district'] == 'Kannur')
                          .toList();
                      List<DocumentSnapshot> KasaragodHospitals = hospitals
                          .where(
                              (hospital) => hospital['district'] == 'Kasaragod')
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
                        scrollDirection: Axis.vertical,
                        itemCount: sortedHospitals.length,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot data = sortedHospitals[index];
                          if (!data['uploaderName']
                              .toLowerCase()
                              .contains(widget.name.toLowerCase())) {
                            // Skip this hospital if it doesn't match the search query
                            return SizedBox.shrink();
                          }
                          return Row(
                            children: [
                              SearchListContainerWidget(
                                size: size,
                                hospitalName: data['hospitalName'],
                                district: data['district'],
                                imageSrc: data['Logo'],
                                location: data['location'],
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
                            ],
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
}
