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
      body: new Text(Strings.appTitle),
    );
  }

  @override
  void initState() {
    super.initState();
    
    _loadData();
  }

  _loadData() async {
    String dataURL = "https://github.com/orgs/codeandcoffeelb/people";
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