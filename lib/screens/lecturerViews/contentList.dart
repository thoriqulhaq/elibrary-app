import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elibrary_app/screens/lecturerViews/editContent.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class contentList extends StatefulWidget {
  contentList({Key? key}) : super(key: key);

  @override
  State<contentList> createState() => _contentListState();
}

class _contentListState extends State<contentList> {
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Uploaded Content"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('contents').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            
            return ListView(
              
              children: snapshot.data!.docs.map((doc) {
                return ListTile(
                  
                  shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black, width: 0.5), ),
                  //show the cover image
                  leading: Image.network(doc['cover']),
                  title: Text(doc['title']),
                  subtitle: Text(doc['author']),
                 //edit button to edit the content and delete button to delete the content
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push( context, MaterialPageRoute(builder: (context) => editContent(docId : doc.id)),);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          db.collection('contents').doc(doc.id).delete();
                          db.collection('contents').doc(doc.id).collection('files').get().then((value) {
                          for (var file in value.docs) {
                          db.collection('contents').doc(doc.id).collection('files').doc(file.id).delete();
                          FirebaseStorage.instance.ref().child(file.data()['path']).delete();
                        }
                        });
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
