import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          child: Padding(
        padding: const EdgeInsets.only(
            left: 16.0, right: 16.0, top: 48.0, bottom: 24),
        child: (ListView(
          children: [
            Container(
              height: 150,
              decoration: new BoxDecoration(
                  color: Colors.lightGreenAccent,
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Welcome",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.green[900]),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                "To",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.green[900]),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                "E - Library",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.green[900]),
                              )
                            ],
                          )
                        ],
                      ),
                      Image(
                        image: AssetImage('assets/images/logo_small.png'),
                        height: 100,
                        width: 100,
                      )
                    ],
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "RECENTLY UPLOADED",
              style:
                  TextStyle(fontSize: 20, color: Colors.grey, letterSpacing: 2),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 120.0,
                    color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/images/logo_small.png'),
                          height: 105,
                          width: 105,
                        ),
                        SizedBox(height: 10),
                        Text('Title')
                      ],
                    ),
                  ),
                  Container(
                    width: 120.0,
                    color: Colors.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/images/logo_small.png'),
                          height: 105,
                          width: 105,
                        ),
                        SizedBox(height: 10),
                        Text('Title')
                      ],
                    ),
                  ),
                  Container(
                    width: 120.0,
                    color: Colors.green,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/images/logo_small.png'),
                          height: 105,
                          width: 105,
                        ),
                        SizedBox(height: 10),
                        Text('Title')
                      ],
                    ),
                  ),
                  Container(
                    width: 120.0,
                    color: Colors.yellow,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/images/logo_small.png'),
                          height: 105,
                          width: 105,
                        ),
                        SizedBox(height: 10),
                        Text('Title')
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "MOST DOWNLOADED",
              style:
                  TextStyle(fontSize: 20, color: Colors.grey, letterSpacing: 2),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 120.0,
                    color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/images/logo_small.png'),
                          height: 105,
                          width: 105,
                        ),
                        SizedBox(height: 10),
                        Text('Title')
                      ],
                    ),
                  ),
                  Container(
                    width: 120.0,
                    color: Colors.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/images/logo_small.png'),
                          height: 105,
                          width: 105,
                        ),
                        SizedBox(height: 10),
                        Text('Title')
                      ],
                    ),
                  ),
                  Container(
                    width: 120.0,
                    color: Colors.green,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/images/logo_small.png'),
                          height: 105,
                          width: 105,
                        ),
                        SizedBox(height: 10),
                        Text('Title')
                      ],
                    ),
                  ),
                  Container(
                    width: 120.0,
                    color: Colors.yellow,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/images/logo_small.png'),
                          height: 105,
                          width: 105,
                        ),
                        SizedBox(height: 10),
                        Text('Title')
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        )),
      )),
    );
  }
}
