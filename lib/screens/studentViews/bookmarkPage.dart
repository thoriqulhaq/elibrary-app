import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:elibrary_app/screens/studentViews/book_detail.dart';

class bookmarkPage extends StatefulWidget {
  const bookmarkPage({Key? key}) : super(key: key);

  @override
  State<bookmarkPage> createState() => _bookmarkPageState();
}

final user = FirebaseAuth.instance.currentUser!;

class _bookmarkPageState extends State<bookmarkPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 1.5;
    final double itemWidth = size.width / 2;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 16),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/bm.png',
                  width: 35,
                ),
                Text(
                  "Bookmarks",
                  style: TextStyle(fontSize: 24),
                )
              ],
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(user.uid)
                    .collection("bookmarks")
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text("Bookmark list is empty."),
                    );
                  } else {
                    return Expanded(
                      child: GridView.builder(
                          itemCount: snapshot.data!.docs.length,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: (itemWidth / itemHeight),
                                  maxCrossAxisExtent: 150),
                          itemBuilder: ((context, index) => Container(
                              color: Colors.white,
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("contents")
                                    .doc(snapshot.data!.docs[index]["bid"])
                                    .snapshots(),
                                builder: (context, AsyncSnapshot snapshot2) {
                                  if (!snapshot2.hasData) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (_) {
                                          return BookDetail(
                                            titleBook: snapshot2.data['title'],
                                            descBook: snapshot2.data['desc'],
                                            coverUrl: snapshot2.data['cover'],
                                            downloadUrl: snapshot2.data['url'],
                                            author: snapshot2.data['author'],
                                            bookId:
                                                snapshot.data!.docs[index].id,
                                          );
                                        }));
                                      },
                                      child: Container(
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                            Container(
                                              child: Image.network(
                                                snapshot2.data['cover'],
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            Text(
                                              snapshot2.data['title'],
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          ])),
                                    );
                                  }
                                },
                              )))),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}

/* 
                                    return ListView.builder(
                                        itemBuilder: (context, index2) =>
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (_) {
                                                  return BookDetail(
                                                    titleBook: snapshot2
                                                        .data['title'],
                                                    descBook: snapshot2.data!
                                                        .docs[index2]['desc'],
                                                    coverUrl: snapshot2.data!
                                                        .docs[index2]['cover'],
                                                  );
                                                }));
                                              },
                                              child: Container(
                                                  width: 120.0,
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.network(
                                                          snapshot2.data
                                                                  ?.docs[index]
                                                              ['cover'],
                                                          height: 105,
                                                          width: 105,
                                                        ),
                                                        SizedBox(height: 20),
                                                        Text(
                                                          snapshot2.data
                                                                  ?.docs[index]
                                                              ['title'],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        )
                                                      ])),
                                            ));*/

/*StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(user.uid)
                    .collection("bookmarks")
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text("Bookmark list is empty."),
                    );
                  } else {
                    return Container(
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 150),
                          itemBuilder: ((context, index) => GestureDetector(
                                child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("contents")
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {},
                                ),
                              ))),
                    );
                  }
                })
                 */

/*
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
*/