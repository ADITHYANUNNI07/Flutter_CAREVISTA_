import 'package:carevista_ver05/SCREEN/addons/patientrecord.dart';
import 'package:carevista_ver05/SCREEN/dashboard.dart';
import 'package:carevista_ver05/SCREEN/home/favorites.dart';
import 'package:carevista_ver05/SCREEN/home/hospital.dart';
import 'package:carevista_ver05/SCREEN/profile.dart';
import 'package:carevista_ver05/main.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:carevista_ver05/SCREEN/addons/color.dart' as specialcolor;

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

TextEditingController _searchController = TextEditingController();
int selsctedIconIndex = 1;
String _searchQuery = '';

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: const Color(0xFF04FBC3),
      child: SafeArea(
          child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
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
                        return Center(child: CircularProgressIndicator());
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
                          if (!_searchQuery.isEmpty &&
                              !data['hospitalName']
                                  .toLowerCase()
                                  .contains(_searchQuery.toLowerCase())) {
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
                      );
                    },
                  ),
                )
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
                nextScreen(context, const PatientRecord());
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
            GestureDetector(
              onTap: () {
                nextScreen(context, const Dashboard());
              },
              child: Icon(
                Icons.home_outlined,
                size: 30,
                color: selsctedIconIndex == 2
                    ? Colors.white
                    : MyApp.themeNotifier.value == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
              ),
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

class SearchListContainerWidget extends StatelessWidget {
  SearchListContainerWidget(
      {super.key,
      required this.size,
      required this.hospitalName,
      required this.district,
      required this.imageSrc,
      required this.onPress});
  String hospitalName;
  String district;
  String imageSrc;
  final Size size;
  final VoidCallback onPress;
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
            height: 150,
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
                          backgroundImage: Image.network(imageSrc).image),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        hospitalName,
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
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}
