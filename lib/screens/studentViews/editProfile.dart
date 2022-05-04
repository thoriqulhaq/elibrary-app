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

  var isLoading = false;
  var fullNameEmpty = false;
  var emailEmpty = false;
  var idNumberEmpty = false;

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
            .doc('Nr7U0lu3CChUlJenTpKH')
            .update({'fullname': _fullNameController.text});
      }
      if (emailEmpty == false) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc('Nr7U0lu3CChUlJenTpKH')
            .update({'email': _emailController.text});
      }
      if (idNumberEmpty == false) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc('Nr7U0lu3CChUlJenTpKH')
            .update({'idNumber': _idNumberController.text});
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
