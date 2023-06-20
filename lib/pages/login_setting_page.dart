import 'package:flutter/material.dart';
import 'package:wins_app/blocs/global_bloc.dart';
import 'package:wins_app/widgets/set_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        _switchController.text == "Demo" ? _demoMode = true : _demoMode = false;
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
              icon: Icon(Icons.check),
              onPressed: () async {
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
            // constraints: BoxConstraints.expand(),
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 500,
              child: Column(
                children: <Widget>[
                  buildForm(),
                ],
              ),
            ),
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(gradient: bgGradientPage)),
      ),
    );
  }

  Widget buildForm() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  color: Colors.white,
                  elevation: 5,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Mode : "),
                      ),
                      Switch(
                        value: _demoMode,
                        onChanged: (bool value) {
                          setState(() {
                            _demoMode = value;
                            _switchController.text =
                                _demoMode ? 'Demo' : 'Live';
                            _urlController.text = "";
                          });
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      _demoMode ? Text("Demo") : Text("Live"),
                    ],
                  ),
                ),
                Card(
                  color: Colors.white,
                  elevation: 5,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Database : "),
                      ),
                      DropdownButton(
                        value: _selectedOption,
                        items: _demoMode
                            ? _demoOptions.map((database) {
                                _selectedOption = null;
                                _databaseController.text = database;
                                return DropdownMenuItem(
                                  value: database,
                                  child: Text(database),
                                );
                              }).toList()
                            : _normalOptions.map((database) {
                                _selectedOption = null;
                                _databaseController.text = database;
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
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Card(
                  color: Colors.white,
                  elevation: 5,
                  child: TextFormField(
                    enabled: false,
                    controller: _urlController,
                    decoration: InputDecoration(
                      hintText: "URL",
                      labelText: "",
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(0.0)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]);
  }
}
