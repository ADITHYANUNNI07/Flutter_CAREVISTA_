import 'package:carevista_ver05/SCREEN/editprofile.dart';
import 'package:carevista_ver05/SCREEN/login.dart';
import 'package:carevista_ver05/SCREEN/profile/additionaldetail.dart';
import 'package:carevista_ver05/SCREEN/profile/medicalrecord.dart';
import 'package:carevista_ver05/SCREEN/profile/settingsnofifavorites.dart';
import 'package:carevista_ver05/Service/auth_service.dart';
import 'package:carevista_ver05/main.dart';
import 'package:carevista_ver05/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  String userName;
  String email;
  String phoneNo;
  ProfilePage({
    Key? key,
    required this.phoneNo,
    required this.email,
    required this.userName,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
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
              'Profile',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'brandon_H',
                  color: Theme.of(context).primaryColorDark),
            ),
            actions: [
              IconButton(
                  icon: Icon(MyApp.themeNotifier.value == ThemeMode.light
                      ? LineAwesomeIcons.moon
                      : LineAwesomeIcons.sun),
                  onPressed: () {
                    MyApp.themeNotifier.value =
                        MyApp.themeNotifier.value == ThemeMode.light
                            ? ThemeMode.dark
                            : ThemeMode.light;
                  })
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: 150,
                        height: 150,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child:
                                Image.asset('Assets/images/profile-user.jpg')),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 10,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Theme.of(context).backgroundColor),
                            child: const Icon(
                              LineAwesomeIcons.alternate_pencil,
                              color: Colors.white,
                            ),
                          ))
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.userName,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    widget.email,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        nextScreen(
                            context,
                            EditProfile(
                                phoneNo: widget.phoneNo,
                                email: widget.email,
                                userName: widget.userName));
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          foregroundColor: Colors.white,
                          backgroundColor: Theme.of(context).backgroundColor,
                          side: BorderSide.none,
                          shape: const StadiumBorder()),
                      child: const Text('Edit Profile'),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Divider(),
                  const SizedBox(height: 5),
                  ProfileMenuWidget(
                    title: "Settings",
                    icon: LineAwesomeIcons.cog,
                    onPress: () {
                      nextScreen(context, const SettingSrn());
                    },
                  ),
                  ProfileMenuWidget(
                      title: "Additional Details",
                      icon: LineAwesomeIcons.newspaper,
                      onPress: () {
                        nextScreen(context, const AdditionalDetails());
                      }),
                  ProfileMenuWidget(
                      title: "Medical Records",
                      icon: Icons.medical_information_outlined,
                      onPress: () {
                        nextScreen(context, const MedicalRecordSrn());
                      }),
                  ProfileMenuWidget(
                      title: "Notifications",
                      icon: Icons.notifications_active_outlined,
                      onPress: () {
                        nextScreen(context, const NotificationSrn());
                      }),
                  ProfileMenuWidget(
                      title: "Favorites",
                      icon: Icons.star_border_rounded,
                      onPress: () {
                        nextScreen(context, const FavoriterSrn());
                      }),
                  const Divider(),
                  ProfileMenuWidget(
                    title: "Logout",
                    endIcon: false,
                    icon: LineAwesomeIcons.alternate_sign_out,
                    textColor: Colors.red,
                    onPress: () async {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Logout"),
                              content: const Text(
                                  "Are you sure you want to logout?"),
                              actions: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    authService.signOut().whenComplete(
                                          () => {
                                            nextScreenReplace(
                                                context, LoginScreen())
                                          },
                                        );
                                  },
                                  icon: const Icon(
                                    Icons.done,
                                    color: Colors.green,
                                  ),
                                )
                              ],
                            );
                          });
                    },
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

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color(0xFF00008F).withOpacity(0.2),
        ),
        child: Icon(icon),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1?.apply(color: textColor),
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
