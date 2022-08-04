import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mahasiswa/addDataKaryawan.dart';
import 'package:mahasiswa/detailkaryawan.dart';
import 'Detail.dart';
import 'adddata.dart';
import 'loginform.dart';
import 'homepage.dart';

class Karyawan extends StatefulWidget {
  @override
  // final String text;
  // Karyawan({Key key, @required this.text}) : super(key: key);
  _KaryawanState createState() => new _KaryawanState();
}

class _KaryawanState extends State<Karyawan> {
  Future<List> getData() async {
    final response = await http.get(Uri.parse("http://10.0.2.2/my_store/karyawan"));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "List Data Karyawan",
          style: TextStyle(fontFamily: "Netflix"),
        ),
        backgroundColor: Colors.green,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton.extended(
            heroTag: "logout",
            onPressed: () {
              Navigator.of(context).pushReplacement(new MaterialPageRoute(
                  builder: (BuildContext context) => new HomePage()));
              // logout(context);
            },
            // onPressed: () => Navigator.of(context).pushReplacement(
            //   new MaterialPageRoute(
            //       builder: (BuildContext context) => new AddData())),
            label: const Text('Menu'),
            icon: const Icon(Icons.logout),
            backgroundColor: Colors.blue,
          ),
          SizedBox(
            width: 20,
          ),
          //SizedBox(height: 10,),
          FloatingActionButton.extended(
            heroTag: "add data",
            onPressed: () {
              Navigator.of(context).pushReplacement(new MaterialPageRoute(
                  builder: (BuildContext context) => new AddDataKaryawan()));
            },
            label: const Text('Tambah Data'),
            icon: const Icon(Icons.add_box),
            backgroundColor: Colors.pink,
          ),
        ],
      ),

      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? ItemList(
            list: snapshot.data??[],
          )
              : Center(
            child: CircularProgressIndicator(),
          );
        },
      ),

      // body: new FutureBuilder<List>(
      //   future: getData(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasError) print(snapshot.error);

      //     return snapshot.hasData
      //         ? new ItemList(
      //             list: snapshot.data,
      //           )
      //         : new Center(
      //             child: new CircularProgressIndicator(),
      //           );
      //   },
      // ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({required this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: new GestureDetector(
            onTap: () =>
                Navigator.of(context).pushReplacement(new MaterialPageRoute(
                    builder: (BuildContext context) => new DetailKaryawan(
                      list: list,
                      index: i,
                    ))),
            child: new Card(
              child: new ListTile(
                title: new Text(
                  list[i]['nama'],
                  style: TextStyle(fontFamily: "Netflix"),
                ),
                leading: new Icon(Icons.widgets),
                subtitle: new Text("Jabatan : ${list[i]['jabatan']}"),
              ),
            ),
          ),
        );
      },
    );
  }
}
