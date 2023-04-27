import 'package:carevista_ver05/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

TextEditingController _searchController = TextEditingController();
String _searchQuery = '';

class _UserInfoState extends State<UserInfo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController = TextEditingController();
    _searchQuery = '';
  }

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
              'User Details',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25, color: Theme.of(context).primaryColorDark),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(5),
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
                          .collection('users')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                              child: Lottie.asset(
                                  'animation/96949-loading-animation.json',
                                  height: 100));
                        }
                        List<DocumentSnapshot> users = snapshot.data!.docs;

                        List<DocumentSnapshot> adminkeyFalse = users
                            .where((users) => users['AdKey'] == 'false')
                            .toList();

                        List<DocumentSnapshot> sortedHospitals = [
                          ...adminkeyFalse,
                        ];
                        return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: sortedHospitals.length,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot data = sortedHospitals[index];
                            if (!_searchQuery.isEmpty &&
                                !data['fullName']
                                    .toLowerCase()
                                    .contains(_searchQuery.toLowerCase()) &&
                                !data['email']
                                    .toLowerCase()
                                    .contains(_searchQuery.toLowerCase()) &&
                                !data['phoneNo']
                                    .toLowerCase()
                                    .contains(_searchQuery.toLowerCase())) {
                              // Skip this hospital if it doesn't match the search query
                              return SizedBox.shrink();
                            }
                            return FutureBuilder<int>(
                              future: getNumberCount(data['phoneNo']),
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
                                    UserInformationListWidget(
                                      Adkey: data['AdKey'],
                                      size: size,
                                      name: data['fullName'],
                                      phoneno: data['phoneNo'],
                                      Email: data['email'],
                                      nohospital: nohospital.toString(),
                                      imageurl: data['profilepic'],
                                      onPress: () {},
                                      btnPress: () async {
                                        deleteuser(
                                            data['fullName'], data['uid']);
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
        ),
      ),
    );
  }

  deleteuser(String username, String uid) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete the User Details"),
          content: Text("Are you to remove $username to Admin?"),
          actions: [
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("cancel"),
                ),
                const SizedBox(width: 18),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: const Text("Yes"),
                  onPressed: () async {
                    DocumentReference docRef =
                        FirebaseFirestore.instance.collection('users').doc(uid);
                    docRef.delete().then((value) {
                      showSnackBar(context, '$username delete the collection');
                    }).catchError((error) {
                      print('Error deleting document: $error');
                      showSnackBar(context, 'Error deleting document: $error');
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Future<int> getNumberCount(String number) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(
            'hospitals') // Replace with the name of your Firebase collection
        .where('uploaderPhoneNo',
            isEqualTo:
                number) // Replace 'name' with the field name in your collection
        .get();

    return querySnapshot.docs
        .length; // Return the count of documents that match the search criteria
  }
}

class UserInformationListWidget extends StatelessWidget {
  const UserInformationListWidget({
    super.key,
    required this.size,
    required this.name,
    required this.phoneno,
    required this.Email,
    required this.nohospital,
    required this.imageurl,
    required this.onPress,
    required this.Adkey,
    required this.btnPress,
  });
  final VoidCallback onPress;
  final VoidCallback btnPress;
  final String name;
  final String phoneno;
  final String Email;
  final String nohospital;
  final Size size;
  final String imageurl;
  final String Adkey;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPress,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    left: 5, right: 5, top: 10, bottom: 10),
                width: size.width - 10,
                height: 200 - 5,
                decoration: BoxDecoration(
                    color: const Color(0xFFFB4C5B).withOpacity(0.6),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: CircleAvatar(
                                    backgroundImage: imageurl == ''
                                        ? const AssetImage(
                                            'Assets/images/profile-user.jpg')
                                        : Image.network(
                                            imageurl,
                                          ).image,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  phoneno,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 10,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  Email,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 10,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Uploaded Hospital :- ' +
                                      nohospital.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 10,
                                      color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            side: BorderSide.none,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.red,
                          ),
                          onPressed: btnPress,
                          child: const Text('Delete'),
                        ),
                        const SizedBox(width: 25),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}
