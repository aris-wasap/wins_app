import 'package:flutter/material.dart';
import 'package:ncf_app/bloc_widgets/bloc_state_builder.dart';
import 'package:ncf_app/blocs/download/download_bloc.dart';
import 'package:ncf_app/blocs/download/download_event.dart';
import 'package:ncf_app/blocs/download/download_state.dart';

class DownloadPage extends StatefulWidget {
  @override
  _DownloadPageState createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  DownloadBloc bloc = DownloadBloc();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    bloc?.dispose();

    super.dispose();
  }

  Widget _showCircularProgress() {
    var state = bloc.lastState ?? bloc.initialState;
    if (state.isBusy) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  void _errorMessage() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String errorMessage = _getState().errorMessage;
      if ((errorMessage != null) && (errorMessage != "")) {
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error : '),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text("${errorMessage}"),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    bloc.emitEvent(DownloadEvent(
                      event: DownloadEventType.normal,
                    ));
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  void _doneMessage() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String successMessage = _getState().successMessage;
      if ((successMessage != null) && (successMessage != "")) {
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Info'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text("${successMessage}"),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    bloc.emitEvent(DownloadEvent(
                      event: DownloadEventType.normal,
                    ));
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  Widget _buildForm() {
    _errorMessage();
    _doneMessage();
    return Center(
      child: IntrinsicWidth(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RaisedButton(
              child: Text("All"),
              onPressed: () {
                bloc.emitEvent(DownloadEvent(
                  event: DownloadEventType.all,
                ));
              },
            ), 
            RaisedButton(
              child: Text("Warehouse"),
              onPressed: () {
                bloc.emitEvent(DownloadEvent(
                  event: DownloadEventType.warehouse,
                ));
              },
            ), 
          ],
        ),
      ),
    );
  }

  DownloadState _getState() {
    return (bloc.lastState ?? bloc.initialState);
  }

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<DownloadState>(
        bloc: bloc,
        builder: (BuildContext context, DownloadState state) {
          return SafeArea(
            child: Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                title: Text("Download"),
                backgroundColor: Colors.blue[900],
                bottom: PreferredSize(
                  child: Container(
                    color: Colors.yellow[900],
                    height: 5.0,
                  ),
                  preferredSize: Size.fromHeight(5.0)
                )
              ),
              body: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [const Color(0xfff9fbe7), const Color(0xffd7ccc8)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                ),
                child: Stack(
                  children: <Widget>[
                    _buildForm(),
                    _showCircularProgress(),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
