import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:carevista_ver05/SCREEN/addons/color.dart' as specialcolor;

class FeedbackView extends StatefulWidget {
  const FeedbackView(
      {super.key, required this.adkey, required this.centertitle});
  final String adkey;
  final String centertitle;
  @override
  State<FeedbackView> createState() => _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView> {
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
              widget.centertitle,
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
                  SizedBox(
                    height: size.height,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Feedback')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                              child: Lottie.asset(
                                  'animation/96949-loading-animation.json',
                                  height: 100));
                        }
                        List<DocumentSnapshot> feedback = snapshot.data!.docs;
                        List<DocumentSnapshot> adminkeyFalse = feedback
                            .where(
                                (feedback) => feedback['adKey'] == widget.adkey)
                            .toList();

                        List<DocumentSnapshot> users = [
                          ...adminkeyFalse,
                        ];
                        return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: users.length,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot Feedback = users[index];

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

                                return Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 15,
                                              right: 10,
                                              top: 10,
                                              bottom: 10),
                                          width: size.width - 30,
                                          height: (65 +
                                                  30 +
                                                  ((Feedback['suggestion']
                                                              .length
                                                              .toDouble() /
                                                          50) *
                                                      17) +
                                                  20)
                                              .toDouble(),
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: [
                                                    specialcolor
                                                        .AppColor.gradientFirst
                                                        .withOpacity(0.9),
                                                    specialcolor
                                                        .AppColor.gradientSecond
                                                        .withOpacity(0.9)
                                                  ],
                                                  begin: Alignment.bottomLeft,
                                                  end: Alignment.centerRight),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(1),
                                                      bottomRight:
                                                          Radius.circular(50),
                                                      topLeft:
                                                          Radius.circular(50),
                                                      topRight:
                                                          Radius.circular(50))),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  const SizedBox(width: 5),
                                                  SizedBox(
                                                    width: 30,
                                                    height: 30,
                                                    child: CircleAvatar(
                                                      backgroundImage: Feedback[
                                                                  'imageUrl'] ==
                                                              ''
                                                          ? const AssetImage(
                                                              'Assets/images/profile-user.jpg')
                                                          : Image.network(
                                                                  Feedback[
                                                                      'imageUrl'])
                                                              .image,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        Feedback['username'],
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w200),
                                                      ),
                                                      Text(
                                                        Feedback['email'],
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w200),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                Feedback['suggestion'],
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(child: Container()),
                                                  Feedback['rating'] == 1
                                                      ? const Text(
                                                          '😖',
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                        )
                                                      : Feedback['rating'] == 2
                                                          ? const Text(
                                                              '😞',
                                                              style: TextStyle(
                                                                  fontSize: 20),
                                                            )
                                                          : Feedback['rating'] ==
                                                                  3
                                                              ? const Text(
                                                                  '😊',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20),
                                                                )
                                                              : Feedback['rating'] ==
                                                                      4
                                                                  ? const Text(
                                                                      '😄',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20),
                                                                    )
                                                                  : Feedback['rating'] ==
                                                                          5
                                                                      ? const Text(
                                                                          '🤩',
                                                                          style:
                                                                              TextStyle(fontSize: 20),
                                                                        )
                                                                      : const SizedBox(),
                                                  const SizedBox(width: 20)
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
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
}
