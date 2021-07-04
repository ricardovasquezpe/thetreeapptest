import 'package:flutter/material.dart';
import 'package:thetreeapptest/app/pages/app.dart';
import 'package:thetreeapptest/app/utils/dependencies.dart';

void main() {
  setupDependencies();
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ThreeappTest',
      home: App(),
      theme: ThemeData(fontFamily: 'WorkSans'),
    );
  }
}
