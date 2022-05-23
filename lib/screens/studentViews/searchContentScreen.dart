import 'package:flutter/material.dart';

class searchContentScreen extends StatefulWidget {
  searchContentScreen({Key? key}) : super(key: key);

  @override
  State<searchContentScreen> createState() => _searchContentScreenState();
}

class _searchContentScreenState extends State<searchContentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              // expands: true,
              // maxLines: null,
              style: TextStyle(fontSize: 20.0, color: Colors.black54),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    print('Search Process');
                  },
                ),
                hintText: 'Search...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.fromLTRB(12, 7, 12, 3),
              ),
            ),
          ),
        ),
        // actions: <Widget>[
        //   IconButton(
        //     icon: const Icon(Icons.navigate_next),
        //     tooltip: 'Go to the next page',
        //     onPressed: () {
        //       Navigator.push(context, MaterialPageRoute<void>(
        //         builder: (BuildContext context) {
        //           return Scaffold(
        //             appBar: AppBar(
        //               title: const Text('Next page'),
        //             ),
        //             body: const Center(
        //               child: Text(
        //                 'This is the next page',
        //                 style: TextStyle(fontSize: 24),
        //               ),
        //             ),
        //           );
        //         },
        //       ));
        //     },
        //   ),
        // ],
      ),
      body: const Center(
        child: Text(
          'Not Found',
          style: TextStyle(fontSize: 24.0, color: Colors.black54),
        ),
      ),
    );
  }
}
