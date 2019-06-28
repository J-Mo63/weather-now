import 'package:flutter/material.dart';
import 'package:weather_now/widget/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Now',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: HomePage(title: 'Weather Now'),
    );
  }
}