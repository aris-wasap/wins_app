import 'package:flutter/material.dart';
import 'package:wins_app/bloc_widgets/bloc_state_builder.dart';
import 'package:wins_app/blocs/download/download_bloc.dart';
import 'package:wins_app/blocs/download/download_event.dart';
import 'package:wins_app/blocs/download/download_state.dart';
import 'package:wins_app/widgets/set_colors.dart';

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

  Widget _listDownload() {
    _errorMessage();
    _doneMessage();
    final List<String> entries = <String>['Sync All', 'Warehouse'];
    final List<int> colorCodes = <int>[500, 500];
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          decoration: BoxDecoration(
            //color: Colors.orange[colorCodes[index]],
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, offset: Offset(4, 4), blurRadius: 2),
              BoxShadow(
                  color: Colors.black12, offset: Offset(-4, -4), blurRadius: 2),
            ],
          ),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            color: Colors.orange[colorCodes[index]],
            child: InkWell(
              child: Center(
                  child: Text('${entries[index]}',
                      style: TextStyle(
                          color: bgWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.w600))),
              onTap: () {
                if (index == 0) {
                  bloc.emitEvent(DownloadEvent(
                    event: DownloadEventType.all,
                  ));
                } else if (index == 1) {
                  bloc.emitEvent(DownloadEvent(
                    event: DownloadEventType.warehouse,
                  ));
                }
              },
            ),
          ),
          //child: Center(child: Text('${entries[index]}', style: TextStyle(color: bgWhite, fontSize: 18, fontWeight: FontWeight.w600),)),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  Widget _buildForm() {
    _errorMessage();
    _doneMessage();
    return Center(
      child: Container(
        child: Column(
          children: <Widget>[
            _listDownload(),
          ],
        ),
      ),
      // child: IntrinsicWidth(
      //   child: Container(
      //     //mainAxisAlignment: MainAxisAlignment.start,
      //     ///crossAxisAlignment: CrossAxisAlignment.stretch,
      //     child: Column(
      //        mainAxisAlignment: MainAxisAlignment.start,
      //       crossAxisAlignment: CrossAxisAlignment.stretch,
      //       children: <Widget>[
      //       //_listDownload(),
      //       SizedBox(height: 10,),
      //       RaisedButton(
      //         child: Text("All"),
      //         onPressed: () {
      //           bloc.emitEvent(DownloadEvent(
      //             event: DownloadEventType.all,
      //           ));
      //         },
      //       ),
      //       RaisedButton(
      //         child: Text("Warehouse"),
      //         onPressed: () {
      //           bloc.emitEvent(DownloadEvent(
      //             event: DownloadEventType.warehouse,
      //           ));
      //         },
      //       ),
      //     ],
      //     ),

      //   ),
      // ),
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
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      gradient: bgGradientAppBar,
                    ),
                  ),
                  title: Text("Download"),
                  //backgroundColor: bgBlue,

                  bottom: PreferredSize(
                      child: Container(
                        color: bgBlue,
                        height: 5.0,
                      ),
                      preferredSize: Size.fromHeight(5.0))),
              body: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(gradient: bgGradientPageWhite),
                child: Stack(
                  children: <Widget>[
                    _listDownload(),
                    //_buildForm(),
                    _showCircularProgress(),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
