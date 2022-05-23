import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:elibrary_app/screens/components/textInput.dart';
import 'package:elibrary_app/screens/components/submitButton.dart';
import 'package:elibrary_app/screens/universalViews/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:firebase_core/firebase_core.dart';


class uploadScreen extends StatefulWidget {
  uploadScreen({Key? key}) : super(key: key);

  @override
  State<uploadScreen> createState() => _uploadScreenState();
}

class _uploadScreenState extends State<uploadScreen> {

  final _formKey = GlobalKey<FormState>();
  UploadTask? task;
  File? file;
  // Input Controller
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _publisherController = TextEditingController();
   final _categoryController = TextEditingController();
  final _dopController = TextEditingController();
  final _popController = TextEditingController();
  final _descController = TextEditingController();
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
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: 
              Center(child: Text('Reset Password', style: TextStyle
              (fontSize: 20.0, fontWeight: FontWeight.normal),
              ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextInput(
              label: 'Book Title',
              controller: _titleController,
              keyboardType: TextInputType.text,
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
           TextInput(
              label: 'Author',
              controller: _authorController,
              keyboardType: TextInputType.text,
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
            TextInput(
              label: 'Publisher',
              controller: _publisherController,
              keyboardType: TextInputType.text,
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
            TextInput(
              label: 'Category',
              controller: _categoryController,
              keyboardType: TextInputType.text,
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
           TextInput(
              label: 'Date of Publication',
              controller: _dopController,
              keyboardType: TextInputType.text,
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
            TextInput(
              label: 'Place of Publication',
              controller: _popController,
              keyboardType: TextInputType.text,
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
            TextInput(
              label: 'Description',
              controller: _descController,
              keyboardType: TextInputType.text,
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return 'This field is required';
                }
                return null;
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
              Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState != null &&
              _formKey.currentState!.validate()) {
            _selectContent();
          }
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          padding: const EdgeInsets.all(19),
          primary: Colors.green,
        ),
        child: Text(
          'Select File',
          style: TextStyle(color: Colors.white),
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
              Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState != null &&
              _formKey.currentState!.validate()) {
            _uploadContent();
          }
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          padding: const EdgeInsets.all(19),
          primary: Colors.green,
        ),
        child: Text(
          'Upload File',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
            ],
          ],],
        ),
      ),
    );
  }

  Future _selectContent() async{

    final result = await FilePicker.platform.pickFiles();

    if (result == null) return;

    final path = result.files.first.path!;

    setState(() => file = File(path));
    
  }

   Future _uploadContent() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'contents/$fileName';

    task = FirebaseApi.uploadContent(destination, file!);

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    try {
      
      await FirebaseFirestore.instance
          .collection('contents')
          .add({
        'title': _titleController.text,
        'author': _authorController.text,
        'publisher': _publisherController.text,
        'category': _categoryController.text,
        'dop': _dopController.text,
        'pop': _popController.text,
        'desc': _descController.text,
        'url': urlDownload,
        'createdAt': DateTime.now(),
      });


}on FirebaseAuthException catch (e) {
      // _handleSignUpError(e);
      setState(() {
        isLoading = false;
      });
    }
  }









}

class FirebaseApi{
  static UploadTask? uploadContent(String destination, File file) {
    try{
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e){
      return null;
    }
  }
}