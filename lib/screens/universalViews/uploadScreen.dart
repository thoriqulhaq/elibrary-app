import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:intl/intl.dart';
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
  UploadTask? task2;
  File? file;
  File? coverFile;
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
    final fileName = file != null ? basename(file!.path) : 'No file selected';
    final coverFileName = coverFile != null ? basename(coverFile!.path) : 'No file selected';

     return Scaffold(
      backgroundColor: Colors.white,
      body: Form( 
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: 
              Center(child: Text('Upload Content', style: TextStyle
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
            Container(   margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 24.0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.8),borderRadius: BorderRadius.circular(15.0),
                    ),
                    
              child: Padding(padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 0.0),
             child: Center(child: TextField(
              controller: _dopController, //editing controller of this TextField
                decoration: InputDecoration(  
                  border: InputBorder.none,
                   icon: Icon(Icons.calendar_today), //icon of text field
                   labelText: "Date of Publication" //label text of field
                ),
                readOnly: true,  //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );
                  
                  if(pickedDate != null ){
                      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 
                      print(formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                         _dopController.text = formattedDate; //set output date to TextField value. 
                      });
                  }else{
                      print("Date is not selected");
                  }
                },
            ),),),),
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
            _selectCover();
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
          'Select Cover Image',
          style: TextStyle(color: Colors.white),
        ),
      ),
    
    ),
    Center(child: Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 30.0),
      child: Text(coverFileName, style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),),),

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
    Center(child: Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 24.0),
      child: Text(fileName, style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),),),

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
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 24.0),
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

    SizedBox(height: 20),
    task != null ? buildUploadStatus(task!) : Container(),
             ],
          ],],
        ),
      ),
    );
  }

  Future _selectContent() async{

    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf'], allowMultiple: false);

    if (result == null) return;

    final path = result.files.first.path!;

    setState(() => file = File(path));
    
  }

  Future _selectCover() async{

    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['jpeg', 'jpg', 'png', 'gif'], allowMultiple: false);

    if (result == null) return;

    final path = result.files.first.path!;

    setState(() => coverFile = File(path));
    
  }

   Future _uploadContent() async {
    if (file == null) return;
    if (coverFile == null) return;

    final fileName = basename(file!.path);
    final destination = 'contents/$fileName';

     final coverFileName = basename(coverFile!.path);
    final coverDestination = 'contents/$coverFileName';

    task = FirebaseApi.uploadContent(destination, file!);
    task2 = FirebaseApi.uploadContent(coverDestination, coverFile!);
    setState(() {
      
    });
    if (task == null) return;
    if (task2 == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    final snapshot2 = await task2!.whenComplete(() {});
    final urlDownload2 = await snapshot2.ref.getDownloadURL();
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
        'cover': urlDownload2,
        'downloadNum': 0,
        'createdAt': DateTime.now(),
      });


}on FirebaseAuthException catch (e) {
      // _handleSignUpError(e);
      setState(() {
        isLoading = false;
      });
    }
  }

Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
  stream: task.snapshotEvents,
  builder: (context, snapshot){
    if(snapshot.hasData){
      final snap = snapshot.data!;
      final progress = snap.bytesTransferred / snap.totalBytes;
      final percentage = (progress * 100).toStringAsFixed(2);

      return Center( child: Text(
        '$percentage %',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Raleway')
      ));
    } else{
      return Container();
    }
  }
);
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

  static UploadTask? uploadBytes(String destination, Uint8List data) {
    try{
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException catch (e){
      return null;
    }
  }
}



