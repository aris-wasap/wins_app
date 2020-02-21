import 'package:ncf_app/pages/download_page.dart';
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

  

int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    HomeMenuPage(),
    CheckDataPage(),
    // Text(
    //   'Profile',
    //   style: optionStyle,
    // ),
  ];

 
void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    var mediaQueryData = MediaQuery.of(context);
    final double widthScreen = mediaQueryData.size.width;
    final double heightScreen = mediaQueryData.size.height;
    
    
    AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: SafeArea(
        child: Scaffold(
          drawer: Drawer(
            elevation: 20.0,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Center(
                  child: UserAccountsDrawerHeader(
                    accountName: Text(globalBloc.userName),
                    accountEmail: Text(''),
                    currentAccountPicture: ClipOval(
                      child: Image.network(
                        globalBloc.getUrl() +
                            "api/UserApi/GetImage?id=${globalBloc.userId}&guid=${Uuid().v4().toString()}",
                      ),
                    ),
                    decoration: BoxDecoration(
                        gradient: bgInversGradientAppBar,
                        border: Border(
                            bottom: BorderSide(
                                color: bgBlue,
                                width: 5.0,
                                style: BorderStyle.solid))),
                  ),
                ),
                // ListTile(
                //   leading: Icon(
                //     Icons.settings,
                //     color: Colors.blue,
                //   ),
                //   title: Text('General Setting'),
                //   onTap: () {
                //     Navigator.push(context,
                //         MaterialPageRoute(builder: (BuildContext context) {
                //       return GeneralSettingPage();
                //     }));
                //   },
                // ),
                Divider(
                  height: 2.0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.file_download,
                    color: Colors.blue,
                  ),
                  title: Text('Sync'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return DownloadPage();
                    }));
                  },
                ),
                Divider(
                  height: 2.0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Colors.orange[500],
                  ),
                  title: Text('Log-Out'),
                  onTap: () {
                    authenticationBloc.emitEvent(AuthenticationEventLogout());
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
              //title: Text("Hi "+ globalBloc.userName + " , Welcome" ),
              flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: bgGradientAppBar,
              ),
            ),
            actions: <Widget>[
            Container(
              //height: 2,
                        //margin: EdgeInsets.symmetric(horizontal: 50),
                        decoration: BoxDecoration(
                          //color: Colors.red[800],
                          borderRadius: BorderRadius.circular(0)
                        ),
              child: FlatButton.icon(
              label: Text('LOG-OUT'),
              icon: Icon( Icons.exit_to_app),
              onPressed: () async {
                authenticationBloc.emitEvent(AuthenticationEventLogout());
              },
              textColor: Colors.white,
             
            ),)
          ],
            //backgroundColor: Colors.blue[900],
            bottom: PreferredSize(
              child: Container(
                color: bgBlue,
                height: 5.0,
              ),
              preferredSize: Size.fromHeight(5.0)
            ),
          ),
          
         body: _widgetOptions.elementAt(_selectedIndex), //Botton Navigation Select
        
         backgroundColor: Colors.blue[100] , // Background Menu
         bottomNavigationBar: BottomNavigationBar(
            backgroundColor: bgWhite,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blue[800],
            
            onTap: _onItemTapped,
            items: [
                  BottomNavigationBarItem(
                    icon: new Icon(Icons.home),
                    title: new Text('Home'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.nfc),
                    title: new Text('Stock'),
                  ),
                  // BottomNavigationBarItem(
                  //   icon: Icon(Icons.person),
                  //   title: Text('Profile')
                  // )
                ],
                
         ),
        ),
      
      ),
    );
  }
}
