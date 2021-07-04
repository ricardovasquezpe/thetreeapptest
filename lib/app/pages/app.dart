import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thetreeapptest/app/pages/home/view/home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ThreeappTest',
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
        },
    );
  }
}