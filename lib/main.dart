import 'package:carevista_ver05/SCREEN/splash.dart';
import 'package:carevista_ver05/Service/auth_service.dart';
import 'package:carevista_ver05/Shared/web.dart';
import 'package:carevista_ver05/Theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Disable screen rotation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Allow only portrait orientation
  ]);
  if (kIsWeb) {
    //Web Platfrom work this code
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: WebConstants.apiKey,
            appId: WebConstants.appId,
            messagingSenderId: WebConstants.messagingSenderId,
            projectId: WebConstants.projectId));
  } else {
    //Android or Ios Platfrom work this code
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: MyApp.themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            // Remove the debug banner
            themeMode: currentMode,
            debugShowCheckedModeBanner: false,
            title: 'Care Vista',
            theme: ThemeApp.lightTheme,
            darkTheme: ThemeApp.darkTheme,

            //themeMode: currentMode,
            home: const ScreenSplash(),
          );
        });
  }
}
