import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ncf_app/bloc_helpers/bloc_provider.dart';
import 'package:ncf_app/bloc_widgets/bloc_state_builder.dart';
import 'package:ncf_app/blocs/authentication/authentication_bloc.dart';
import 'package:ncf_app/blocs/authentication/authentication_event.dart';
import 'package:ncf_app/blocs/authentication/authentication_state.dart';
import 'package:ncf_app/blocs/global_bloc.dart';
import 'package:ncf_app/pages/login_setting_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController controllerUserName = TextEditingController();
  TextEditingController controllerPwd = TextEditingController();

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
          body: Container(
            alignment: FractionalOffset.center,
            child: BlocEventStateBuilder<AuthenticationState>(
                bloc: bloc,
                builder: (BuildContext context, AuthenticationState state) {
                  if (state.isAuthenticated) {
                    return Container();
                  } else {
                    return Stack(
                      children: <Widget>[
                        // Positioned(
                        //   top: 10,
                        //   left: 300,
                        //   child: Container(
                        //       child: IconButton(
                        //           icon: Icon(Icons.settings),
                        //           color: Colors.black,
                        //           onPressed: () {
                        //             Navigator.push(context, MaterialPageRoute(
                        //                 builder: (BuildContext context) {
                        //               return LoginSettingPage();
                        //             }));
                        //           })),
                        // ),
                        
                        Container(
                          padding: EdgeInsets.all(0),
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            //height: 500,
                            child: _buildForm(bloc, state),
                            
                          ),
                          
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            colors: [
                              
                                 Colors.white,
                                 Colors.white,
                                
                            ],
                            begin: Alignment.center,
                            end: Alignment.topCenter,
                          )),
                        ),
                        _showCircularProgress(state),
                        Container(
                          padding: EdgeInsets.all(0),
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            //height: 500,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height/65,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                    // Color(0xFFF4CB2FF),
                                    // Color(0xFFF00F0FF),
                                  
                               Color(0xFF0033CC),
                               Color(0xFF0099FF),
                               
                                ],
                              ),
                              borderRadius: BorderRadius.only(
                             
                              )
              ),
                            
                          ),
                        )
                      ],
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }

  Widget _showCircularProgress(AuthenticationState state) {
    if (state.isAuthenticating) {
      return Center(child: CircularProgressIndicator());
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
          //_showLogo(),
          
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/14,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                      // Color(0xFF0099FF),
                      // Color(0xFFF00F0FF),
                     Color(0xFF0099FF),
                    Color(0xFF0033CC),
                 
                  ],
                ),
                borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(90)
                )
              ),
              
              child: Row(
                
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[    
                  //Spacer(),
                     //_showWelconeText(bloc),
                  Spacer(),
                 // _showLogo(),
                  _showIconSetting(bloc),
                  //Spacer(),
                  ],
              ),
              
            ),
          _showLogo(),
          _showEnterText(bloc),
          _showUserNameInput(bloc),
          _showPasswordInput(bloc),
          Container(
            height: 20,
          ),
          _showButton(bloc),
          //_showLoginSetting(bloc),
          Container(
            height: 10,
          ),
          _showErrorMessage(state),
           Container(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget _showLogo() {
    return Image.asset('assets/images/logo.png', width: 75, height: 75);
  }

Widget _showIconSetting(AuthenticationBloc bloc) {
  return 
    Padding(
      padding: const EdgeInsets.fromLTRB(0.0,0.0, 0.0, 0.0),
    
      child: Container(
        
        height: MediaQuery.of(context).size.height,
       
                        alignment: Alignment.centerRight,
                              child: IconButton(
                                  icon: Icon(Icons.settings),
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return LoginSettingPage();
                                    }));
                                  })),
                         
    );
}

Widget _showWelconeText(AuthenticationBloc bloc) {
  return 
    Padding(
       padding: const EdgeInsets.fromLTRB(70.0,0.0, 0.0, 0.0),
      
      child: 
      
      Text('Hi, Welcome Back',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          
                           ),
                         ),
                         
    );
}

Widget _showEnterText(AuthenticationBloc bloc) {
    return 
    Padding(
      padding: const EdgeInsets.fromLTRB(70.0,10.0, 0.0, 0.0),
      child: Text('Please enter your detail bellow here :',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                           ),
                        ),
    );
}

  Widget _showUserNameInput(AuthenticationBloc bloc) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
                      // borderRadius: BorderRadius.all(
                      //   Radius.circular(50),
                      // ),
                      shape: BoxShape.rectangle, 
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 2
                        )
                      ]
                    ),
        child :
        TextFormField(
        controller: controllerUserName,
        maxLines: 1,
        autofocus: false,
        
        decoration: InputDecoration(
            hintText: 'Username',
            labelText: "Username",
            // border: new OutlineInputBorder(
            //     borderRadius: new BorderRadius.circular(10.0)),
            border: InputBorder.none,   
            icon: Icon(
              Icons.person,
              color: Colors.blueGrey,
            )),
        validator: (value) => value.isEmpty ? 'Username can\'t be empty' : null,
      ),
      )
    );
  }

  Widget _showPasswordInput(AuthenticationBloc bloc) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 0.0),
      child: 
      Container(
        decoration: BoxDecoration(
                      // borderRadius: BorderRadius.all(
                      //   Radius.circular(50),
                      // ),
                      shape: BoxShape.rectangle, 
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                           color: Colors.black45,
                          blurRadius:2
                        )
                      ]
                    ),
        child:  TextFormField(
        controller: controllerPwd,
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: InputDecoration(
            hintText: 'Password',
            labelText: "Password",
            // border: new OutlineInputBorder(
            //     borderRadius: new BorderRadius.circular(10.0)),
            border: InputBorder.none,   
            icon: Icon(
              Icons.lock,
              color: Colors.blueGrey,
              
            )),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        ),
      )
      
    );
  }

  Widget _showButton(AuthenticationBloc bloc) {
    return Padding(
        //padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
        child: Container(
          height: 40.0,
          width: 40.0,
          decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                        //  Color(0xFF0099FF),
                        // Color(0xFFF00F0FF)
                        //  Color(0xFF0033CC),
                        // Color(0xFF0099FF),
                        Colors.blueGrey,
                        Colors.black45

                        ],
                      ),
                      shape: BoxShape.rectangle, 
                      borderRadius: BorderRadius.circular(10.0),
                    ),
          child: InkWell(
            child: Center(
                      child: Text('Login'.toUpperCase(),
                        style: TextStyle( fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      
                      ),
                      
                    ),
                    onTap: () {

                        if (_validateAndSave()) {
                        bloc.emitEvent(AuthenticationEventLogin(
                        userName: controllerUserName.text,
                        pwd: controllerPwd.text,
                      ));
                        } else {}
                    },
              
          ),
                    
          
        ));
  }

  Widget _showLoginSetting(AuthenticationBloc bloc) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: FlatButton(
            child: Text('Setting',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blueGrey,
                  decoration: TextDecoration.underline,
                )),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return LoginSettingPage();
              }));
            },
          ),
        ));
  }

  Widget _showErrorMessage(AuthenticationState state) {
    if (state.errorMessage != null) {
      if (state.errorMessage.length > 0) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            state.errorMessage,
            style: TextStyle(
                fontSize: 15.0,
                color: Colors.red,
                height: 1.0,
                fontWeight: FontWeight.w300),
          ),
        );
      }
    }

    return Container(
      height: 0.0,
    );
  }
}
