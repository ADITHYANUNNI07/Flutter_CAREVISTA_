import 'package:carevista_ver05/SCREEN/addons/patientrecord.dart';
import 'package:carevista_ver05/SCREEN/dashboard.dart';
import 'package:carevista_ver05/main.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Favorites extends StatefulWidget {
  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    int selsctedIconIndex = 3;
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Data', style: TextStyle(color: Colors.black)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('hospitals').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            final documents = snapshot.data!.docs;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (BuildContext context, int index) {
                final data = documents[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['hospitalName']),
                  subtitle: Text(data['district']),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        index: selsctedIconIndex,
        buttonBackgroundColor: const Color(0XFF407BFF),
        height: 60.0,
        color: Theme.of(context).canvasColor,
        onTap: (index) {
          setState(() {
            selsctedIconIndex = index;
          });
        },
        animationDuration: const Duration(milliseconds: 200),
        items: <Widget>[
          IconButton(
            onPressed: () {
              nextScreenReplace(context, const PatientRecord());
            },
            icon: const Icon(Icons.library_books_outlined, size: 30),
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
          IconButton(
            onPressed: () {
              nextScreenReplace(context, Dashboard());
            },
            icon: const Icon(Icons.home_outlined, size: 30),
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
/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Hospital {
  String name;
  List<Map<String, String>> doctorNameSpecialist;

  Hospital({required this.name, required this.doctorNameSpecialist});
}

class HospitalListScreen extends StatefulWidget {
  @override
  _HospitalListScreenState createState() => _HospitalListScreenState();
}

class _HospitalListScreenState extends State<HospitalListScreen> {
  late Future<List<Hospital>> _hospitalsFuture;

  @override
  void initState() {
    super.initState();
    _hospitalsFuture = _getHospitals();
  }

  Future<List<Hospital>> _getHospitals() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("hospitals").get();

    List<Hospital> hospitals = [];

    for (var doc in querySnapshot.docs) {
      String name = doc["KIMS HEALTH Hospital Trivandrum"];

      List<Map<String, String>> doctorNameSpecialist =
          (doc["doctorName&Specialist"] as List)
              .map((e) => Map<String, String>.from(e))
              .toList();

      hospitals.add(
          Hospital(name: name, doctorNameSpecialist: doctorNameSpecialist));
    }

    return hospitals;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hospital List'),
      ),
      body: Center(
        child: FutureBuilder<List<Hospital>>(
          future: _hospitalsFuture,
          builder:
              (BuildContext context, AsyncSnapshot<List<Hospital>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    Hospital hospital = snapshot.data![index];
                    return ListTile(
                      title: Text(hospital.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: hospital.doctorNameSpecialist.map((doctor) {
                          return Text(
                              '${doctor["DoctorName"]} - ${doctor["Specialist"]}');
                        }).toList(),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
import 'dart:ui';

import 'package:carevista_ver05/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HospitalDetailsPage extends StatefulWidget {
  @override
  State<HospitalDetailsPage> createState() => _HospitalDetailsPageState();
}

class _HospitalDetailsPageState extends State<HospitalDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hospital Details'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('hospitals').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot hospital = snapshot.data!.docs[index];
              return Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(hospital['hospitalName']),
                      subtitle: Text(hospital['location']),
                      trailing: Text(hospital['type']),
                    ),
                    ExpansionTile(
                      title: Text('Doctors'),
                      children: _buildDoctorList(hospital),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          nextScreen(
                              context,
                              MyWidget(
                                name: hospital['hospitalName'],
                                list: _buildDoctorList(hospital),
                              ));
                          print(_buildDoctorList(hospital));
                        },
                        child: Text('data'))
                  ],
                ),
              );
            },
          );
        },
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

class MyWidget extends StatelessWidget {
  MyWidget({super.key, required this.name, required this.list});
  String name;
  List<Widget> list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(name),
            ExpansionTile(title: Text('Doctors'), children: list),
          ],
        ),
      ),
    );
  }
}

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HospitalListPage extends StatefulWidget {
  @override
  _HospitalListPageState createState() => _HospitalListPageState();
}

class _HospitalListPageState extends State<HospitalListPage> {
  final CollectionReference _hospitalRef =
      FirebaseFirestore.instance.collection('hospitals');
  List<QueryDocumentSnapshot> _hospitalList = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _getNearbyHospitals(position.latitude, position.longitude);
  }

  Future<void> _getNearbyHospitals(double latitude, double longitude) async {
    double radius = 5000; // 5km
    QuerySnapshot querySnapshot = await _hospitalRef
        .where('location',
            isLessThanOrEqualTo: GeoPoint(latitude + radius / 111000,
                longitude + radius / (111000 * cos(latitude))))
        .where('location',
            isGreaterThanOrEqualTo: GeoPoint(latitude - radius / 111000,
                longitude - radius / (111000 * cos(latitude))))
        .get();

    setState(() {
      _hospitalList = querySnapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Hospitals'),
      ),
      body: _hospitalList.isNotEmpty
          ? ListView.builder(
              itemCount: _hospitalList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      _hospitalList[index].data()?['name']?.toString() ?? ''),
                  subtitle: Text(
                      _hospitalList[index].data()?['address']?.toString() ??
                          ''),
                  trailing: Text(
                    '${(_hospitalList[index].data()?['distance'] as num?)?.toStringAsFixed(2) ?? ''} km',
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}*/
