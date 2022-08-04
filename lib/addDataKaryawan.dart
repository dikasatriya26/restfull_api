import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mahasiswa/datakaryawan.dart';
import 'listdata.dart';
import 'dart:async';
import 'dart:convert';

class AddDataKaryawan extends StatefulWidget {
  @override
  _AddDataKaryawanState createState() => new _AddDataKaryawanState();
}

class _AddDataKaryawanState extends State<AddDataKaryawan> {
  TextEditingController nama = new TextEditingController();
  TextEditingController jabatan = new TextEditingController();
  TextEditingController alamat = new TextEditingController();

  void addData() {
    var url = "http://10.0.2.2/my_store/saveKaryawan";

    http.post(Uri.parse(url), body: {
      "nama": nama.text,
      "jabatan": jabatan.text,
      "alamat": alamat.text,
    });
  }

  void error(BuildContext context, String error) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(error),
        action: SnackBarAction(
            label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Tambah Data", style: TextStyle(fontFamily: "Netflix"),),
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
                      hintText: "Nama",
                      hintStyle: TextStyle(fontFamily: "Netflix"),
                      labelText: "Nama"),
                ),
                new TextField(
                  controller: jabatan,
                  style: TextStyle(fontFamily: "Netflix", fontSize: 15),
                  decoration: new InputDecoration(
                      hintText: "Jabatan",
                      hintStyle: TextStyle(fontFamily: "Netflix"),
                      labelText: "Jabatan"),
                ),
                new TextField(
                  controller: alamat,
                  style: TextStyle(fontFamily: "Netflix", fontSize: 15),
                  decoration: new InputDecoration(
                      hintText: "Alamat",
                      hintStyle: TextStyle(fontFamily: "Netflix"),
                      labelText: "Alamat"),
                ),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                Column(
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () {
                          //Navigator.pop(context);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                                return Home();
                              }));
                          // Navigator.of(context).pushReplacement(new MaterialPageRoute(
                          //     builder: (BuildContext context) => new Home()));
                        },
                        child: new Text("Kembali", style: TextStyle(color: Colors.white),),
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () {
                          if (nama.value.text.isEmpty) {
                            setState(() {
                              error(context, "ID tidak boleh kosong");
                            }); //ID gabole kosong//id harus angka//id harus 3 angka
                          } else if (jabatan.value.text.isEmpty) {
                            setState(() {
                              error(context, "Nama item tidak boleh kosong");
                              error(context, "Isi data dengan benar!");
                            }); //nama ga bole kosong//harga harus minimal 4 karakter
                          } else {
                            addData();
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                                  return Karyawan();
                                }));
                          }

                          // Navigator.of(context).pushReplacement(new MaterialPageRoute(
                          //     builder: (BuildContext context) => new Home()));
                        },
                        child: new Text(
                          "Add Data",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.pink,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
