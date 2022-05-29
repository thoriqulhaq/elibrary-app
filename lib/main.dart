import 'package:elibrary_app/screens/studentViews/homePage.dart';
import 'package:elibrary_app/screens/studentViews/homeWrapperScreen.dart'
    as student;
import 'package:elibrary_app/screens/lecturerViews/homeWrapperScreen.dart'
    as lecturer;
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
import 'package:elibrary_app/screens/studentViews/searchContentScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elibrary_app/screens/lecturerViews/contentList.dart';

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
  bool isStudent = false;

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
      var email = pref.getString('name');
      FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get()
          .then((value) => {
                if (mounted)
                  {
                    setState(() {
                      isAuth = true;
                      value.docs[0]['userType'] == 'student'
                          ? isStudent = true
                          : isStudent = false;
                    })
                  }
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget view;
    if (isAuth) {
      if (isStudent) {
        view = student.HomeWrapperScreen();
      } else {
        view = contentList();
      }
    } else {
      view = loginScreen();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'e-Library',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: view,
    );
  }
}
