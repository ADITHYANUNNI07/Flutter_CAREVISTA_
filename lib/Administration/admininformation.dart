import 'package:carevista_ver05/Administration/adminuploadhospital.dart';
import 'package:carevista_ver05/Helper/helper_function.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AdminInfromation extends StatefulWidget {
  const AdminInfromation({super.key});

  @override
  State<AdminInfromation> createState() => _AdminInfromationState();
}

String imageUrl = '';
String email = '';

class _AdminInfromationState extends State<AdminInfromation> {
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
    await HelperFunction.getUserImageURLFromSF().then((value) {
      setState(() {
        imageUrl = value!;
      });
    });

    await HelperFunction.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: const Color(0xFF04FBC3),
      child: SafeArea(
          child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 60,
                color: Theme.of(context).cardColor,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 102),
                        const Text(
                          'CARE',
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'brandon_H',
                            color: Color(0xFF00008F),
                          ),
                        ),
                        // ignore: sized_box_for_whitespace
                        Container(
                          height: 60, // set the height of the container to 300
                          width: 40, // set the width of the container to 300
                          child: FractionallySizedBox(
                            widthFactor:
                                1, // set the width factor to 0.8 to take 80% of the container's width
                            heightFactor:
                                1, // set the height factor to 0.8 to take 80% of the container's height
                            child: Lottie.asset(
                              'animation/17169-smooth-healthy-animation (1).json',
                            ),
                          ),
                        ),
                        const Text(
                          'VISTA',
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'brandon_H',
                            color: Color(0xFF04FBC3),
                          ),
                        ),
                        const SizedBox(width: 66),
                        SizedBox(
                            width: 40,
                            height: 40,
                            child: CircleAvatar(
                              backgroundImage: imageUrl == ''
                                  ? const AssetImage(
                                      'Assets/images/profile-user.jpg')
                                  : Image.network(
                                      imageUrl,
                                    ).image,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
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
                              child: Lottie.network(
                                  'https://assets9.lottiefiles.com/packages/lf20_p8bfn5to.json',
                                  height: 100),
                            );
                          }
                          List<DocumentSnapshot> admins = snapshot.data!.docs;

                          return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: admins.length,
                            itemBuilder: (BuildContext context, int index) {
                              DocumentSnapshot data = admins[index];
                              if (!data['AdKey']
                                  .toLowerCase()
                                  .contains('true'.toLowerCase())) {
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
                                    return Text(
                                        'Error: ${countSnapshot.error}');
                                  }
                                  int nohospital = countSnapshot.data ?? 0;

                                  return Row(
                                    children: [
                                      AdminListWidget(
                                        size: size,
                                        name: data['fullName'],
                                        phoneno: data['phoneNo'],
                                        Email: data['email'],
                                        nohospital: nohospital.toString(),
                                        imageurl: data['profilepic'],
                                        onPress: () {
                                          nextScreen(
                                              context,
                                              UploadAdmin(
                                                  name: data['fullName']));
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
              )
            ],
          ),
        ),
      )),
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

class AdminListWidget extends StatelessWidget {
  const AdminListWidget({
    super.key,
    required this.size,
    required this.name,
    required this.phoneno,
    required this.Email,
    required this.nohospital,
    required this.imageurl,
    required this.onPress,
  });
  final VoidCallback onPress;
  final String name;
  final String phoneno;
  final String Email;
  final String nohospital;
  final Size size;
  final String imageurl;
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
                width: size.width - 30,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              side: BorderSide.none,
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green,
                            ),
                            onPressed: () async {},
                            child: const Icon(
                              Icons.phone,
                              size: 20,
                            )),
                        const SizedBox(width: 25),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              side: BorderSide.none,
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () async {},
                            child: const Icon(
                              Icons.email,
                              size: 20,
                            )),
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
