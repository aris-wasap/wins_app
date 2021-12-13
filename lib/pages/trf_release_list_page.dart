import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wins_app/pages/new_tfr_release_page.dart';

class TrfRelease extends StatefulWidget {
  @override
  State createState() => new TrfReleaseState();
}

class TrfReleaseState extends State<TrfRelease> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Transfer Release"),
        //title: TextField(
        //controller: _searchQueryController,
        // decoration: InputDecoration(
        //   hintText: "Search Release",
        //   hintStyle: TextStyle(color: Colors.white),
        // enabledBorder: OutlineInputBorder(
        //   borderSide: BorderSide(color: Colors.white),
        // )
        //),
        //),
        backgroundColor: Colors.blue[900],
        bottom: PreferredSize(
            child: Container(
              color: Colors.yellow[900],
              height: 5.0,
            ),
            preferredSize: Size.fromHeight(5.0)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return NewTrfRelease();
              }));
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [const Color(0xfff9fbe7), const Color(0xffd7ccc8)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Center(
          child: Text(
            "List Transfer Release",
            style: new TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   icon: Icon(Icons.camera_alt),
      //   label: Text("Scan"),
      //   onPressed: _scanQR,
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
