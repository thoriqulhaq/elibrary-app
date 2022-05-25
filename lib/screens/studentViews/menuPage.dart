import 'package:flutter/material.dart';
import 'package:elibrary_app/screens/universalViews/editProfile.dart';
import 'package:elibrary_app/screens/universalViews/uploadScreen.dart';

class menuPage extends StatefulWidget {
  menuPage({Key? key}) : super(key: key);

  @override
  State<menuPage> createState() => _menuPageState();
}

class _menuPageState extends State<menuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text('Edit Profile'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => editProfile()),
                );
              },
            ),
            RaisedButton(
              child: Text('Upload Book'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => uploadScreen()),
                );
              },
            ),
            RaisedButton(
              child: Text('Logout'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
