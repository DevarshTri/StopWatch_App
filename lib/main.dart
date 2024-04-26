import 'package:flutter/material.dart';
import 'package:master_stopwatch/login.dart';
import 'package:master_stopwatch/stopwatch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: sw(),
      debugShowCheckedModeBanner: false,
    );
  }
}