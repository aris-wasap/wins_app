import 'package:flutter/material.dart';
import 'package:wins_app/pages/barcode_scan.dart';
// import 'package:wins_app/blocs/trf_release/detail/trf_release_detail_bloc.dart';
// import 'package:wins_app/blocs/trf_release/detail/trf_release_detail_event.dart';
// import 'package:wins_app/blocs/trf_release/detail/trf_release_detail_state.dart';
import 'package:wins_app/widgets/validate_dialog_widget.dart';

class NewTrfRelease extends StatefulWidget {
  @override
  _NewTrfReleaseState createState() => _NewTrfReleaseState();
}

class _NewTrfReleaseState extends State<NewTrfRelease> {
  final _itemCodeController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _itemCodeController?.dispose();

    super.dispose();
  }

  // TrfReleaseDetailState _gestState() {
  //   return bloc.lastState ?? bloc.initialState;
  // }

  Future _scanQR() async {
    //var data = _getState().data;

    try {
      String qrResult = await BarcodeScanner.scan();
      // for (var item in _getState().data.items) {
      //   if (("${item.itemCode}-${item.batchNo}" == qrResult)) {
      //     ValidateDialogWidget(
      //         context: context, message: 'Item sudah pernah di scan');
      //     return;
      //   }
      // }

      // bloc.emitEvent(DeliveryOrderDetailEventScan(
      //     soId: int.parse(_soIdController.text),
      //     qrResult: qrResult,
      //     data: data));
    }
    // on PlatformException catch (ex) {
    //   if (ex.code == BarcodeScanner.CameraAccessDenied) {
    //     ValidateDialogWidget(
    //         context: context, message: "Scan : Camera permition was denied");
    //     return;
    //   } else {
    //     ValidateDialogWidget(
    //         context: context, message: "Scan : Unknown error $ex");
    //     return;
    //   }
    // }
    // on FormatException {
    //   ValidateDialogWidget(
    //       context: context,
    //       message: "Scan : You press back button before scan");
    //   return;
    // }
    catch (ex) {
      ValidateDialogWidget(
          context: context, message: "Scan : Unknown error $ex");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("New Transfer Release"),
          backgroundColor: Colors.blue[900],
          bottom: PreferredSize(
              child: Container(
                color: Colors.yellow[900],
                height: 5.0,
              ),
              preferredSize: Size.fromHeight(5.0)),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.photo_camera),
            ),
          ],
        ),
        body: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [const Color(0xfff9fbe7), const Color(0xffd7ccc8)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        enabled: false,
                        decoration: InputDecoration(labelText: "Trans No."),
                      ),
                      FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {},
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  labelText: "Date",
                                  disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.date_range,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.blue,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Container(
                      decoration: new BoxDecoration(
                          border: new Border.all(color: Colors.grey)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "List of Items",
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                FloatingActionButton.extended(
                  icon: Icon(Icons.camera_alt),
                  backgroundColor: Colors.orange[700],
                  label: Text("Scan"),
                  onPressed: () {
                    _scanQR();
                  },
                ),
              ],
            )));
  }
}
