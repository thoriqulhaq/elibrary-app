import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class BookDetail extends StatefulWidget {
  BookDetail(
      {Key? key,
      required this.titleBook,
      required this.descBook,
      required this.bookId,
      required this.coverUrl})
      : super(key: key);
  final String titleBook;
  final String descBook;
  final String coverUrl;
  final String bookId;

  @override
  State<BookDetail> createState() => _BookDetailState();
}

final user = FirebaseAuth.instance.currentUser!;

class _BookDetailState extends State<BookDetail> {
  bool isBookmark = false;

  void initState() {
    checkBookmark();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.titleBook,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  if (isBookmark == false) ...[
                    IconButton(
                      icon: Icon(Icons.bookmark_outline),
                      onPressed: () {
                        addBookmark();
                      },
                    ),
                  ] else ...[
                    IconButton(
                      icon: Icon(Icons.bookmark),
                      onPressed: () {
                        removeBookmark();
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
          SizedBox(height: 25),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                widget.coverUrl,
                width: MediaQuery.of(context).size.width * 0.6,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 25),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[200],
            ),
            width: MediaQuery.of(context).size.width * 0.75,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    widget.descBook,
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          "Download",
                          //style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }

  Future addBookmark() async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("bookmarks")
          .doc(widget.bookId)
          .set({'bid': widget.bookId});
      checkBookmark();
    } catch (e) {}
  }

  Future removeBookmark() async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("bookmarks")
          .doc(widget.bookId)
          .delete();
      checkBookmark();
    } catch (e) {}
  }

  checkBookmark() async {
    var bookCheck = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection("bookmarks")
        .doc(widget.bookId)
        .get();

    if (bookCheck.exists) {
      setState(() {
        isBookmark = true;
      });
    } else {
      setState(() {
        isBookmark = false;
      });
    }
  }
}
