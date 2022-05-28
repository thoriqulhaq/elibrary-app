import 'package:flutter/material.dart';

class HomeWrapperScreen extends StatefulWidget {
  HomeWrapperScreen({Key? key}) : super(key: key);

  @override
  State<HomeWrapperScreen> createState() => _HomeWrapperScreenState();
}

class _HomeWrapperScreenState extends State<HomeWrapperScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Maaf Lecture Belum Dibikin'),
      ),
    );
  }
}
