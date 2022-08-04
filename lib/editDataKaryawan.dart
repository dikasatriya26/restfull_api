import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'datakaryawan.dart';
import 'listdata.dart';

class EditDataKaryawan extends StatefulWidget {
  final List list;
  final int index;

  EditDataKaryawan({required this.list, required this.index});

  @override
  _EditDataKaryawanState createState() => new _EditDataKaryawanState();
}

class _EditDataKaryawanState extends State<EditDataKaryawan> {
  late TextEditingController nama;
  late TextEditingController jabatan;
  late TextEditingController alamat;

  void editData() {
    var url = "http://10.0.2.2/my_store/editKaryawan";
    http.post(Uri.parse(url), body: {
      "id": widget.list[widget.index]['id'],
      "nama": nama.text,
      "jabatan": jabatan.text,
      "alamat": alamat.text,
    });
  }

  @override
  void initState() {
    nama =
    new TextEditingController(text: widget.list[widget.index]['nama']);
    jabatan =
    new TextEditingController(text: widget.list[widget.index]['jabatan']);
    alamat =
    new TextEditingController(text: widget.list[widget.index]['alamat']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Edit Data",
          style: TextStyle(fontFamily: "Netflix"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new TextField(
                  controller: nama,
                  style: TextStyle(fontFamily: "Netflix", fontSize: 15),
                  decoration: new InputDecoration(
                      hintText: "Item Name", labelText: "Item Name"),
                ),
                new TextField(
                  controller: jabatan,
                  style: TextStyle(fontFamily: "Netflix", fontSize: 15),
                  decoration: new InputDecoration(
                      hintText: "Jabatan", labelText: "Jabatan"),
                ),
                new TextField(
                  controller: alamat,
                  style: TextStyle(fontFamily: "Netflix", fontSize: 15),
                  decoration: new InputDecoration(
                      hintText: "Alamat", labelText: "Alamat"),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: RaisedButton(
                    child: new Text(
                      "EDIT DATA",
                      style:
                      TextStyle(fontFamily: "Netflix", color: Colors.white),
                    ),
                    color: Colors.blueAccent,
                    onPressed: () {
                      editData();
                      Navigator.of(context).pushReplacement(new MaterialPageRoute(
                          builder: (BuildContext context) => new Karyawan()));
                    },
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: RaisedButton(
                    child: Text("Kembali ke menu", style: TextStyle(fontFamily: "Netflix", color: Colors.white),),
                    color: Colors.red,
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                            return Karyawan();
                          }));
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
