import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'strings.dart';

void main() => runApp(new GHFlutterApp());


class GHFlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: Strings.appTitle,
      home: new GHFlutter(),
    );
  }
}

var _members = [];
final _biggerFont = const TextStyle(fontSize: 18.0);  // _ makes these members private accessors


class GHFlutterState extends State<GHFlutter> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(Strings.appTitle),
      ),
      body: new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _members.length,
        itemBuilder: (BuildContext context, int position){
          return _buildRow(position);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  Widget _buildRow(int i) {
    return new ListTile(
      title: new Text("${_members[i]["login"]}", style: _biggerFont),
    );
  }


  _loadData() async {
    String dataURL = "https://api.github.com/orgs/codeandcoffeelb/members";
    // http.Response response = await http.get(dataURL);
    http.get(dataURL)
    .then( (response) => 
      setState(() {
        _members = jsonDecode(response.body);
      })
    );
  }
}

class GHFlutter extends StatefulWidget {
  @override
  createState() => new GHFlutterState();
}