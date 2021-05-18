import 'package:flutter/material.dart';

import './screens/app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'PiGarden';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _title,
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.lightGreen,
        ),
        home: HomeScreen(),
      );
  }
}