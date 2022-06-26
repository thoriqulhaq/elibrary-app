import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elibrary_app/screens/lecturerViews/editContent.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firestore_search/firestore_search.dart';

class searchContentScreen extends StatefulWidget {
  searchContentScreen({Key? key}) : super(key: key);

  get indexedField => null;

  @override
  State<searchContentScreen> createState() => _searchContentScreenState();
}

class _searchContentScreenState extends State<searchContentScreen> {
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return FirestoreSearchScaffold(
      firestoreCollectionName: 'contents',
      searchBy: 'title',
      scaffoldBody: Center(),
      dataListFromSnapshot: DataModel().dataListFromSnapshot,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<DataModel>? dataList = snapshot.data;
          if (dataList!.isEmpty) {
            return const Center(
              child: Text('No Results Returned'),
            );
          }
          return ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                final DataModel data = dataList[index];

                return ListTile(
                  leading: Image.network('${data.cover}'),
                  title: Text('${data.title}'),
                  subtitle: Text('${data.author}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    editContent(docId: data.id!)),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          db.collection('contents').doc(data.id).delete();
                          db
                              .collection('contents')
                              .doc(data.id)
                              .collection('files')
                              .get()
                              .then((value) {
                            for (var file in value.docs) {
                              db
                                  .collection('contents')
                                  .doc(data.id)
                                  .collection('files')
                                  .doc(file.id)
                                  .delete();
                              FirebaseStorage.instance
                                  .ref()
                                  .child(file.data()['path'])
                                  .delete();
                            }
                          });
                        },
                      ),
                    ],
                  ),
                );
              });
        }

        if (snapshot.connectionState == ConnectionState.done) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text('No Results Returned'),
            );
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class DataModel {
  final String? title;
  final String? author;
  final String? cover;
  final String? id;
  DataModel({this.title, this.author, this.cover, this.id});

  //Create a method to convert QuerySnapshot from Cloud Firestore to a list of objects of this DataModel
  //This function in essential to the working of FirestoreSearchScaffold

  List<DataModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
          snapshot.data() as Map<String, dynamic>;

      return DataModel(
          title: dataMap['title'],
          author: dataMap['author'],
          cover: dataMap['cover'],
          id: snapshot.id);
    }).toList();
  }
}
