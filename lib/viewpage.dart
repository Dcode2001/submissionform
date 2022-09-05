import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:submissionform/DbHelper.dart';
import 'package:submissionform/firstpage.dart';

class viewpage extends StatefulWidget {
  const viewpage({Key? key}) : super(key: key);

  @override
  State<viewpage> createState() => _viewpageState();
}

class _viewpageState extends State<viewpage> {
  Database? db;

  @override
  void initState() {
    super.initState();

    getAllData();
  }

  Future<List<Map<String, Object?>>> getAllData() async {
    db = await DbHelper().createDatabase();

    String qry = "select * from Test";

    List<Map<String, Object?>> l1 = await db!.rawQuery(qry);

    print(qry);
    return l1;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text("View Page"),
          ),
          body: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  List<Map<String, Object?>> l =
                      snapshot.data as List<Map<String, Object?>>;

                  return (l.length > 0
                      ? ListView.builder(
                          itemCount: l.length,
                          itemBuilder: (context, index) {
                            Map m = l[index];
                            return ListTile(
                              onTap: () {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                  builder: (context) {
                                    return firstpage(m: m);
                                  },
                                ));
                              },
                              onLongPress: () {
                                showDialog(
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Delete"),
                                        content: Text(
                                            "Are You Sure To Delete Permentally?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () async {
                                                Navigator.pop(context);
                                                int id = m['id'];

                                                String qry =
                                                    "delete from Test where id = '$id'";

                                                await db!.rawDelete(qry);
                                                setState(() {});
                                              },
                                              child: Text("Yes")),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("No"))
                                        ],
                                      );
                                    },
                                    context: context);
                              },
                              leading: Text("${m['id']}"),
                              title: Text("${m['name']}"),
                              subtitle: Text("${m['contact']}"),
                            );
                          },
                        )
                      : Center(child: Text("NO DATA FOUND")));
                } else {
                  Center(child: Text("No Data Here"));
                }
              }
              return Center(child: CircularProgressIndicator());
            },
            future: getAllData(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return firstpage();
                },
              ));
            },
            child: Icon(
              Icons.add,
              size: 25,
            ),
          ),
        ),
        onWillPop: goback);
  }

  Future<bool> goback() {
    // Navigator.pop(context);
    exit(0);
    return Future.value();
  }
}
