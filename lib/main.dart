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

var _members = <Member>[];
final _biggerFont = const TextStyle(fontSize: 18.0);  // _ makes these members private accessors

class Member {
  final String login;

  Member(this.login) {
    if (login == null) {
      throw new ArgumentError("login of member cannot be null."
        "Received: '$login'");
    }
  }
}

class GHFlutterState extends State<GHFlutter> {
  @override
  void initState() {
    super.initState();

    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(Strings.appTitle),
      ),
      body: new ListView.builder(
        itemCount: _members.length * 2,
        itemBuilder: (BuildContext context, int position){
          if (position.isOdd) {
            return new Divider();
          }

          final index = position ~/ 2;

          return _buildRow(index);
        },
      ),
    );
  }


  Widget _buildRow(int i) {
    return new Padding(
      padding: const EdgeInsets.all(16.0),
      child: new ListTile (
        title: new Text("${_members[i].login}", style: _biggerFont)
      )
    );
  }


  _loadData() async {
    String dataURL = "https://api.github.com/orgs/codeandcoffeelb/members";
    // http.Response response = await http.get(dataURL);
    http.get(dataURL)
    .then( (response) => 
      setState(() {
        final membersJSON = jsonDecode(response.body);
        for (var memberJSON in membersJSON) {
          final member = new Member(memberJSON["login"]);
          _members.add(member);
        }
      })
    );
  }
}

class GHFlutter extends StatefulWidget {
  @override
  createState() => new GHFlutterState();
}