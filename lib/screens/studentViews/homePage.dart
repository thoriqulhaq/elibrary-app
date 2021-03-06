import 'package:elibrary_app/screens/studentViews/book_detail.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elibrary_app/screens/studentViews/searchContentScreen.dart';

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
        padding:
            const EdgeInsets.only(left: 16.0, right: 16.0, top: 16, bottom: 24),
        child: (ListView(
          children: [
            Container(
              height: 150,
              decoration: new BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.green,
                      Colors.green.shade50,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "W E L C O M E",
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "T O",
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "E - L I B R A R Y",
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
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
              height: 30,
            ),
            Text(
              "RECENTLY UPLOADED",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('contents')
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    var itemNum = snapshot.data!.docs.length;
                    if (snapshot.data!.docs.length >= 7) {
                      itemNum = 7;
                    }
                    ;
                    return Container(
                      height: 175,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: itemNum,
                          itemBuilder: ((context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (_) {
                                    return BookDetail(
                                      titleBook: snapshot.data!.docs[index]
                                          ['title'],
                                      descBook: snapshot.data!.docs[index]
                                          ['desc'],
                                      coverUrl: snapshot.data!.docs[index]
                                          ['cover'],
                                      downloadUrl: snapshot.data!.docs[index]
                                          ['url'],
                                      author: snapshot.data!.docs[index]
                                          ['author'],
                                      bookId: snapshot.data!.docs[index].id,
                                    );
                                  }));
                                },
                                child: Container(
                                    width: 120.0,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.network(
                                            snapshot.data?.docs[index]['cover'],
                                            height: 105,
                                            width: 105,
                                          ),
                                          SizedBox(height: 20),
                                          Text(
                                            snapshot.data?.docs[index]['title'],
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        ])),
                              ))),
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
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('contents')
                    .orderBy('downloadNum', descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    var itemNum = snapshot.data!.docs.length;
                    if (snapshot.data!.docs.length >= 7) {
                      itemNum = 7;
                    }
                    return Container(
                      height: 175,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: itemNum,
                          itemBuilder: ((context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (_) {
                                    return BookDetail(
                                      titleBook: snapshot.data!.docs[index]
                                          ['title'],
                                      descBook: snapshot.data!.docs[index]
                                          ['desc'],
                                      coverUrl: snapshot.data!.docs[index]
                                          ['cover'],
                                      downloadUrl: snapshot.data!.docs[index]
                                          ['url'],
                                      author: snapshot.data!.docs[index]
                                          ['author'],
                                      bookId: snapshot.data!.docs[index].id,
                                    );
                                  }));
                                },
                                child: Container(
                                    width: 120.0,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.network(
                                            snapshot.data?.docs[index]['cover'],
                                            height: 105,
                                            width: 105,
                                          ),
                                          SizedBox(height: 20),
                                          Text(
                                            snapshot.data?.docs[index]['title'],
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        ])),
                              ))),
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
          ],
        )),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => searchContentScreen()),
          );
        },
        child: const Icon(Icons.search),
        backgroundColor: Colors.green,
      ),
    );
  }
}
