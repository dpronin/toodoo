import 'package:flutter/material.dart';
import 'package:toodoo/pages/main_page.dart';

void main() => runApp(TooDoo());

class TooDoo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}