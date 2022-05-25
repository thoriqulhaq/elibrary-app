import 'package:elibrary_app/screens/studentViews/homePage.dart';
import 'package:elibrary_app/screens/studentViews/homeWrapperScreen.dart';
import 'package:elibrary_app/screens/universalViews/editProfile.dart';
import 'package:elibrary_app/screens/universalViews/uploadScreen.dart';
import 'package:flutter/material.dart';
import 'package:elibrary_app/screens/universalViews/forgotPassword.dart';
import 'package:elibrary_app/screens/universalViews/registerOptionScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:elibrary_app/screens/universalViews/loginScreen.dart';
import 'package:elibrary_app/screens/universalViews/editProfile.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/studentViews/searchContentScreen.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isAuth = false;

  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    ////////////////// Just for debugging mode/////////////////////
    final keys = pref.getKeys();

    final prefsMap = Map<String, dynamic>();
    for (String key in keys) {
      prefsMap[key] = pref.get(key);
    }

    print(prefsMap);
    ///////////////////////////////////////////////////////////////

    var login_status = pref.getBool('is_login');
    if (login_status != false && login_status != null) {
      if (mounted) {
        setState(() {
          isAuth = true;
        });
      }
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget view;
    if (isAuth) {
      view = HomeWrapperScreen();
    } else {
      view = loginScreen();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'e-Library',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: view,
    );
  }
}
