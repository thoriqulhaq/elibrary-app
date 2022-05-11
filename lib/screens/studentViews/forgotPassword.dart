import 'package:flutter/material.dart';
import 'package:elibrary_app/screens/components/textInput.dart';
import 'package:elibrary_app/screens/components/submitButton.dart';
import 'package:firebase_auth/firebase_auth.dart';

class forgotPassword extends StatefulWidget {
  forgotPassword({Key? key}) : super(key: key);

  @override
  State<forgotPassword> createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {
  final _formKey = GlobalKey<FormState>();

  // Input Controller
  final _emailController = TextEditingController();
  

  var isLoading = false;
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

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
              Center(child: Text('Forgot Password', style: TextStyle
              (fontSize: 20.0, fontWeight: FontWeight.normal),
              ),
              ),
            ),
            const SizedBox(
              height: 15,
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
                process: _passwordReset,
              )
            ],
          ],
        ),
      ),
    );
  }
  
  

  Future _passwordReset() async {
    
    try{
      setState(() {
      isLoading = true;
    });
    await FirebaseAuth.instance
     .sendPasswordResetEmail(email: _emailController.text.trim());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Password Reset Email Sent'),
        actions: [
          FlatButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),);
  } on FirebaseAuthException catch(e) {
    print(e);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(e.message!),
        actions: [
          FlatButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),);
  }

}

}