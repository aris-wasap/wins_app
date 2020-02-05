import 'package:flutter/material.dart';
import 'package:ncf_app/bloc_helpers/bloc_provider.dart';
import 'package:ncf_app/blocs/authentication/authentication_bloc.dart';
import 'package:ncf_app/pages/authentication_page.dart';
import 'package:ncf_app/pages/home_page.dart';
import 'package:ncf_app/pages/initialization_page.dart';
import 'package:ncf_app/pages/decision_page.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      bloc: AuthenticationBloc(),
      child: MaterialApp(
        title: "NCF",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            //hintColor: Colors.blue,
            inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(color: Colors.blue),
            )),
        routes: {
          '/decision': (BuildContext context) => DecisionPage(),
          '/home': (BuildContext context) => HomePage(),
          '/authentication': (BuildContext context) => AuthenticationPage(),
        },
        home: InitializationPage(),
      ),
    );
  }
}
