import 'package:elibrary_app/screens/studentViews/registerScreen.dart';
import 'package:flutter/material.dart';
import 'package:elibrary_app/screens/universalViews/registerOptionScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:elibrary_app/screens/components/textInput.dart';
import 'package:elibrary_app/screens/components/submitButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:elibrary_app/screens/universalViews/forgotPassword.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elibrary_app/screens/universalViews/editProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginScreen extends StatefulWidget {
  loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final _formKey = GlobalKey<FormState>();

  // Input Controller
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 24.0),
                child: Image(
                  image: AssetImage('assets/images/logo_main.png'),
                ),
              ),
            ),
            TextInput(
              label: 'Email',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
            TextInput(
              label: 'Password',
              controller: _passwordController,
              keyboardType: TextInputType.text,
              password: true,
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
           Center( child:  RichText(
      text: TextSpan(
        text: 'Forgot Password?',
        style: TextStyle( 
          
          color: Color.fromARGB(255, 0, 102, 255), fontSize: 20.0,
          decoration: TextDecoration.underline,
        ),
        recognizer: TapGestureRecognizer()
                ..onTap = () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => forgotPassword()),
                )
      ),
      ),
    ),
            const SizedBox(
              height: 15,
            ),
    Center( child:  RichText(
      text: TextSpan(
        text: 'Didn\'t have an account?',
        style: TextStyle( 
          
          color: Color.fromARGB(255, 0, 102, 255), fontSize: 20.0,
          decoration: TextDecoration.underline,
        ),
        recognizer: TapGestureRecognizer()
                ..onTap = () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => registerOptionScreen()),
                )
      ),
      ),
    ),
            const SizedBox(
              height: 15,
            ),
            if (isLoading) ...[
              const SizedBox(
                height: 10,
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
            ] else ...[
              SubmitButton(
                formKey: _formKey,
                process: _registerUser,
              )
            ],
          ],
        ),
      ),
    );
  }

  Future _registerUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      pref.setString("name", _emailController.text);
      pref.setBool("is_login", true);

      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('User successfully logged in'),
          actions: [
            FlatButton(
              child: Text('OK'),
              //hard-code waiting login screen
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => editProfile()),
                );
              },
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      _handleSignUpError(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  void _handleSignUpError(FirebaseAuthException e) {
    String messageToDisplay;
    switch (e.code) {
      default: // Default to general error message
        messageToDisplay = 'Wrong Password or Email';
        break;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Login Failed'),
        content: Text(messageToDisplay),
        actions: [
          FlatButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
