import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
      home: SWData(),
    ));

class SWData extends StatefulWidget {
  @override
  _SWDataState createState() => _SWDataState();
}

class _SWDataState extends State<SWData> {
  final String url = 'https://swapi.co/api/starships';
  List data;

  Future<String> getSWDATA() async {
    var res = await http.get(url, headers: {"Accept": "application/json"});
    setState(() {
      var resBody = json.decode(res.body);
      data = resBody['results'];
    });

    return 'Success!';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter JSON Example'),
        backgroundColor: Colors.amberAccent,
      ),
      body: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return new Container(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Card(
                      child: Column(
                        children: <Widget>[
                          Text(
                            data[index]['name'],
                            textAlign: TextAlign.left,
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                          ),
                          Text(
                            data[index]['model'],
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  @override
  void initState() {
    super.initState();
    this.getSWDATA();
  }
}
