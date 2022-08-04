import 'package:flutter/material.dart';
import 'package:mahasiswa/datakaryawan.dart';
import 'package:mahasiswa/editDataKaryawan.dart';
import './editdata.dart';
import 'package:http/http.dart' as http;
import 'listdata.dart';

class DetailKaryawan extends StatefulWidget {
  List list;
  int index;
  DetailKaryawan({required this.index, required this.list});
  @override
  _DetailKaryawanState createState() => new _DetailKaryawanState();
}

class _DetailKaryawanState extends State<DetailKaryawan> {
  void deleteData() {
    var url = "http://10.0.2.2/my_store/deleteKaryawan";
    http.post(Uri.parse(url), body: {'id': widget.list[widget.index]['id']});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return Karyawan();
    }));
    _DeleteData(context, "Data berhasil dihapus");
  }

  void _DeleteData(BuildContext context, String error) {
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
          title: new Text(
            "${widget.list[widget.index]['item_name']}",
            style: TextStyle(fontFamily: "Netflix"),
          )),
      body: new Container(
        height: 370.0,
        padding: const EdgeInsets.all(20.0),
        child: new Card(
          child: new Center(
            child: new Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                ),
                new Text(
                  widget.list[widget.index]['nama'],
                  style: new TextStyle(fontFamily: "Netflix", fontSize: 20.0),
                ),
                new Text(
                  "Jabatan : ${widget.list[widget.index]['jabatan']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Text(
                  "Alamat : ${widget.list[widget.index]['alamat']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Column(
                  //mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: new RaisedButton(
                        child: new Text(
                          "EDIT",
                          style: TextStyle(
                              fontFamily: "Netflix", color: Colors.white),
                        ),
                        color: Colors.green,
                        onPressed: () => Navigator.of(context)
                            .pushReplacement(new MaterialPageRoute(
                          builder: (BuildContext context) => new EditDataKaryawan(
                            list: widget.list,
                            index: widget.index,
                          ),
                        )),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: new RaisedButton(
                        child: new Text(
                          "DELETE",
                          style: TextStyle(
                              fontFamily: "Netflix", color: Colors.white),
                        ),
                        color: Colors.red,
                        onPressed: () => deleteData(),
                      ),
                    ),
                  ],
                ),
                // new Padding(
                //   padding: const EdgeInsets.only(top: 30.0),
                // ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  width: double.infinity,
                  child: RaisedButton(
                    child: Text(
                      "Kembali",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
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
          ),
        ),
      ),
    );
  }
}
