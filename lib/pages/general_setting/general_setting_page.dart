import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ncf_app/bloc_helpers/bloc_provider.dart';
import 'package:ncf_app/blocs/authentication/authentication_bloc.dart';
import 'package:ncf_app/blocs/global_bloc.dart';
import 'package:ncf_app/pages/download_page.dart';
import 'package:ncf_app/widgets/set_colors.dart';
import 'package:uuid/uuid.dart';
import 'package:ncf_app/blocs/authentication/authentication_event.dart';

class GeneralSetting extends StatefulWidget {
  @override
  _GeneralSettingState createState() => _GeneralSettingState();
}

class _GeneralSettingState extends State<GeneralSetting> {
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
            backgroundColor: Colors.blue,
            leading: Icon(
              Icons.adjust,
              color: Colors.blue[100],
            ),
            expandedHeight: 200,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
            //  background: ,
            ),
          ),
          SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                        leading: Icon(
                          Icons.file_download,
                          color: Colors.blue,
                        ),
                        title: Text('Sync'),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
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
                          authenticationBloc
                              .emitEvent(AuthenticationEventLogout());
                        },
                      )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
