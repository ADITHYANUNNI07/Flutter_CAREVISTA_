import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:carevista_ver05/SCREEN/editprofile.dart';
import 'package:carevista_ver05/Service/database_service.dart';
import 'package:carevista_ver05/main.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:carevista_ver05/SCREEN/addons/color.dart' as specialcolor;
import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class FeedBack extends StatefulWidget {
  const FeedBack(
      {super.key,
      required this.email,
      required this.phone,
      required this.name,
      required this.imageUrl,
      required this.adkey,
      required this.uid});
  final String uid;
  final String email;
  final String phone;
  final String name;
  final String imageUrl;
  final String adkey;

  @override
  State<FeedBack> createState() => _FeedBackState();
}

final formKey = GlobalKey<FormState>();
int feedbackRating = 0;
String suggestion = '';

class _FeedBackState extends State<FeedBack> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    feedbackRating = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF04FBC3),
      child: SafeArea(
          child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Give feedback',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                        width: 40,
                        height: 40,
                        child: CircleAvatar(
                          backgroundImage: widget.imageUrl == ''
                              ? const AssetImage(
                                  'Assets/images/profile-user.jpg')
                              : Image.network(
                                  widget.imageUrl,
                                ).image,
                        )),
                  ],
                ),
              ),
              Image.asset(
                'Assets/images/Feedback-amico.png',
                width: 260,
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  height: 420,
                  decoration: BoxDecoration(
                      color: MyApp.themeNotifier.value == ThemeMode.light
                          ? Colors.white
                          : Theme.of(context).cardColor,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(5, 10),
                          blurRadius: 28,
                          color: MyApp.themeNotifier.value == ThemeMode.light
                              ? specialcolor.AppColor.gradientSecond
                                  .withOpacity(0.5)
                              : Colors.black87,
                        )
                      ]),
                  padding: const EdgeInsets.only(
                      top: 9, left: 5, right: 5, bottom: 9),
                  child: Column(
                    children: [
                      EmojiFeedback(
                        animDuration: const Duration(milliseconds: 300),
                        curve: Curves.bounceIn,
                        inactiveElementScale: .5,
                        onChanged: (value) {
                          setState(() {
                            feedbackRating = value;
                          });
                          print(feedbackRating);
                        },
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Tell us what can improved ?',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 5),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              maxLines: 10,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(LineAwesomeIcons.accusoft),
                                labelText: 'Suggestion',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                suggestion = value;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your Suggestion';
                                } else if (value.length <= 6) {
                                  return 'invalid your Suggestion';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      side: BorderSide.none,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 13),
                                      foregroundColor: Colors.white,
                                      backgroundColor: specialcolor
                                          .AppColor.gradientSecond
                                          .withOpacity(0.9)),
                                  onPressed: () {
                                    feedback();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.send_outlined),
                                      SizedBox(width: 9),
                                      Text('SEND FEEDBACK'),
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  feedback() async {
    if (formKey.currentState!.validate()) {
      if (feedbackRating == 0) {
        newshowSnackbar(context, 'feedbackRating Emoji',
            'Please select feedback rating bar', ContentType.failure);
      } else {
        await DatabaseServiceFeedback().feedback(
            widget.uid,
            widget.name,
            widget.phone,
            widget.email,
            widget.adkey,
            feedbackRating,
            suggestion,
            widget.imageUrl);
        // ignore: use_build_context_synchronously
        newshowSnackbar(context, 'Feedback', 'Thank you for your feedback',
            ContentType.success);
        Navigator.pop(context);
      }
    }
  }
}
