import 'package:carevista_ver05/Administration/adminuploadhospital.dart';
import 'package:carevista_ver05/Service/auth_service.dart';
import 'package:carevista_ver05/main.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class ADDorREMOVEAdmin extends StatefulWidget {
  ADDorREMOVEAdmin({required this.email, super.key});
  String email;
  @override
  State<ADDorREMOVEAdmin> createState() => _ADDorREMOVEAdminState();
}

final fromKey = GlobalKey<FormState>();
TextEditingController _searchController = TextEditingController();
String _searchQuery = '';
String password = '';
bool passVisible = false;
bool _isLoding = false;
AuthService authService = AuthService();

class _ADDorREMOVEAdminState extends State<ADDorREMOVEAdmin> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController = TextEditingController();
    _isLoding = false;
  }

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
              extendBody: true,
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
                            List<DocumentSnapshot> adminkeyTrue = users
                                .where((users) => users['AdKey'] == 'true')
                                .toList();
                            List<DocumentSnapshot> adminkeyFalse = users
                                .where((users) => users['AdKey'] == 'false')
                                .toList();

                            List<DocumentSnapshot> sortedHospitals = [
                              ...adminkeyTrue,
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
                                      return Text(
                                          'Error: ${countSnapshot.error}');
                                    }
                                    int nohospital = countSnapshot.data ?? 0;

                                    return Row(
                                      children: [
                                        UserListWidget(
                                          Adkey: data['AdKey'],
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
                                                  name: data['fullName']),
                                            );
                                          },
                                          btnPress: () async {
                                            adkey(
                                                data['fullName'],
                                                data['AdKey'],
                                                data['phoneNo'],
                                                widget.email);
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

  adkey(
      String username, String userAdkey, String userphone, String adminemail) {
    print('object');
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: userAdkey == 'true'
              ? const Text("Remove Admin")
              : const Text("Add Admin"),
          content: userAdkey == 'true'
              ? Text("Are you to remove $username to Admin?")
              : Text("Are you to add $username to Admin?"),
          actions: [
            const SizedBox(height: 3),
            Form(
              key: fromKey,
              child: TextFormField(
                obscureText: passVisible ? false : true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.fingerprint_outlined),
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        passVisible =
                            !passVisible; // Toggle the value of passVisible
                      });
                    },
                    icon: passVisible
                        ? const Icon(LineAwesomeIcons.eye)
                        : const Icon(LineAwesomeIcons.eye_slash),
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
                    if (fromKey.currentState!.validate()) {
                      setState(() {
                        _isLoding = true;
                      });
                      await authService
                          .loginUserAccount(widget.email, password)
                          .then((value) async {
                        print('login');
                        if (value == true) {
                          if (userAdkey == 'false') {
                            updateAdKeyByCondition(userphone, 'true');
                            Navigator.pop(context);
                            setState(() {
                              _isLoding = false;
                              showSnackbar(context, Colors.green,
                                  '$username is add ADMIN');
                            });
                          } else {
                            updateAdKeyByCondition(userphone, 'false');
                            Navigator.pop(context);
                            setState(() {
                              _isLoding = false;
                              showSnackbar(context, Colors.green,
                                  '$username is remove ADMIN');
                            });
                          }
                        } else {
                          setState(() {
                            showSnackbar(context, Colors.red, value);
                            _isLoding = false;
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
  }

  Future<void> updateAdKeyByCondition(String userphone, String newAdKey) async {
    try {
      // Fetch the documents that match the condition (e.g. phonenumber)
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('phoneNo', isEqualTo: userphone)
          .get();

      // Update the AdKey field value for each document
      List<Future<void>> updateFutures = querySnapshot.docs.map((doc) {
        return doc.reference.update({'AdKey': newAdKey});
      }).toList();

      // Wait for all updates to complete
      await Future.wait(updateFutures);

      print('AdKey updated successfully for userphone: $userphone');
    } catch (e) {
      print('Error updating AdKey by condition: $e');
    }
  }
}

class UserListWidget extends StatelessWidget {
  const UserListWidget({
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              side: BorderSide.none,
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  Adkey == 'false' ? Colors.green : Colors.red,
                            ),
                            onPressed: btnPress,
                            child: Adkey == 'false'
                                ? const Icon(
                                    Icons.add,
                                    size: 20,
                                  )
                                : const Icon(Icons.remove, size: 20)),
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
