import 'package:carevista_ver05/main.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class SettingSrn extends StatelessWidget {
  const SettingSrn({super.key});

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
            'Settings',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25,
                //fontFamily: 'brandon_H',
                color: Theme.of(context).primaryColorDark),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    MyApp.themeNotifier.value =
                        MyApp.themeNotifier.value == ThemeMode.light
                            ? ThemeMode.dark
                            : ThemeMode.light;
                  },
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color(0xFF00008F).withOpacity(0.2),
                    ),
                    child: Icon(MyApp.themeNotifier.value == ThemeMode.light
                        ? LineAwesomeIcons.moon
                        : LineAwesomeIcons.sun),
                  ),
                  title: Text(
                    'Dark Mode',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
