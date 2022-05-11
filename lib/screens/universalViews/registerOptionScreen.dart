import 'package:flutter/material.dart';
import 'package:elibrary_app/screens/components/defaultButton.dart';
import 'package:elibrary_app/screens/studentViews/registerScreen.dart'
    as studentScreen;
import 'package:elibrary_app/screens/lecturerViews/registerScreen.dart'
    as lecturerScreen;

class registerOptionScreen extends StatefulWidget {
  registerOptionScreen({Key? key}) : super(key: key);

  @override
  State<registerOptionScreen> createState() => _registerOptionScreenState();
}

class _registerOptionScreenState extends State<registerOptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 24.0),
              child: Image(
                image: AssetImage('assets/images/logo_main.png'),
              ),
            ),
          ),
          SizedBox(height: 16),
          Center(
            child: Text('Sign Up as',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 48),
          DefaultButton(
              label: 'Student', onPressed: studentScreen.registerScreen()),
          SizedBox(height: 16),
          DefaultButton(
              label: 'Lecture', onPressed: lecturerScreen.registerScreen()),
        ],
      ),
    );
  }
}
