import 'dart:convert';

import 'package:wins_app/blocs/receipt_branch/detail/receipt_branch_detail_bloc.dart';
import 'package:wins_app/blocs/receipt_branch/detail/receipt_branch_detail_event.dart';
import 'package:wins_app/blocs/receipt_branch/detail/receipt_branch_detail_state.dart';
import 'package:wins_app/pages/cfl/cfl_transfer_branch_page.dart';
import 'package:wins_app/pages/receipt_branch/receipt_branch_detail_item_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:wins_app/bloc_widgets/bloc_state_builder.dart';
import 'package:wins_app/blocs/global_bloc.dart';
import 'package:wins_app/models/receipt_branch_detail_response.dart';
import 'package:wins_app/widgets/validate_dialog_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:uuid/uuid.dart';
import 'package:wins_app/models/cfl_transfer_branch_response.dart'
    as cflTransferBranch;
import 'package:wins_app/pages/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:wins_app/widgets/set_colors.dart';

class ReceiptBranchDetailPage extends StatefulWidget {
  ReceiptBranchDetailPage(this._id);
  final int _id;
  @override
  _ReceiptBranchDetailPageState createState() =>
      _ReceiptBranchDetailPageState(_id);
}

class _ReceiptBranchDetailPageState extends State<ReceiptBranchDetailPage> {
  _ReceiptBranchDetailPageState(this._id);

  ReceiptBranchDetailBloc bloc = ReceiptBranchDetailBloc();
  final int _id;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController;
  final _idTxController = TextEditingController();
  final _sapReceiptBranchNoController = TextEditingController();
  final _issueIdController = TextEditingController();
  final _issueNoController = TextEditingController();
  final _seriesNameIssueController = TextEditingController();
  final _seriesNameController = TextEditingController();
  final _transNoController = TextEditingController();
  final _docNumController = TextEditingController();
  final _transDateController = TextEditingController();
  final _branchIdController = TextEditingController();
  final _branchNameController = TextEditingController();
  final _fromBranchIdController = TextEditingController();
  final _fromBranchNameController = TextEditingController();

  DateTime transDate; // = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (_id != 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bloc.emitEvent(ReceiptBranchDetailEventGetId(
          id: _id,
        ));
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        transDate = DateTime.now();
        if (transDate != null) {
          _transDateController.text =
              DateFormat("dd-MM-yyyy").format(transDate);
        }

        var serverDate = await globalBloc.getServerDate();
        if (serverDate != null) {
          transDate = serverDate;
          _transDateController.text =
              DateFormat("dd-MM-yyyy").format(transDate);
        }
      });
    }
  }

  @override
  void dispose() {
    _idTxController?.dispose();
    _sapReceiptBranchNoController?.dispose();
    _issueIdController?.dispose();
    _issueNoController?.dispose();
    _seriesNameIssueController?.dispose();
    _seriesNameController?.dispose();
    _transNoController?.dispose();
    _docNumController?.dispose();
    _transDateController?.dispose();
    _branchIdController?.dispose();
    _branchNameController?.dispose();
    _fromBranchIdController?.dispose();
    _fromBranchNameController?.dispose();

    bloc?.dispose();

    super.dispose();
  }

  void _create() {
    var state = (bloc.lastState ?? bloc.initialState);
    var data = Data(); // (bloc.lastState ?? bloc.initialState).data;
    data.issueNo = _issueNoController.text;
    data.seriesName = _seriesNameController.text;
    data.seriesNameIssue = _seriesNameIssueController.text;
    data.transDate = transDate;
    data.fromBranchName = _fromBranchNameController.text;
    data.items = state.data.items;

    if ([null].contains(data.transDate)) {
      ValidateDialogWidget(
          context: context, message: "Issue Date harus di isi");
      return;
    } else if (["", null].contains(data.issueNo)) {
      ValidateDialogWidget(context: context, message: "Issue No harus di isi");
      return;
    } else if ([null].contains(data.items)) {
      ValidateDialogWidget(
          context: context, message: "Item detail harus di isi");
      return;
    } else if ([0].contains(data.items.length)) {
      ValidateDialogWidget(
          context: context, message: "Item detail harus di isi");
      return;
    }

    data.id = _id;
    data.issueId = int.parse(_issueIdController.text);
    data.fromBranchId = int.parse(_fromBranchIdController.text);

    bloc.emitEvent(ReceiptBranchDetailEventAdd(
      data: data,
    ));
  }

  void _submit() {
    var state = (bloc.lastState ?? bloc.initialState);
    var data = Data(); // (bloc.lastState ?? bloc.initialState).data;
    data.id = int.parse(_idTxController.text);
    data.issueId = int.parse(_issueIdController.text);
    data.issueNo = _issueNoController.text;
    data.seriesName = _seriesNameController.text;
    data.transDate = transDate;
    data.fromBranchId = int.parse(_fromBranchIdController.text);
    data.fromBranchName = _fromBranchNameController.text;
    data.items = state.data.items;

    if ([null].contains(data.transDate)) {
      ValidateDialogWidget(
          context: context, message: "Issue Date harus di isi");
      return;
    } else if (["", null].contains(data.issueNo)) {
      ValidateDialogWidget(context: context, message: "Issue No harus di isi");
      return;
    } else if ([null].contains(data.items)) {
      ValidateDialogWidget(
          context: context, message: "Item detail harus di isi");
      return;
    } else if ([0].contains(data.items.length)) {
      ValidateDialogWidget(
          context: context, message: "Item detail harus di isi");
      return;
    }

    bloc.emitEvent(ReceiptBranchDetailEventPost(
      data: data,
    ));
  }

  showAlertDialogCreate(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        Navigator.of(context).pop();
        _create();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Perhatian !!!"),
      content: Text("Apakah anda yakin simpan document?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogSubmit(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        Navigator.of(context).pop();
        _submit();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Perhatian !!!"),
      content: Text("Apakah anda yakin Submit document?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _newTrans() {
    MaterialPageRoute newRoute = MaterialPageRoute(
        builder: (BuildContext context) => ReceiptBranchDetailPage(0));
    Navigator.of(context).pushReplacement(newRoute);
  }

  void _errorMessage() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String errorMessage = (bloc.lastState ?? bloc.initialState).errorMessage;
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
                    bloc.emitEvent(ReceiptBranchDetailEventNormal());
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

  void _successMessage() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String successMessage =
          (bloc.lastState ?? bloc.initialState).succesMessage;
      if ((successMessage != null) && (successMessage != "")) {
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success : '),
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
                    bloc.emitEvent(ReceiptBranchDetailEventNormal());
                    if ((bloc.lastState ?? bloc.initialState).data.id == 0) {
                      _newTrans();
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  DateTime selectTransDate = DateTime.now();
  Future<Null> _selectTransDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectTransDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != transDate) {
      transDate = picked;
      _transDateController.text = DateFormat("dd-MM-yyyy").format(transDate);
    }
  }

  PreferredSizeWidget _appBar() {
    if (_getState().data.id == 0) {
      return AppBar(
        title: Text("Draft Transfer"),
        backgroundColor: bgBlue,
        bottom: PreferredSize(
            child: Container(
              color: bgOrange,
              height: 5.0,
            ),
            preferredSize: Size.fromHeight(5.0)),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.save,
              color: Colors.yellowAccent,
            ),
            onPressed: () {
              showAlertDialogCreate(context);
            },
            textColor: Colors.white,
            label: Text("Save"),
          )
        ],
      );
    } else if (_getState().data.sapReceiptBranchId == 0 &&
        _getState().data.id > 0 &&
        _getState().data.status == "Draft") {
      return AppBar(
        title: Text(
          "Create Receipt",
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
          ),
        ),
        backgroundColor: bgBlue,
        bottom: PreferredSize(
            child: Container(
              color: bgOrange,
              height: 5.0,
            ),
            preferredSize: Size.fromHeight(5.0)),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.check_circle_outline,
              color: Colors.greenAccent,
            ),
            onPressed: () {
              showAlertDialogSubmit(context);
            },
            textColor: Colors.white,
            label: Text(
              "Submit",
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w900),
              ),
            ),
          )
        ],
      );
    } else {
      return AppBar(
        title: Text("Receipt From Branch"),
        backgroundColor: bgBlue,
        bottom: PreferredSize(
            child: Container(
              color: bgOrange,
              height: 5.0,
            ),
            preferredSize: Size.fromHeight(5.0)),
        actions: <Widget>[
          (globalBloc.loginResponse.data.receiptIssue_Auth_Add == 'Y')
              ? IconButton(
                  onPressed: () {
                    _newTrans();
                  },
                  icon: Icon(Icons.add),
                )
              : Container(),
        ],
      );
    }
  }

  ReceiptBranchDetailState _getState() {
    return bloc.lastState ?? bloc.initialState;
  }

  BuildContext _context;

  Future _scanQR() async {
    if (["", null].contains(_issueNoController.text)) {
      ValidateDialogWidget(context: context, message: "Issue No harus di isi");
      return;
    }
    var data = _getState().data;

    try {
      String qrResult = await BarcodeScanner.scan();
      for (var item in _getState().data.items) {
        // if (("${item.itemCode}-${item.batchNo}" == qrResult)) {
        if (("${item.batchNo}" == qrResult)) {
          ValidateDialogWidget(
              context: context,
              message:
                  'Item Batch Number : ${item.batchNo} sudah pernah di scan');
          return;
        }
      }

      bloc.emitEvent(ReceiptBranchDetailEventScan(
          issueId: int.parse(_issueIdController.text),
          issueNo: _issueNoController.text,
          qrResult: qrResult,
          data: data));

      // bloc
      //     .eventHandler(
      //         ReceiptBranchDetailEventScan(
      //             issueId: int.parse(_issueIdController.text),
      //             qrResult: qrResult,
      //             data: data),
      //         _getState())
      //     .listen((onData) {
      //   if (onData.newItem != null) {
      //     Future<Item> item = Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (BuildContext context) =>
      //             ReceiptBranchDetailItemDetailPage(onData.newItem),
      //       ),
      //     );

      //     item.then((Item item) {
      //       if (item != null) {
      //         bloc.emitEvent(ReceiptBranchDetailEventItemAdd(
      //           item: item,
      //         ));
      //       }
      //     });
      //   }
      // });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        ValidateDialogWidget(
            context: context, message: "Scan : Camera permition was denied");
        return;
      } else {
        ValidateDialogWidget(
            context: context, message: "Scan : Unknown error $ex");
        return;
      }
    } on FormatException {
      // ValidateDialogWidget(
      //     context: context,
      //     message: "Scan : You press back button before scan");
      return;
    } catch (ex) {
      ValidateDialogWidget(
          context: context, message: "Scan : Unknown error $ex");
      return;
    }
  }

  void _showScanNewItemDetail() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var newItem = _getState().newItem;
      if (newItem != null) {
        bloc.emitEvent(ReceiptBranchDetailEventNormal());
        Future<Item> item = Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                ReceiptBranchDetailItemDetailPage(newItem),
          ),
        );

        item.then((Item item) {
          if (item != null) {
            bloc.emitEvent(ReceiptBranchDetailEventItemAdd(
              item: item,
            ));
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    var data = _getState().data;

    return BlocEventStateBuilder<ReceiptBranchDetailState>(
        bloc: bloc,
        builder: (BuildContext context, ReceiptBranchDetailState state) {
          return SafeArea(
            child: Scaffold(
              key: _scaffoldKey,
              appBar: _appBar(),
              body: Container(
                color: Colors.blue[100],
                // constraints: BoxConstraints.expand(),
                //height: MediaQuery.of(context).size.height,
                // decoration: BoxDecoration(
                //   gradient: bgGradientPageWhite,
                // ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: Card(
                    child: Stack(children: <Widget>[
                      SingleChildScrollView(
                        padding: EdgeInsets.all(0.0),
                        child: _buildForm(),
                      ),
                      _showCircularProgress(),
                    ]),
                  ),
                ),
              ),
              floatingActionButton: _getState().data.sapReceiptBranchId == 0
                  ? FloatingActionButton.extended(
                      icon: Icon(Icons.camera_alt),
                      backgroundColor: btnBgOrange,
                      label: Text("Scan"),
                      onPressed: () {
                        _scanQR();
                      },
                    )
                  : null,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              // bottomNavigationBar: data.id == 0
              //     ? BottomAppBar(
              //         color: Colors.blue,
              //         child: Row(
              //           mainAxisSize: MainAxisSize.max,
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: <Widget>[
              //             FlatButton(
              //               onPressed: () {
              //                 // _showChooseItems();
              //               },
              //               textColor: Colors.white,
              //               child: Row(
              //                 children: <Widget>[Text("CHOOSE ITEM")],
              //               ),
              //             ),
              //           ],
              //         ),
              //       )
              //     : null,
            ),
          );
        });
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

  void _showItemDetail(int itemIndex) {
    final items = _getState().data.items;
    Future<Item> item = Navigator.push(
      context,
      MaterialPageRoute<Item>(
        builder: (BuildContext context) =>
            ReceiptBranchDetailItemDetailPage(items[itemIndex]),
      ),
    );

    item.then((Item item) {
      if (item != null) {
        bloc.emitEvent(ReceiptBranchDetailEventItemUpdate(
          item: item,
          itemIndex: itemIndex,
        ));
      }
    });
  }

  Widget _buildForm() {
    _errorMessage();
    _successMessage();
    _showScanNewItemDetail();
    var state = bloc.lastState ?? bloc.initialState;
    var data = state.data;
    _transNoController.text = data.transNo;
    _branchIdController.text = globalBloc.branchId.toString();
    _branchNameController.text = globalBloc.branchName;

    //jika nama signature berbah di kasih tanda

    if (data.id != 0) {
      _idTxController.text = data.id.toString();
      _sapReceiptBranchNoController.text = data.sapReceiptBranchNo;
      _issueIdController.text = data.issueId.toString();
      _seriesNameController.text = data.seriesName;
      _issueNoController.text = data.issueNo;
      _branchIdController.text = data.branchId.toString();
      _branchNameController.text = data.branchName;
      _fromBranchIdController.text = data.fromBranchId.toString();
      _fromBranchNameController.text = data.fromBranchName;
      transDate = data.transDate;
      if (transDate != null) {
        _transDateController.text = DateFormat("dd-MM-yyyy").format(transDate);
      } else {
        _transDateController.text = null;
      }
    }

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _sapReceiptBranchNoController,
                  enabled: false,
                  decoration: InputDecoration(
                      hintText: "Receipt No.",
                      labelText: "Receipt No.",
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                ),
                Padding(padding: EdgeInsets.only(top: 5)),
                TextFormField(
                    controller: _transNoController,
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: "Scan No.",
                        labelText: "Scan No.",
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0)))),

                Padding(padding: EdgeInsets.only(top: 5)),
                TextFormField(
                  controller: _branchNameController,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: "Branch",
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10.0),
                    border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                  ),
                ),
                FlatButton(
                  padding: EdgeInsets.only(top: 5),
                  onPressed: () {
                    if (data.id == 0) {
                      _selectTransDate(context);
                    }
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                            controller: _transDateController,
                            enabled: false,
                            decoration: InputDecoration(
                                hintText: "Receipt Date",
                                labelText: "Receipt Date",
                                contentPadding: new EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 10.0),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: (data.id == 0)
                                            ? Colors.blue
                                            : Colors.grey[400]),
                                    borderRadius: new BorderRadius.circular(
                                      10.0,
                                    )))
                            // decoration: InputDecoration(
                            //   labelText: "DO Date",
                            //   disabledBorder: UnderlineInputBorder(
                            //     borderSide: data.id == 0
                            //         ? BorderSide(color: Colors.blue)
                            //         : BorderSide(color: Colors.grey),
                            //   ),
                            // ),
                            ),
                      ),
                      (data.id == 0)
                          ? Icon(
                              Icons.date_range,
                            )
                          : Container(width: 0, height: 0),
                    ],
                  ),
                ),

                FlatButton(
                  padding: EdgeInsets.only(top: 5),
                  onPressed: () {
                    if (data.id == 0) {
                      Future<cflTransferBranch.Data> gi = Navigator.push(
                          context,
                          MaterialPageRoute<cflTransferBranch.Data>(
                              builder: (BuildContext context) =>
                                  CflTransferBranchPage()));

                      gi.then((cflTransferBranch.Data gi) {
                        setState(() {
                          if (gi != null) {
                            _issueIdController.text = gi.id.toString();
                            _issueNoController.text = gi.transNo;
                            _fromBranchIdController.text =
                                gi.branchId.toString();
                            _fromBranchNameController.text = gi.branchName;
                            _seriesNameIssueController.text = gi.seriesName;
                          }
                        });
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 5, top: 5),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: (data.id == 0)
                                ? Colors.blue
                                : Colors.grey[400]),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Issue No.",
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 12.0),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.only(left: 5),
                                title: Text(_issueNoController.text),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(_fromBranchNameController.text),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        (data.id == 0)
                            ? Icon(
                                Icons.keyboard_arrow_right,
                              )
                            : Container(width: 0, height: 0),
                      ],
                    ),
                  ),
                ),
                // FlatButton(
                //   padding: EdgeInsets.only(top: 5),
                //   onPressed: () {
                //     if (data.id == 0) {}
                //   },
                //   child: Container(
                //     padding: EdgeInsets.only(left: 5, top: 5),
                //     alignment: Alignment.centerLeft,
                //     decoration: BoxDecoration(
                //       border: Border.all(
                //         color: Colors.grey[400]
                //       ),
                //       borderRadius: BorderRadius.all(
                //           Radius.circular(10)
                //       )
                //       // border: Border(
                //       //   bottom: BorderSide(
                //       //     color: (data.id == 0) ? Colors.blue : Colors.grey,
                //       //     width: 1.0,
                //       //   ),
                //       // ),
                //     ),

                //   ),
                // ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: data.id == 0
                      ? BorderSide(
                          color: Colors.blue,
                          width: 1.0,
                        )
                      : BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                ),
              ),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("List of Items"),
                  ],
                ),
              ),
            ),
          ),
          Container(
              //color: Colors.brown,
              child:
                  ((state.data.items != null) ? state.data.items.length : 0) > 0
                      ? _buildList()
                      : Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Text("Item Empty"),
                        )),
          Container(
            height: 5,
            color: Colors.grey,
          ),
          SizedBox(
            height: 65,
          ),
        ]);
  }

  Widget _rowDetail(List<Item> data, int index) {
    return Container(
      margin: new EdgeInsets.symmetric(horizontal: 0.0, vertical: 1.0),
      decoration: BoxDecoration(
          color: Colors.grey[400].withOpacity(0.5),
          border: Border(
              bottom: BorderSide(width: 1, color: Colors.grey[500]),
              left: BorderSide(width: 5, color: Colors.blue))),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: ListTile(
          title: Text("${data[index].itemName}"),
          subtitle: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Item Code : ${data[index].itemCode}"),
              Text("Batch No. : ${data[index].batchNo}"),
              Text(
                  "Quantity : ${NumberFormat("#,###.##").format(data[index].qty)}" +
                      " ${data[index].uom}"),
              // Text(data[index].whsCode ?? ''),
              Text("From Warehouse : ${data[index].fromWhsName}"),
              Text("To Warehouse : ${data[index].whsName}"),
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.keyboard_arrow_right),
            iconSize: 30.0,
            onPressed: () {
              _showItemDetail(index);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    var state = bloc.lastState ?? bloc.initialState;
    final data = state.data.items;

    return ListView.builder(
      controller: _scrollController,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (contex, index) {
        if (_getState().data.sapReceiptBranchId == 0) {
          return Dismissible(
            key: Key(data[index].hashCode.toString()),
            onDismissed: (direction) {
              bloc.emitEvent(
                  ReceiptBranchDetailEventItemRemove(itemIndex: index));
            },
            background: Container(
                color: Colors.red,
                child: Align(
                    child: Text('Delete',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)))),
            child: _rowDetail(data, index),
          );
        } else {
          return _rowDetail(data, index);
        }
      },
    );
  }
}
