import 'package:flutter/material.dart';

class LabelFieldWidget extends StatelessWidget {
  LabelFieldWidget({this.enable: false, this.labelText, this.valueText});

  final bool enable;
  final String labelText;
  final String valueText;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: (enable) ? Colors.blue : Colors.grey,
            width: 1.0,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(labelText, style: TextStyle(color: Colors.blue, fontSize: 12.0)),
          Text(valueText, style: TextStyle(fontSize: 17.0))
        ],
      ),
    );
  }
}
