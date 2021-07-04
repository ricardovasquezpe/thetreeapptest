import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thetreeapptest/app/theme/custom_colors.dart';
import 'package:thetreeapptest/app/utils/strings.dart';

class MyScaffold extends StatelessWidget {

  final Widget body;
  MyScaffold({required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
                Strings.headerTitle,
                style: TextStyle(
                    color: CustomColors.gray,
                  fontSize: 18
                ))
        ),
        drawer: Drawer(),
        body: this.body
    );
  }
}