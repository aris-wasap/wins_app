import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ncf_app/pages/download_page.dart';
import 'package:ncf_app/pages/general_setting/general_setting_page.dart';
import 'package:ncf_app/pages/home_menu.dart';
import 'package:ncf_app/pages/icon_color.dart';
import 'package:ncf_app/pages/option_card.dart';
import 'package:ncf_app/pages/receipt_production/receipt_production_list_page.dart';

import 'package:ncf_app/pages/transfer_release/transfer_release_list_page.dart';
import 'package:flutter/material.dart';
import 'package:ncf_app/bloc_helpers/bloc_provider.dart';
import 'package:ncf_app/blocs/authentication/authentication_bloc.dart';
import 'package:ncf_app/blocs/authentication/authentication_event.dart';
import 'package:ncf_app/blocs/global_bloc.dart';
import 'package:ncf_app/widgets/set_colors.dart';
import 'package:uuid/uuid.dart';

import 'transfer_release/transfer_release_list_page.dart';
import 'receipt_production/receipt_production_list_page.dart';
import 'check_data/check_data_page.dart';

// import 'package:ncf_app/pages/transfer_request/transfer_request_list_page.dart';
// import 'package:ncf_app/pages/transfer_production/transfer_production_list_page.dart';
// import 'package:ncf_app/pages/transfer_reject/transfer_reject_list_page.dart';
// import 'transfer_reject/transfer_reject_list_page.dart';
// import 'delivery_order/delivery_order_list_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

DateTime currentBackPressTime;

class _HomePageState extends State<HomePage> {
  Future<bool> _onWillPopScope() async {
    return false;
  }

  @override
  void initState() {
    super.initState();
  }

  GlobalKey _bottomNavigationKey = GlobalKey();

  int _page = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    HomeMenuPage(),
    CheckDataPage(),
    GeneralSetting(),
  ];

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        HomeMenuPage(),
        CheckDataPage(),
        GeneralSetting(),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _page = index;
      // pageController.animateToPage(index,
      //     duration: Duration(milliseconds: 10), curve: Curves.ease);
    });
   
  }

  void pageChanged(int index) {
    setState(() {
      _page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    final double widthScreen = mediaQueryData.size.width;
    final double heightScreen = mediaQueryData.size.height;
    double sideLength = 50;

    AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: SafeArea(
        child: Scaffold(
           body: _widgetOptions.elementAt(_page),
          //body: buildPageView(),
          backgroundColor: Colors.blue[100],
          bottomNavigationBar: CurvedNavigationBar(
            height: 50,
            buttonBackgroundColor: Colors.blueGrey[500],
            backgroundColor: Colors.blue[100],
            animationCurve: Curves.ease,
           // animationDuration: Duration(milliseconds: 150),
            items: <Widget>[
              Icon(Icons.home, size: 20, color: Colors.white,),
              Icon(Icons.nfc, size: 20, color: Colors.white,),
              Icon(Icons.menu, size: 20, color: Colors.white,),
            ],
            onTap: (index) {
              _onItemTapped(index);
            },
            index: _page,
            color: bgBlue,
          ),
        ),
      ),
    );
  }
}
