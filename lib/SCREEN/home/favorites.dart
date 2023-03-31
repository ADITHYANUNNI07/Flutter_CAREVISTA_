import 'package:carevista_ver05/SCREEN/addons/patientrecord.dart';
import 'package:carevista_ver05/SCREEN/dashboard.dart';
import 'package:carevista_ver05/main.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'dart:math' show cos, sqrt, asin;

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
        title:
            const Text('Firestore Data', style: TextStyle(color: Colors.black)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('PatientRecord')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('Loading...');
            default:
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  return ListTile(
                    title: Text(data['FolderName'] ?? ''),
                    subtitle: Text(data['Remark'] ?? ''),
                  );
                }).toList(),
              );
          }
        },
      ),
      /*StreamBuilder<QuerySnapshot>(
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )*/
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
}

class HospitalList extends StatelessWidget {
  const HospitalList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData txttheme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('hospitals').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<DocumentSnapshot> hospitals = snapshot.data!.docs;
          List<DocumentSnapshot> thiruvananthapuramHospitals = hospitals
              .where((hospital) => hospital['district'] == 'Thiruvananthapuram')
              .toList();
          List<DocumentSnapshot> kollamHospitals = hospitals
              .where((hospital) => hospital['district'] == 'Kollam')
              .toList();
          List<DocumentSnapshot> pathanamthittaHospitals = hospitals
              .where((hospital) => hospital['district'] == 'Pathanamthitta')
              .toList();
          List<DocumentSnapshot> sortedHospitals = [
            ...thiruvananthapuramHospitals,
            ...kollamHospitals,
            ...pathanamthittaHospitals
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
                    txttheme: txttheme,
                    onPress: () {
                      // Handle hospital selection
                    },
                  ),
                  const SizedBox(width: 20),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class TopHospitalListScroll extends StatelessWidget {
  const TopHospitalListScroll({
    Key? key,
    required this.hospitalName,
    required this.district,
    required this.imageSrc,
    required this.txttheme,
    required this.onPress,
  }) : super(key: key);

  final String hospitalName;
  final String district;
  final String imageSrc;
  final ThemeData txttheme;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPress,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    image: DecorationImage(
                      image: NetworkImage(imageSrc),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hospitalName,
                        style: txttheme.textTheme.headline6,
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}

class HospitalList extends StatefulWidget {
  const HospitalList({Key? key}) : super(key: key);

  @override
  _HospitalListState createState() => _HospitalListState();
}

class _HospitalListState extends State<HospitalList> {
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    final txttheme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('hospitals').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData || _currentPosition == null) {
            return Center(child: CircularProgressIndicator());
          }

          final List<DocumentSnapshot> hospitals = snapshot.data!.docs;
          final List<DocumentSnapshot> sortedHospitals =
              _sortHospitalsByDistance(hospitals, _currentPosition!);

          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: sortedHospitals.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot data = sortedHospitals[index];
              return Row(
                children: [
                  HospitalListScroll(
                    txttheme: txttheme,
                    hospitalName: data['hospitalName'],
                    district: data['district'],
                    imageSrc: data['Logo'],
                    onPress: () {
                      // Handle hospital selection
                    },
                  ),
                  const SizedBox(width: 20),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class HospitalListScroll extends StatelessWidget {
  const HospitalListScroll({
    Key? key,
    required this.hospitalName,
    required this.district,
    required this.imageSrc,
    required this.txttheme,
    required this.onPress,
  }) : super(key: key);

  final String hospitalName;
  final String district;
  final String imageSrc;
  final ThemeData txttheme;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPress,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    image: DecorationImage(
                      image: NetworkImage(imageSrc),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hospitalName,
                        style: txttheme.textTheme.headline6,
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}


class HospitalWithDistance {
  final DocumentSnapshot hospital;
  final double distanceInMeters;

  HospitalWithDistance(
      {required this.hospital, required this.distanceInMeters});
}

class HospitalsList extends StatefulWidget {
  const HospitalsList({Key? key}) : super(key: key);

  @override
  _HospitalsListState createState() => _HospitalsListState();
}

class _HospitalsListState extends State<HospitalsList> {
  late Position _currentPosition;
  bool _isLoading = true;
  late List<DocumentSnapshot> _hospitals;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
      });
      await _getHospitals();
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e);
    }
  }

  Future<void> _getHospitals() async {
    final CollectionReference hospitalsRef =
        FirebaseFirestore.instance.collection('hospitals');
    final QuerySnapshot querySnapshot = await hospitalsRef.get();
    final List<DocumentSnapshot> hospitals = querySnapshot.docs;
    final List<DocumentSnapshot> sortedHospitals =
        _sortHospitalsByDistance(hospitals, _currentPosition);
    setState(() {
      _isLoading = false;
      _hospitals = sortedHospitals;
    });
  }

  List<DocumentSnapshot> _sortHospitalsByDistance(
      List<DocumentSnapshot> hospitals, Position currentPosition) {
    final List<HospitalWithDistance> hospitalsWithDistances =
        hospitals.map((hospital) {
      final double distanceInMeters = _calculateDistanceInMeters(
          currentPosition.latitude,
          currentPosition.longitude,
          hospital['location']['latitude'],
          hospital['location']['longitude']);
      return HospitalWithDistance(
        hospital: hospital,
        distanceInMeters: distanceInMeters,
      );
    }).toList();
    hospitalsWithDistances
        .sort((a, b) => a.distanceInMeters.compareTo(b.distanceInMeters));
    return hospitalsWithDistances
        .map((hospitalWithDistance) => hospitalWithDistance.hospital)
        .toList();
  }

  double _calculateDistanceInMeters(
      double lat1, double lon1, double lat2, double lon2) {
    const int radiusOfEarthInMeters = 6371000;
    final double latDistance = _toRadians(lat2 - lat1);
    final double lonDistance = _toRadians(lon2 - lon1);
    final double a = sin(latDistance / 2) * sin(latDistance / 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(lonDistance / 2) *
            sin(lonDistance / 2);
    final double c = 2 * asin(sqrt(a));
    return radiusOfEarthInMeters * c;
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Position currentPosition;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      isLoading = true;
    });
    currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearest Hospitals'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : HospitalList(currentPosition: currentPosition),
    );
  }
}

class HospitalList extends StatefulWidget {
  final Position currentPosition;

  const HospitalList({Key? key, required this.currentPosition})
      : super(key: key);

  @override
  _HospitalListState createState() => _HospitalListState();
}

class _HospitalListState extends State<HospitalList> {
  List<DocumentSnapshot> hospitals = [];

  @override
  void initState() {
    super.initState();
    _getHospitals();
  }

  Future<void> _getHospitals() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('hospitals').get();
    setState(() {
      hospitals = snapshot.docs;
      hospitals.sort((a, b) {
        double distanceToA = calculateDistance(
            widget.currentPosition.latitude,
            widget.currentPosition.longitude,
            a['location'].latitude,
            a['location'].longitude);
        double distanceToB = calculateDistance(
            widget.currentPosition.latitude,
            widget.currentPosition.longitude,
            b['location'].latitude,
            b['location'].longitude);
        return distanceToA.compareTo(distanceToB);
      });
    });
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    const p = 0.017453292519943295;
    final a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: hospitals.length,
      itemBuilder: (BuildContext context, int index) {
        final hospital = hospitals[index];
        double distanceToHospital = calculateDistance(
            widget.currentPosition.latitude,
            widget.currentPosition.longitude,
            hospital['location'].latitude,
            hospital['location'].longitude);
        return ListTile(
          title: Text(hospital['name']),
          subtitle: Text('${distanceToHospital.toStringAsFixed(2)} km away'),
        );
      },
    );
  }
}

class LocationDemo extends StatefulWidget {
  @override
  _LocationDemoState createState() => _LocationDemoState();
}

class _LocationDemoState extends State<LocationDemo> {
  Location _location = Location();
  LocationData? _currentLocation;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      final hasPermission = await _location.hasPermission();
      if (hasPermission == PermissionStatus.denied) {
        await _location.requestPermission();
      }
      final locationData = await _location.getLocation();
      setState(() {
        _currentLocation = locationData;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Demo'),
      ),
      body: Center(
        child: _currentLocation == null
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Latitude: ${_currentLocation!.latitude}'),
                  Text('Longitude: ${_currentLocation!.longitude}'),
                ],
              ),
      ),
    );
  }
}*/

class Hospitallak {
  final String name;
  final double lat;
  final double lng;

  Hospitallak({
    required this.name,
    required this.lat,
    required this.lng,
  });
}

class HospitalListPage extends StatefulWidget {
  final List<Hospitallak> hospitals;

  HospitalListPage({required this.hospitals});

  @override
  _HospitalListPageState createState() => _HospitalListPageState();
}

class _HospitalListPageState extends State<HospitalListPage> {
  LocationData? _currentLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final location = Location();
      final currentLocation = await location.getLocation();
      setState(() {
        _currentLocation = currentLocation;
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  double _calculateDistance(
      double lat1, double lng1, double lat2, double lng2) {
    const p = 0.017453292519943295; // 1 degree = 0.017453292519943295 radians
    final a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lng2 - lng1) * p)) / 2;
    return 12742 * asin(sqrt(a)); // 2 * R; R = 6371 km
  }

  List<Hospitallak> _sortHospitalsByDistance() {
    if (_currentLocation == null) {
      return widget.hospitals;
    }
    final sortedHospitals = List.of(widget.hospitals);
    sortedHospitals.sort((a, b) {
      final distanceA = _calculateDistance(_currentLocation!.latitude!,
          _currentLocation!.longitude!, a.lat, a.lng);
      final distanceB = _calculateDistance(_currentLocation!.latitude!,
          _currentLocation!.longitude!, b.lat, b.lng);
      return distanceA.compareTo(distanceB);
    });
    return sortedHospitals;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospitals'),
      ),
      body: ListView(
        children: _sortHospitalsByDistance().map((hospital) {
          return ListTile(
            title: Text(hospital.name),
            subtitle: _currentLocation != null
                ? Text(
                    'Distance: ${_calculateDistance(_currentLocation!.latitude!, _currentLocation!.longitude!, hospital.lat, hospital.lng).toStringAsFixed(2)} km')
                : null,
          );
        }).toList(),
      ),
    );
  }
}
