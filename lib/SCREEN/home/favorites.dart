import 'package:carevista_ver05/SCREEN/addons/patientrecord.dart';
import 'package:carevista_ver05/SCREEN/dashboard.dart';
import 'package:carevista_ver05/SCREEN/home/search.dart';
import 'package:carevista_ver05/SCREEN/profile.dart';
import 'package:carevista_ver05/main.dart';
import 'package:carevista_ver05/utils/utils.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'dart:math' show cos, sqrt, asin;

class Favorites extends StatefulWidget {
  @override
  State<Favorites> createState() => _FavoritesState();
}

final Uid = FirebaseAuth.instance.currentUser?.uid ?? '';

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    int selsctedIconIndex = 3;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('Favorites', style: TextStyle(color: Colors.black)),
      ),
      body: Container(),
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
          GestureDetector(
            onTap: () {
              nextScreen(context, const Search());
            },
            child: Icon(
              Icons.search,
              size: 30,
              color: selsctedIconIndex == 1
                  ? Colors.white
                  : MyApp.themeNotifier.value == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              nextScreenReplace(context, const Dashboard());
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
          GestureDetector(
            onTap: () async {
              nextScreen(
                  context,
                  ProfilePage(
                      imageUrl: await getImageURLFromUserId(Uid),
                      phoneNo: phoneNo,
                      email: email,
                      userName: userName));
            },
            child: Icon(
              Icons.person_outline,
              size: 30,
              color: selsctedIconIndex == 4
                  ? Colors.white
                  : MyApp.themeNotifier.value == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
