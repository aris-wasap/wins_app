import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wins_app/bloc_helpers/bloc_provider.dart';
import 'package:wins_app/bloc_widgets/bloc_state_builder.dart';
import 'package:wins_app/blocs/authentication/authentication_bloc.dart';
import 'package:wins_app/blocs/authentication/authentication_event.dart';
import 'package:wins_app/blocs/authentication/authentication_state.dart';
import 'package:wins_app/blocs/global_bloc.dart';
import 'package:wins_app/pages/login_setting_page.dart';
import 'package:wins_app/widgets/set_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController controllerUserName = TextEditingController();
  TextEditingController controllerPwd = TextEditingController();
  bool checkPass = true;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> _onWillPopScope() async {
    // return false;
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit an App'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                // onPressed: () => Navigator.of(context).pop(true),
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();

    // if (GlobalBloc.isSkipLogin == "Y") {
    //   controllerUserName.text = "Admin";
    //   controllerPwd.text = "password";
    // }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final SharedPreferences prefs = await _prefs;
      var url = prefs.getString(globalBloc.getPrefApiUrl());
      globalBloc.setUrl(url);

      var switchMode = prefs.getString(globalBloc.getSwitchMode());
      globalBloc.setSwitchMode(switchMode);

      var databaseName = prefs.getString(globalBloc.getDatabase());
      globalBloc.setDatabaseName(databaseName);
    });
  }

  @override
  void dispose() {
    controllerUserName?.dispose();
    controllerPwd?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc bloc = BlocProvider.of<AuthenticationBloc>(context);
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: SafeArea(
        child: Scaffold(
          // appBar: AppBar(
          //   title: Text("Authentication"),
          //   leading: Icon(Icons.person),
          // ),
          body: BlocEventStateBuilder<AuthenticationState>(
              bloc: bloc,
              builder: (BuildContext context, AuthenticationState state) {
                if (state.isAuthenticated) {
                  return Container();
                } else {
                  return Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        // color: Colors.white.withOpacity(0.5),
                        padding: EdgeInsets.symmetric(vertical: 0),
                        width: double.infinity,
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
                            decoration: new BoxDecoration(
                                color: Colors.white.withOpacity(0.6)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Expanded(
                                  child: _buildForm(bloc, state),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      _showCircularProgress(state),
                      //           Container(
                      //             padding: EdgeInsets.all(0),
                      //             alignment: Alignment.bottomCenter,
                      //             child: Container(
                      //               alignment: Alignment.bottomCenter,
                      //               //height: 500,
                      //               width: MediaQuery.of(context).size.width,
                      //               height: MediaQuery.of(context).size.height/65,
                      //               decoration: BoxDecoration(
                      //                 gradient: LinearGradient(
                      //                   begin: Alignment.topCenter,
                      //                   end: Alignment.bottomCenter,
                      //                   colors: [
                      //                  Color(0xFF0033CC),
                      //                  Color(0xFF0099FF),

                      //                   ],
                      //                 ),
                      //                 borderRadius: BorderRadius.only(

                      //                 )
                      // ),

                      //             ),
                      //           )
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }

  Widget _showCircularProgress(AuthenticationState state) {
    if (state.isAuthenticating) {
      return CircularProgressIndicator(
        backgroundColor: bgOrange,
      );
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget _buildForm(AuthenticationBloc bloc, AuthenticationState state) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          _showLogo(),
          SizedBox(
            height: 10.0,
          ),
          _showVersionApp(bloc),
          SizedBox(
            height: 50,
          ),
          _showEnterText(bloc),
          _showUserNameInput(bloc),
          _showPasswordInput(bloc),
          _showErrorMessage(state),
          SizedBox(
            height: 35,
          ),
          _showLoginButton(bloc),
          _showLoginSetting(bloc),
          Container(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget _showLogo() {
    return Image.asset('assets/laucher/logo_ncf.png', width: 100, height: 75);
  }

  Widget _showIconSetting(AuthenticationBloc bloc) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.centerRight,
          child: IconButton(
              icon: Icon(Icons.settings),
              color: Colors.white,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return LoginSettingPage();
                }));
              })),
    );
  }

  Widget _showWelconeText(AuthenticationBloc bloc) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(70.0, 0.0, 0.0, 0.0),
      child: Text(
        'Hi, Welcome Back',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _showEnterText(AuthenticationBloc bloc) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 20.0, 0.0, 0.0),
      child: Text(
        'Please enter your detail bellow here :',
        style: TextStyle(
          color: Colors.black54,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _showVersionApp(AuthenticationBloc bloc) {
    return Column(
      children: <Widget>[
        Text(
          'Version',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          '23.09.05',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _showUserNameInput(AuthenticationBloc bloc) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
        child: TextFormField(
          controller: controllerUserName,
          maxLines: 1,
          autofocus: true,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: bgBlue),
            ),
            hintText: 'Username',
            labelText: "Username",
            border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(5.0)),
            //border: InputBorder.none,
            suffixIcon: Icon(Icons.person_outline, color: Colors.blueGrey),
          ),
          validator: (value) =>
              value.isEmpty ? 'Username can\'t be empty' : null,
        ));
  }

  Widget _showPasswordInput(AuthenticationBloc bloc) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 0.0),
        child: TextFormField(
          controller: controllerPwd,
          maxLines: 1,
          obscureText: checkPass,
          autofocus: false,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: bgBlue),
              ),
              hintText: 'Password',
              labelText: "Password",
              border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(5.0)),
              // border: InputBorder.none,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    checkPass = !checkPass;
                  });
                },
                child: Icon(
                  checkPass == true ? Icons.lock_outline : Icons.lock_open,
                  color: checkPass == true ? Colors.blueGrey : bgOrange,
                ),
              )),
          validator: (value) =>
              value.isEmpty ? 'Password can\'t be empty' : null,
        ));
  }

  Widget _showLoginButton(AuthenticationBloc bloc) {
    return Container(
      height: 50.0,
      margin: EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black12, offset: Offset(4, 4), blurRadius: 10),
          BoxShadow(
              color: Colors.black12, offset: Offset(-4, -4), blurRadius: 10),
        ],
        gradient: btnGradientColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        color: bgOrange,
        child: InkWell(
          child: Center(
            child: Text(
              'Login'.toUpperCase(),
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          onTap: () {
            if (_validateAndSave()) {
              bloc.emitEvent(
                AuthenticationEventLogin(
                  userName: controllerUserName.text,
                  pwd: controllerPwd.text,
                ),
              );
            } else {}
          },
        ),
      ),
    );
  }

  Widget _showLoginSetting(AuthenticationBloc bloc) {
    return SizedBox(
      height: 70.0,
      child: FlatButton(
        child: Text('Setting'.toUpperCase(),
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
              //decoration: TextDecoration.underline,
            )),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return LoginSettingPage();
          }));
        },
      ),
    );
  }

  Widget _showErrorMessage(AuthenticationState state) {
    if (state.errorMessage != null) {
      if (state.errorMessage.length > 0) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 0.0),
          child: Text(
            state.errorMessage,
            style: TextStyle(
                fontSize: 15.0,
                color: Colors.red,
                height: 1.0,
                fontWeight: FontWeight.w500),
          ),
        );
      }
    }

    return Container(
      height: 0.0,
    );
  }
}
