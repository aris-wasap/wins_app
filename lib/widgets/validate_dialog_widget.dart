import 'package:flutter/material.dart';

class ValidateDialogWidget {
  ValidateDialogWidget({this.context, this.message}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Validation : '),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("${this.message}"),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    });
  }

  final BuildContext context;
  final String message;
}
