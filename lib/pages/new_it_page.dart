import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewIt extends StatefulWidget {
  @override
  _NewItState createState() => _NewItState();
}

class _NewItState extends State<NewIt> {
  final _formKey = GlobalKey<FormState>();
  List<String> _colors = <String>['', 'Release', 'Reject', 'Production', 'Logistic'];
  String _color = '';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("New Inventory Transfer"),
        backgroundColor: Colors.blue[900],
        bottom: PreferredSize(
          child: Container(
            color: Colors.yellow[900],
            height: 5.0,
          ),
          preferredSize: Size.fromHeight(5.0)
        )
      ),
      body: new SafeArea(
        top: false,
        bottom: false,
        child: new Form(
          key: _formKey,
          autovalidate: true,
          child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              new FormField(
                builder: (FormFieldState state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      icon: const Icon(Icons.view_agenda),
                      labelText: 'Document Type',
                    ),
                    isEmpty: _color == '',
                    child: new DropdownButtonHideUnderline(
                      child: new DropdownButton(
                        value: _color,
                        isDense: true,
                        onChanged: (String newValue) {
                          setState(() {});
                        },
                        items: _colors.map((String value) {
                          return new DropdownMenuItem(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.format_list_numbered),
                  hintText: 'Document Number',
                  labelText: 'Document Number',
                ),
              ),
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.calendar_today),
                  hintText: 'Document Date',
                  labelText: 'Document Date',
                ),
                keyboardType: TextInputType.datetime,
              ),
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.file_upload),
                  hintText: 'From Warehouse',
                  labelText: 'From Warehouse',
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                ],
              ),
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.file_download),
                  hintText: 'To Warehouse',
                  labelText: 'To Warehouse',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              new Container(
                padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                child: new RaisedButton(
                  child: const Text('Submit'),
                  onPressed: null,
                )
              ),
            ],
          )
        )
      ),
    );
  }
}
