import 'package:flutter/material.dart';
import 'package:admart_app/bloc_helpers/bloc_provider.dart';
import 'package:admart_app/blocs/authentication/authentication_bloc.dart';
import 'package:admart_app/pages/authentication_page.dart';
import 'package:admart_app/pages/home_page.dart';
import 'package:admart_app/pages/initialization_page.dart';
import 'package:admart_app/pages/decision_page.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      bloc: AuthenticationBloc(),
      child: MaterialApp(
        title: "ADMART",
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
