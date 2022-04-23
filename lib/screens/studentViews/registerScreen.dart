import 'package:flutter/material.dart';
import 'package:elibrary_app/screens/components/textInput.dart';
import 'package:elibrary_app/screens/components/button.dart';

class registerScreen extends StatefulWidget {
  registerScreen({Key? key}) : super(key: key);

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  final _formKey = GlobalKey<FormState>();

  // Input Controller
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
              label: 'First Name',
              controller: _firstNameController,
              keyboardType: TextInputType.text,
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
            TextInput(
              label: 'Last Name',
              controller: _lastNameController,
              keyboardType: TextInputType.text,
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
            TextInput(
              label: 'ID Number',
              controller: _idNumberController,
              keyboardType: TextInputType.text,
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
            TextInput(
              label: 'Confirm Password',
              controller: _confirmPasswordController,
              keyboardType: TextInputType.text,
              password: true,
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return 'This field is required';
                }

                // Validate password match
                if (_passwordController.text != value) {
                  return "Password doesn't match";
                }
              },
            ),
            const SizedBox(
              height: 15,
            ),
            SubmitButton(formKey: _formKey),
          ],
        ),
      ),
    );
  }
}
