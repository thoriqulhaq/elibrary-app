import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:elibrary_app/screens/components/textInput.dart';
import 'package:elibrary_app/screens/components/submitButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class editProfile extends StatefulWidget {
  const editProfile({Key? key}) : super(key: key);

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  final _formKey = GlobalKey<FormState>();

  // Input Controller
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // User authentication
  final user = FirebaseAuth.instance.currentUser!;

  var isLoading = false;
  var fullNameEmpty = false;
  var emailEmpty = false;
  var idNumberEmpty = false;
  var passwordRefused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, bottom: 24.0, top: 48.0),
              child: Text(
                'Edit Profile',
                style: TextStyle(fontSize: 24),
              ),
            ),
            TextInput(
              controller: _fullNameController,
              label: 'Update Fullname',
              keyboardType: TextInputType.text,
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  fullNameEmpty = true;
                }
              },
            ),
            TextInput(
              controller: _emailController,
              label: 'Update Email',
              keyboardType: TextInputType.text,
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  emailEmpty = true;
                }
              },
            ),
            TextInput(
              controller: _idNumberController,
              label: 'Update ID Number',
              keyboardType: TextInputType.text,
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  idNumberEmpty = true;
                }
              },
            ),
            TextInput(
              label: 'Password',
              controller: _passwordController,
              keyboardType: TextInputType.text,
              password: true,
            ),
            TextInput(
              label: 'Confirm Password',
              controller: _confirmPasswordController,
              keyboardType: TextInputType.text,
              password: true,
              validator: (String? value) {
                // Validate password match
                if (_passwordController.text != value) {
                  return "Password doesn't match";
                  passwordRefused = true;
                }
              },
            ),
            const SizedBox(
              height: 15,
            ),
            Text(user.email!),
            Text(user.uid),
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
                process: _updateUser,
              )
            ],
          ],
        ),
      ),
    );
  }

  Future _updateUser() async {
    setState(() {
      isLoading = true;
    });
    try {
      if (fullNameEmpty == false) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'fullname': _fullNameController.text});
      }
      if (emailEmpty == false) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'email': _emailController.text});
        try {
          await user.updateEmail(_emailController.text);
        } on FirebaseAuthException catch (e) {
          setState(() {
            _handleUpdateError(e);
            isLoading = false;
          });
        }
      }
      if (idNumberEmpty == false) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'idNumber': _idNumberController.text});
      }
      if (passwordRefused == false) {
        try {
          await user.updatePassword(_confirmPasswordController.text);
        } on FirebaseAuthException catch (e) {
          _handleUpdateError(e);
          setState(() {
            isLoading = false;
          });
        }
      }
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('User information has been updated.'),
          actions: [
            FlatButton(
              child: Text('OK'),
              //hard-code waiting login screen
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      _handleUpdateError(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  void _handleUpdateError(FirebaseAuthException e) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Profile Failed'),
        content: Text('Information update failed. Please try again.'),
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
