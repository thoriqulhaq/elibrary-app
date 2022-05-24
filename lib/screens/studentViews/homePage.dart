import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('contents')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: 175,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: ((context, index) => Container(
                              width: 120.0,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      snapshot.data?.docs[index]['url'],
                                      height: 105,
                                      width: 105,
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      snapshot.data?.docs[index]['title'],
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ])))),
                    );
                  } else {
                    return Container(
                      height: 175,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            width: 120.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage(
                                      'assets/images/logo_small.png'),
                                  height: 105,
                                  width: 105,
                                ),
                                SizedBox(height: 20),
                                Text('title')
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }
                }),
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
              height: 175,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 120.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/images/logo_small.png'),
                          height: 105,
                          width: 105,
                        ),
                        SizedBox(height: 20),
                        Text('Title')
                      ],
                    ),
                  ),
                  Container(
                    width: 120.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/images/logo_small.png'),
                          height: 105,
                          width: 105,
                        ),
                        SizedBox(height: 20),
                        Text('Title')
                      ],
                    ),
                  ),
                  Container(
                    width: 120.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/images/logo_small.png'),
                          height: 105,
                          width: 105,
                        ),
                        SizedBox(height: 20),
                        Text('Title')
                      ],
                    ),
                  ),
                  Container(
                    width: 120.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/images/logo_small.png'),
                          height: 105,
                          width: 105,
                        ),
                        SizedBox(height: 20),
                        Text('Title')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.search),
        backgroundColor: Colors.green,
      ),
    );
  }
}
