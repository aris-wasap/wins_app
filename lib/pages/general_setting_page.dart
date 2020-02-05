import 'package:flutter/material.dart';

class GeneralSettingPage extends StatefulWidget {
  @override
  _GeneralSettingPageState createState() => _GeneralSettingPageState();
}

class _GeneralSettingPageState extends State<GeneralSettingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("General Setting"),
        ),
      ),
    );
  }
}
