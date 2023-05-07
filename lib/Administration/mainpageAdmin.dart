import 'package:carevista_ver05/Administration/addorremoveadmin.dart';
import 'package:carevista_ver05/Administration/admininformation.dart';
import 'package:carevista_ver05/Administration/approveuserhospital.dart';
import 'package:carevista_ver05/Administration/feedbackview.dart';
import 'package:carevista_ver05/Administration/hospitalinfo.dart';
import 'package:carevista_ver05/Administration/userinfo.dart';
import 'package:carevista_ver05/Helper/helper_function.dart';
import 'package:carevista_ver05/admin/userhospitalverification.dart';
import 'package:carevista_ver05/main.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({super.key});

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

String imageUrl = '';
String email = '';

class _AdminMainPageState extends State<AdminMainPage> {
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

  bool endIcon = true;
  Widget build(BuildContext context) {
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
                            color: Color.fromARGB(255, 4, 208, 160),
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
                    ListWidget(
                      title: 'Admin Information',
                      subtitle: '',
                      icon: Icons.admin_panel_settings,
                      endIcon: endIcon,
                      onPress: () {
                        nextScreen(context, const AdminInfromation());
                      },
                    ),
                    const SizedBox(height: 5),
                    const Divider(),
                    const SizedBox(height: 10),
                    ListWidget(
                      title: 'Add/Remove Admin',
                      subtitle: '',
                      icon: Icons.add_moderator,
                      endIcon: endIcon,
                      onPress: () {
                        nextScreen(context, ADDorREMOVEAdmin(email: email));
                      },
                    ),
                    const SizedBox(height: 5),
                    const Divider(),
                    const SizedBox(height: 10),
                    ListWidget(
                      title: 'User Information',
                      subtitle: '',
                      icon: Icons.supervised_user_circle_sharp,
                      endIcon: endIcon,
                      onPress: () {
                        nextScreen(context, const UserInfo());
                      },
                    ),
                    const SizedBox(height: 5),
                    const Divider(),
                    const SizedBox(height: 10),
                    ListWidget(
                      title: 'Hospital Information',
                      subtitle: '',
                      icon: Icons.medical_information,
                      endIcon: endIcon,
                      onPress: () {
                        nextScreen(
                            context,
                            HospitalInfo(
                              email: email,
                            ));
                      },
                    ),
                    const SizedBox(height: 5),
                    const Divider(),
                    const SizedBox(height: 10),
                    ListWidget(
                      title: 'Hospital Verification',
                      subtitle: '',
                      icon: LineAwesomeIcons.horizontal_ellipsis,
                      endIcon: endIcon,
                      onPress: () {
                        nextScreen(
                            context,
                            UserHospitalVerifation(
                              email: email,
                            ));
                      },
                    ),
                    const SizedBox(height: 5),
                    const Divider(),
                    const SizedBox(height: 10),
                    ListWidget(
                      title: 'Approve Hospital',
                      subtitle: '',
                      icon: Icons.verified_sharp,
                      endIcon: endIcon,
                      onPress: () {
                        nextScreen(
                            context,
                            UserHospitalApprove(
                              email: email,
                            ));
                      },
                    ),
                    const SizedBox(height: 5),
                    const Divider(),
                    const SizedBox(height: 10),
                    ListWidget(
                      title: 'User Feedback',
                      subtitle: '',
                      icon: Icons.feedback,
                      endIcon: endIcon,
                      onPress: () {
                        nextScreen(
                            context,
                            const FeedbackView(
                              adkey: 'false',
                              centertitle: 'User Feedback',
                            ));
                      },
                    ),
                    const SizedBox(height: 5),
                    const Divider(),
                    const SizedBox(height: 10),
                    ListWidget(
                      title: 'Admin Feedback',
                      subtitle: '',
                      icon: Icons.feedback,
                      endIcon: endIcon,
                      onPress: () {
                        nextScreen(
                            context,
                            const FeedbackView(
                              adkey: 'true',
                              centertitle: 'Admin Feedback',
                            ));
                      },
                    ),
                    const SizedBox(height: 5),
                    const Divider(),
                    const SizedBox(height: 10),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}

class ListWidget extends StatelessWidget {
  const ListWidget({
    super.key,
    required this.endIcon,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onPress,
  });
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color(0xFF00008F).withOpacity(0.2),
        ),
        child: Icon(icon),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText1?.apply(),
          ),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
                fontSize: 10,
                color: MyApp.themeNotifier.value == ThemeMode.light
                    ? Colors.black54
                    : Colors.white54),
          ),
        ],
      ),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey.withOpacity(0.1)),
              child: const Icon(
                LineAwesomeIcons.angle_right,
                size: 18,
              ),
            )
          : null,
    );
  }
}
