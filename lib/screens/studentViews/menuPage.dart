import 'package:flutter/material.dart';
import 'package:elibrary_app/screens/universalViews/editProfile.dart';
import 'package:elibrary_app/screens/universalViews/uploadScreen.dart';
import 'package:elibrary_app/screens/universalViews/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class menuPage extends StatefulWidget {
  menuPage({Key? key}) : super(key: key);

  @override
  State<menuPage> createState() => _menuPageState();
}

class _menuPageState extends State<menuPage> {
  
  doLogout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // Clear the shared preferences (Logged in user's information)
    await pref.clear();

    // Redirected to login screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => loginScreen()),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(
            left: 20.0, right: 20.0, bottom: 16.0, top: 16.0),
        child: ListView(
          children: [
            ElevatedButton(
              child: Text('Edit Profile'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => editProfile()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                padding: const EdgeInsets.all(19),
                primary: Colors.green,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              child: Text('Upload Book'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => uploadScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                padding: const EdgeInsets.all(19),
                primary: Colors.green,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              child: Text('Logout'),
              onPressed: () {
                doLogout();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                padding: const EdgeInsets.all(19),
                primary: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
