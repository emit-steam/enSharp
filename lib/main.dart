import 'package:ensharp/screen/contact_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EnSharp',
      theme: ThemeData(
        primaryColorBrightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: ContactScreen(),
    );
  }
}
