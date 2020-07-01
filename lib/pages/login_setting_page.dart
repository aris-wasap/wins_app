import 'package:flutter/material.dart';
import 'package:admart_app/blocs/global_bloc.dart';
import 'package:admart_app/widgets/set_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginSettingPage extends StatefulWidget {
  @override
  _LoginSettingPageState createState() => _LoginSettingPageState();
}

class _LoginSettingPageState extends State<LoginSettingPage> {
  final _urlController = TextEditingController();

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final SharedPreferences prefs = await _prefs;
      _urlController.text = prefs.getString(globalBloc.getPrefApiUrl());
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
          title: Text("Login Settings", style: TextStyle(
                  color: Colors.white
          ),),
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

                Navigator.pop(context);
              },
              textColor: Colors.white,
              label: Text("Submit"),
            ),
          ],
        ),
        body: Container(
          // constraints: BoxConstraints.expand(),
          child:Container(
            alignment: Alignment.bottomCenter,
            height: 500,
            child: buildForm(),
          ),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: bgGradientPage)
        ),
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
                TextFormField(
                  controller: _urlController,
                  decoration: InputDecoration(
                    hintText: "URL",
                    labelText: "URL",
                    contentPadding: new EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0)
                    )
                  ),
                ),
              ],
            ),
          ),
        ]);
  }
}
