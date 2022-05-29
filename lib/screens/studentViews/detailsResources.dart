import 'package:flutter/material.dart';

class detailsResources extends StatefulWidget {
  detailsResources({Key? key}) : super(key: key);

  @override
  State<detailsResources> createState() => _detailsResourcesState();
}

class _detailsResourcesState extends State<detailsResources> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Detail Resources '),
          centerTitle: true,
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(90.0),
                width: 360,
                height: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.yellow,
                        blurRadius: 4.0,
                        spreadRadius: 2.0,
                      )
                    ],
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Colors.blue, Colors.lightBlue])),
                child: Text(
                  "Description",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
          ],
        ));
    return Container(
        height: 150,
        child: Image(
          image: AssetImage('assets/images/logo_main.png'),
        ));
  }
}
