import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ncf_app/bloc_helpers/bloc_provider.dart';
import 'package:ncf_app/bloc_widgets/bloc_state_builder.dart';
import 'package:ncf_app/blocs/authentication/authentication_bloc.dart';
import 'package:ncf_app/blocs/authentication/authentication_event.dart';
import 'package:ncf_app/blocs/authentication/authentication_state.dart';
import 'package:ncf_app/blocs/global_bloc.dart';
import 'package:ncf_app/pages/login_setting_page.dart';
import 'package:ncf_app/widgets/set_colors.dart';
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
                          padding: EdgeInsets.symmetric(vertical: 0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              gradient: bgGradient),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                            SizedBox(height: 50,),
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                    Text("Hi,", style: TextStyle(color: Colors.white, fontSize: 40),),
                                    SizedBox(height: 10,),
                                    Text("Welcome Back", style: TextStyle(color: Colors.white, fontSize: 20),),

                                ],
                              ),
                              ),
                              SizedBox(height: 20,),
                              Expanded(child: 
                                Container(
                              height: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)
                              ),
                              ),
                              alignment: Alignment.bottomCenter,
                              child: _buildForm(bloc, state),
                              
                            ),
                              ),
                            ],
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
          
          SizedBox(height: 10,),
          _showLogo(),
          _showEnterText(bloc),
          _showUserNameInput(bloc),
          _showPasswordInput(bloc),
          _showErrorMessage(state),
          SizedBox(height: 35,),
          _showButton(bloc),
          _showLoginSetting(bloc),
          
           Container(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget _showLogo() {
    return Image.asset('assets/images/icon.jpeg', width: 75, height: 75);
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
                            fontSize: 13,
                           ),
                        ),
    );
}

  Widget _showUserNameInput(AuthenticationBloc bloc) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
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
            )
            
            ),
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
                      //shape: BoxShape.rectangle, 
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
    return
       Container(
          height: 50.0,
          margin: EdgeInsets.symmetric(horizontal: 50),
          decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(color: Colors.black12, offset: Offset(4, 4), blurRadius: 10),
                        BoxShadow(color: Colors.black12, offset: Offset(-4, -4), blurRadius: 10),
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
         ),           
          
        );
        
  }

  Widget _showLoginSetting(AuthenticationBloc bloc) {
    return 
        SizedBox(
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
