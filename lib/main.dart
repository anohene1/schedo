import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:schedo_final/model/auth_service.dart';
import 'package:schedo_final/model/firestore_service.dart';
import 'view/screens/screens.dart';
import 'view/themes/themes.dart';
import 'model/models.dart';

//Signed in user
User signedInUser = FirebaseAuth.instance.currentUser;

//Get Device Info
DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

double iOSVersion;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    iOSVersion = double.tryParse(iosInfo.systemVersion);
  }
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<HomeIndexedStackIndex>(create: (context) => HomeIndexedStackIndex()),
      ChangeNotifierProvider<NavigationIndexedStackIndex>(create: (context) => NavigationIndexedStackIndex()),
      ChangeNotifierProvider<Categories>(create: (context) => Categories()),
      ChangeNotifierProvider<TaskType>(create: (context) => TaskType()),
      Provider<AuthService>(create: (context) => AuthService()),
      ChangeNotifierProvider<FirestoreService>(create: (context) => FirestoreService()),
    ],
      child: MyApp(),
    )
  );
}

MyTheme currentTheme = MyTheme();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget),
        maxWidth: 1200,
        minWidth: 480,
        defaultScale: true,
        // breakpoints: [
        //   // ResponsiveBreakpoint.resize(450, name: MOBILE),
        //   // ResponsiveBreakpoint.autoScale(800, name: TABLET),
        //   ResponsiveBreakpoint.autoScale(1000, name: TABLET),
        //   ResponsiveBreakpoint.resize(1200, name: DESKTOP),
        //   ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        // ],
      ),
      // theme: currentTheme.currentTheme(),
      theme: lightTheme(),
      darkTheme: darkTheme(),
      // home: OnboardingScreen(),
      home: signedInUser == null ? OnboardingScreen(iOSVersion: iOSVersion,) : Navigation(),
    );
  }
}
