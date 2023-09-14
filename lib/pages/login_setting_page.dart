import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wins_app/blocs/global_bloc.dart';
import 'package:wins_app/widgets/set_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wins_app/widgets/validate_dialog_widget.dart';

class LoginSettingPage extends StatefulWidget {
  @override
  _LoginSettingPageState createState() => _LoginSettingPageState();
}

class _LoginSettingPageState extends State<LoginSettingPage> {
  final _urlController = TextEditingController();
  final _switchController = TextEditingController();
  final _databaseController = TextEditingController();

  bool _demoMode = false;
  String _selectedOption;
  String _apiUrl = "http://116.254.101.55:8080/[nama database]/";
  // String _apiUrl = "http://192.168.16.136/[nama database]/";
  List<String> _demoOptions = ['NCF_UAT', 'ADMART_UAT', 'WINS_APP'];
  List<String> _normalOptions = ['NCF_API', 'ADMART_API'];

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final SharedPreferences prefs = await _prefs;
      setState(() {
        _urlController.text = prefs.getString(globalBloc.getPrefApiUrl());
        _switchController.text = prefs.getString(globalBloc.getSwitchMode());
        _switchController.text == "Live" ? _demoMode = true : _demoMode = false;
        _databaseController.text = prefs.getString(globalBloc.getDatabase());
      });
    });
  }

  @override
  void dispose() {
    _urlController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Login Settings",
            style: TextStyle(color: Colors.white),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: bgGradientAppBar,
            ),
          ),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.save_alt),
              onPressed: () async {
                // if (_urlController.text == "") {
                //   ValidateDialogWidget(
                //       context: context,
                //       message: "Silahkan pilih Database terlebih dahulu");
                //   return;
                // }

                final SharedPreferences prefs = await _prefs;
                prefs.setString(
                    globalBloc.getPrefApiUrl(), _urlController.text);
                globalBloc.setUrl(_urlController.text);

                prefs.setString(
                    globalBloc.getSwitchMode(), _switchController.text);
                globalBloc.setSwitchMode(_switchController.text);

                prefs.setString(
                    globalBloc.getDatabase(), _databaseController.text);
                globalBloc.setDatabaseName(_databaseController.text);

                Navigator.pop(context);
              },
              textColor: Colors.white,
              label: Text("Submit"),
            ),
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          // width: double.infinity,
          decoration: BoxDecoration(
            //gradient: bgGradient,
            image: DecorationImage(
                image: AssetImage("assets/images/579.jpg"),
                fit: BoxFit.cover,
                repeat: ImageRepeat.noRepeat),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: Container(
              decoration:
                  new BoxDecoration(color: Colors.white.withOpacity(0.6)),
              child: SingleChildScrollView(
                child: buildForm(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildForm() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.settings,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Settings",
                      style: headerTextStyle,
                    )
                  ],
                ),
                Divider(
                  color: bgGrey,
                  thickness: 0.8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.airplay,
                      color: bgOrange,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Mode "),
                    Text("     : "),
                    Switch(
                      activeColor: Colors.green,
                      inactiveThumbColor: bgBlue,
                      value: _demoMode,
                      onChanged: (bool value) {
                        setState(() {
                          _demoMode = value;
                          _switchController.text = _demoMode ? 'Live' : 'Demo';
                          _urlController.text = "";
                          _databaseController.text = "";
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    _demoMode ? Text("Live") : Text("Demo"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.storage,
                      color: bgOrange,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Database : "),
                    DropdownButton(
                      value: _selectedOption,
                      items: _demoMode
                          ? _normalOptions.map((database) {
                              _selectedOption = null;
                              return DropdownMenuItem(
                                value: database,
                                child: Text(database),
                              );
                            }).toList()
                          : _demoOptions.map((database) {
                              _selectedOption = null;
                              return DropdownMenuItem(
                                value: database,
                                child: Text(database),
                              );
                            }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          _selectedOption = newValue;
                          _urlController.text =
                              _apiUrl.replaceAll('[nama database]', newValue);
                          _databaseController.text = newValue;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.verified_user,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Current Settings",
                      style: headerTextStyle,
                    ),
                  ],
                ),
                Divider(
                  color: bgGrey,
                  thickness: 0.8,
                ),
                TextField(
                  enabled: false,
                  controller: _switchController,
                  decoration: InputDecoration(
                    hintText: "Mode",
                    labelText: "Mode",
                    hintStyle: TextStyle(color: Colors.white),
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10.0),
                    // border: new OutlineInputBorder(
                    //     borderRadius: new BorderRadius.circular(0.0)),
                  ),
                ),
                TextFormField(
                  enabled: false,
                  controller: _databaseController,
                  decoration: InputDecoration(
                    hintText: "Database",
                    labelText: "Database",
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10.0),
                    // border: new OutlineInputBorder(
                    //     borderRadius: new BorderRadius.circular(0.0)),
                  ),
                ),
                // TextField(
                //   enabled: false,
                //   controller: _urlController,
                //   readOnly: true,
                //   decoration: InputDecoration(
                //     hintText: "URL",
                //     labelText: "Address",
                //     hintStyle: TextStyle(color: Colors.white),
                //     contentPadding: new EdgeInsets.symmetric(
                //         vertical: 15.0, horizontal: 10.0),
                //     // border: new OutlineInputBorder(
                //     //     borderRadius: new BorderRadius.circular(0.0)),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
