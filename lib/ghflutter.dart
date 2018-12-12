import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'memberWidget.dart';

import 'member.dart';
import 'strings.dart';

var _members = <Member>[];
final _biggerFont = const TextStyle(fontSize: 18.0);  // _ makes these members private accessors

class GHFlutterState extends State<GHFlutter> {
  @override
  void initState() {
    super.initState();

    _loadData();
  }

  // _pushMember(Member member) {
  //     Navigator.of(context).push(
  //       new MaterialPageRoute(
  //         builder: (context) => new MemberWidget(member)
  //       )
  //     );
  //   }

  _pushMember(Member member) {
    Navigator.of(context).push(
      new PageRouteBuilder(
        opaque: true,
        transitionDuration: const Duration(milliseconds: 1000),
        pageBuilder: (BuildContext context, _, __) {
          return new MemberWidget(member);
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return new FadeTransition(
            opacity: animation,
            child: new RotationTransition(
              turns: new Tween<double>(begin: 0.0, end: 1.0).animate(animation),
              child: child,
            ),
          );
        }
      )
    );
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
        title: new Text("${_members[i].login}", style: _biggerFont),
        leading: new CircleAvatar(
          backgroundColor: Colors.green,
          backgroundImage: new NetworkImage(_members[i].avatarUrl),
        ),
        onTap: () { _pushMember(_members[i]); },
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
          final member = new Member(memberJSON["login"], memberJSON["avatar_url"]);
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