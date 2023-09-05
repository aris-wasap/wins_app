import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wins_app/bloc_helpers/bloc_provider.dart';
import 'package:wins_app/blocs/authentication/authentication_bloc.dart';
import 'package:wins_app/blocs/global_bloc.dart';
import 'package:wins_app/pages/download_page.dart';
import 'package:wins_app/widgets/set_colors.dart';
import 'package:uuid/uuid.dart';
import 'package:wins_app/blocs/authentication/authentication_event.dart';

class GeneralSetting extends StatefulWidget {
  @override
  _GeneralSettingState createState() => _GeneralSettingState();
}

class _GeneralSettingState extends State<GeneralSetting> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    var mediaQueryData = MediaQuery.of(context);
    final double widthScreen = mediaQueryData.size.width;
    final double heightScreen = mediaQueryData.size.height;
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: Icon(
              Icons.adjust,
              color: Colors.blue[100],
            ),
            expandedHeight: 100,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
                //  background: ,
                ),
          ),
          SliverFillRemaining(
            child: Stack(
              children: <Widget>[
                Card(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 75.0, left: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 5),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Url ",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  "Role",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  "Branch ",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 5),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  ": ",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  ": ",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  ": ",
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 5),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${globalBloc.getDatabaseName()}",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  "${globalBloc.roleName}",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  "${globalBloc.branchName}",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                ),
                Positioned(
                  top: 25,
                  left: .0,
                  right: 10,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: InkWell(
                                onTap: () async {
                                  if (await confirm(context)) {
                                    authenticationBloc
                                        .emitEvent(AuthenticationEventLogout());
                                  }
                                },
                                child:
                                    Icon(Icons.exit_to_app, color: Colors.red)),
                          ),
                          Container(
                            child: Text(
                              'Log-out',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: .0,
                  left: .0,
                  right: .0,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(.4),
                          radius: 40.0,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/profil.png'),
                            radius: 38,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${globalBloc.userName}",
                          style: Theme.of(context).textTheme.subhead,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// class _GeneralSettingState extends State<GeneralSetting> {
//   @override
//   Widget build(BuildContext context) {
//     AuthenticationBloc authenticationBloc =
//         BlocProvider.of<AuthenticationBloc>(context);
//     var mediaQueryData = MediaQuery.of(context);
//     final double widthScreen = mediaQueryData.size.width;
//     final double heightScreen = mediaQueryData.size.height;
//     return Container(
//       child: CustomScrollView(
//         slivers: <Widget>[
//           SliverAppBar(
//             elevation: 0,
//             backgroundColor: Colors.transparent,
//             leading: Icon(
//               Icons.adjust,
//               color: Colors.blue[100],
//             ),
//             expandedHeight: 100,
//             pinned: true,
//             floating: true,
//             flexibleSpace: FlexibleSpaceBar(
//                 //  background: ,
//                 ),
//           ),
//           SliverFillRemaining(
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   Card(
//                     child: Column(
//                       children: <Widget>[
//                         //   ListTile(
//                         //   leading: Icon(
//                         //     Icons.file_download,
//                         //     color: Colors.blue,
//                         //   ),
//                         //   title: Text('Sync'),
//                         //   onTap: () {
//                         //     Navigator.push(context, MaterialPageRoute(
//                         //         builder: (BuildContext context) {
//                         //       return DownloadPage();
//                         //     }));
//                         //   },
//                         // ),
//                         Divider(
//                           height: 2.0,
//                         ),
//                         ListTile(
//                           leading: Icon(
//                             Icons.exit_to_app,
//                             color: Colors.orange[500],
//                           ),
//                           title: Text('Log-Out'),
//                           onTap: () {
//                             authenticationBloc
//                                 .emitEvent(AuthenticationEventLogout());
//                           },
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
