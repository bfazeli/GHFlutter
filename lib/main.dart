import 'package:flutter/material.dart';

import 'strings.dart';
import 'ghflutter.dart';

void main() => runApp(new GHFlutterApp());


class GHFlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: Strings.appTitle,
      theme: ThemeData(primaryColor: Colors.green.shade800),
      home: new GHFlutter(),
    );
  }
}

// Use base n system to denote at most 2 digits for the integars
// in matrix and then use radix sort on the new based n system 
// k then becomes n - 1 while n is still n so O(n * k) == O(n*n-1)
// linear time.



