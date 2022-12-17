import 'package:flutter/material.dart';
import 'package:homestay_raya_281917/SplashPage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'My HomeStay Raya',
        home: Scaffold(
          body: SplashPage(),
        ));
  }
}
