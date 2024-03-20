import 'dart:convert';

import 'package:shimmer/shimmer.dart';
import 'package:wins_app/pages/cfl/cfl_db_warehouse_page.dart';
import 'package:wins_app/pages/cfl/cfl_binlocation_page.dart';
import 'package:wins_app/pages/cfl/cfl_transfer_request_page.dart';
import 'package:wins_app/pages/cfl/cfl_warehouse_page.dart';
import 'package:wins_app/pages/inventory_transfer/inventory_transfer_detail_item_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:wins_app/bloc_widgets/bloc_state_builder.dart';
import 'package:wins_app/blocs/inventory_transfer/detail/inventory_transfer_detail_bloc.dart';
import 'package:wins_app/blocs/inventory_transfer/detail/inventory_transfer_detail_event.dart';
import 'package:wins_app/blocs/inventory_transfer/detail/inventory_transfer_detail_state.dart';
import 'package:wins_app/blocs/global_bloc.dart';
import 'package:wins_app/models/inventory_transfer_detail_response.dart';
import 'package:wins_app/widgets/set_colors.dart';
import 'package:wins_app/widgets/validate_dialog_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:uuid/uuid.dart';
import 'package:wins_app/models/cfl_db_warehouse_model.dart' as cflDbWarehouse;
import 'package:wins_app/pages/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:wins_app/models/cfl_binlocation_response.dart'
    as cflBinLocation;
import 'package:wins_app/models/cfl_transfer_request_response.dart'
    as cflTransferRequest;
import 'package:wins_app/models/cfl_warehouse_response.dart' as cflWarehouse;
import 'package:wins_app/models/cfl_binlocation_response.dart'
    as cflBinLocation;
import 'package:audioplayers/audio_cache.dart';

class InventoryTransferDetailPage extends StatefulWidget {
  InventoryTransferDetailPage(this._id);
  final int _id;
  @override
  _InventoryTransferDetailPageState createState() =>
      _InventoryTransferDetailPageState(_id);
}

class _InventoryTransferDetailPageState
    extends State<InventoryTransferDetailPage> {
  _InventoryTransferDetailPageState(this._id);

  InventoryTransferDetailBloc bloc = InventoryTransferDetailBloc();
  final int _id;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController;
  final _idTxController = TextEditingController();
  final _sapInventoryTransferNoController = TextEditingController();
  final _transNoController = TextEditingController();
  final _requestNoController = TextEditingController();
  final _requestIdController = TextEditingController();
  final _transDateController = TextEditingController();
  final _fromWhsCodeController = TextEditingController();
  final _fromWhsNameController = TextEditingController();
  final _fromAbsEntryController = TextEditingController();
  final _fromBinCodeController = TextEditingController();
  final _toBranchIdController = TextEditingController();
  final _toBranchNameController = TextEditingController();
  final _toWhsCodeController = TextEditingController();
  final _toWhsNameController = TextEditingController();
  final _toAbsEntryController = TextEditingController();
  final _toBinCodeController = TextEditingController();
  final _commentsController = TextEditingController();
  final _statusController = TextEditingController();
  final _player = AudioCache();

  DateTime transDate; // = DateTime.now();

  bool isVisible = true;
  bool _showAllRow = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (_id != 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bloc.emitEvent(InventoryTransferDetailEventGetId(
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
    _sapInventoryTransferNoController?.dispose();
    _requestIdController?.dispose();
    _requestNoController?.dispose();
    _transNoController?.dispose();
    _transDateController?.dispose();
    _fromWhsCodeController?.dispose();
    _fromWhsNameController?.dispose();
    _toBranchIdController?.dispose();
    _toBranchNameController?.dispose();
    _toWhsCodeController?.dispose();
    _toWhsNameController?.dispose();
    _toAbsEntryController?.dispose();
    _toBinCodeController?.dispose();
    _commentsController?.dispose();
    _statusController?.dispose();

    bloc?.dispose();

    super.dispose();
  }

  void _create() {
    var state = (bloc.lastState ?? bloc.initialState);
    var data = Data(); // (bloc.lastState ?? bloc.initialState).data;
    data.requestNo = _requestNoController.text;
    data.transDate = transDate;
    data.fromWhsCode = _fromWhsCodeController.text;
    data.fromWhsName = _fromWhsNameController.text;
    data.fromBinCode = _fromBinCodeController.text;
    data.toBranchName = _toBranchNameController.text;
    data.toWhsCode = _toWhsCodeController.text;
    data.toWhsName = _toWhsNameController.text;
    data.toBinCode = _toBinCodeController.text;
    data.comments = _commentsController.text;

    data.items = state.data.items;

    if ([null].contains(data.transDate)) {
      ValidateDialogWidget(
          context: context, message: "Transfer Date harus di isi");
      return;
    } else if ([null, ""].contains(data.fromWhsCode)) {
      ValidateDialogWidget(
          context: context, message: "From Warehouse harus di isi");
      return;
    } else if ([null, ""].contains(data.fromBinCode)) {
      ValidateDialogWidget(
          context: context, message: "From Bin Location harus di isi");
      return;
    } else if ([null, ""].contains(data.toWhsCode)) {
      ValidateDialogWidget(
          context: context, message: "To Warehouse harus di isi");
      return;
    } else if ([null, ""].contains(data.toBinCode)) {
      ValidateDialogWidget(
          context: context, message: "To Bin Location harus di isi");
      return;
    }
    //else if ([null].contains(data.items)) {
    //   ValidateDialogWidget(
    //       context: context, message: "Item detail harus di isi");
    //   return;
    // } else if ([0].contains(data.items.length)) {
    //   ValidateDialogWidget(
    //       context: context, message: "Item detail harus di isi");
    //   return;
    // }
    data.id = _id;

    data.fromAbsEntry = int.parse(_fromAbsEntryController.text);
    data.toAbsEntry = int.parse(_toAbsEntryController.text);
    data.toBranchId = int.parse(_toBranchIdController.text);

    if (_requestIdController.text == "" || _requestIdController.text == null) {
      data.requestId = 0;
    } else {
      data.requestId = int.parse(_requestIdController.text);
    }

    bloc.emitEvent(InventoryTransferDetailEventAdd(
      data: data,
    ));
  }

  void _update() {
    var state = (bloc.lastState ?? bloc.initialState);
    var data = Data(); // (bloc.lastState ?? bloc.initialState).data;
    data.transDate = transDate;
    //data.id = _id;
    data.id = int.parse(_idTxController.text);
    data.requestNo = _requestNoController.text;
    data.fromWhsCode = _fromWhsCodeController.text;
    data.fromWhsName = _fromWhsNameController.text;
    data.fromBinCode = _fromBinCodeController.text;
    data.toBranchName = _toBranchNameController.text;
    data.toWhsCode = _toWhsCodeController.text;
    data.toWhsName = _toWhsNameController.text;
    data.toBinCode = _toBinCodeController.text;
    data.comments = _commentsController.text;
    data.items = state.data.items;

    if ([null].contains(data.transDate)) {
      ValidateDialogWidget(
          context: context, message: "Transfer Date harus di isi");
      return;
    } else if ([null, ""].contains(data.fromWhsCode)) {
      ValidateDialogWidget(
          context: context, message: "From Warehouse harus di isi");
      return;
    } else if ([null, ""].contains(data.fromBinCode)) {
      ValidateDialogWidget(
          context: context, message: "From Bin Location harus di isi");
      return;
    } else if ([null, ""].contains(data.toWhsCode)) {
      ValidateDialogWidget(
          context: context, message: "To Warehouse harus di isi");
      return;
    } else if ([null, ""].contains(data.toBinCode)) {
      ValidateDialogWidget(
          context: context, message: "To Bin Location harus di isi");
      return;
    }

    data.fromAbsEntry = int.parse(_fromAbsEntryController.text);
    data.toAbsEntry = int.parse(_toAbsEntryController.text);
    data.toBranchId = int.parse(_toBranchIdController.text);

    if (_requestIdController.text == "" || _requestIdController.text == null) {
      data.requestId = 0;
    } else {
      data.requestId = int.parse(_requestIdController.text);
    }

    bloc.emitEvent(InventoryTransferDetailEventUpdate(
      data: data,
    ));
  }

  void _updateTransDate() {
    var state = (bloc.lastState ?? bloc.initialState);
    var data = Data(); //state.data;

    data.id = int.parse(_idTxController.text);
    data.transDate = transDate;
    data.items = state.data.items;

    if ([null].contains(data.transDate)) {
      ValidateDialogWidget(
          context: context, message: "Transfer Date harus di isi");
      return;
    }
    //else if ([null, ""].contains(data.fromWhsCode)) {
    //   ValidateDialogWidget(
    //       context: context, message: "From Warehouse harus di isi");
    //   return;
    // } else if ([null, ""].contains(data.fromBinCode)) {
    //   ValidateDialogWidget(
    //       context: context, message: "From Bin Location harus di isi");
    //   return;
    // } else if ([null, ""].contains(data.toWhsCode)) {
    //   ValidateDialogWidget(
    //       context: context, message: "To Warehouse harus di isi");
    //   return;
    // } else if ([null, ""].contains(data.toBinCode)) {
    //   ValidateDialogWidget(
    //       context: context, message: "To Bin Location harus di isi");
    //   return;
    // }

    String setTransDate = DateFormat("yyyy-MM-dd").format(transDate);

    bloc.emitEvent(
      InventoryTransferDetailEventUpdateTransDate(
        id: int.parse(_idTxController.text),
        transDate: setTransDate,
      ),
    );
  }

  void _submit() {
    var state = (bloc.lastState ?? bloc.initialState);
    var data = Data(); // (bloc.lastState ?? bloc.initialState).data;
    data.id = int.parse(_idTxController.text);
    data.requestNo = _requestNoController.text;
    data.transDate = transDate;
    data.fromWhsCode = _fromWhsCodeController.text;
    data.fromWhsName = _fromWhsNameController.text;
    data.fromBinCode = _fromBinCodeController.text;
    data.toBranchId = int.parse(_toBranchIdController.text);
    data.toBranchName = _toBranchNameController.text;
    data.toWhsCode = _toWhsCodeController.text;
    data.toWhsName = _toWhsNameController.text;
    data.fromAbsEntry = int.parse(_fromAbsEntryController.text);
    data.toAbsEntry = int.parse(_toAbsEntryController.text);
    data.toBinCode = _toBinCodeController.text;
    data.comments = _commentsController.text;

    data.items = state.data.items;

    if ([null].contains(data.transDate)) {
      ValidateDialogWidget(
          context: context, message: "Transfer Date harus di isi");
      return;
    } else if ([null, ""].contains(data.fromWhsCode)) {
      ValidateDialogWidget(
          context: context, message: "From Warehouse harus di isi");
      return;
    } else if ([null, ""].contains(data.toWhsCode)) {
      ValidateDialogWidget(
          context: context, message: "To Warehouse harus di isi");
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

    bloc.emitEvent(InventoryTransferDetailEventPost(
      data: data,
    ));
  }

  Future _deleteData() async {
    if ((_sapInventoryTransferNoController.text.isNotEmpty)) {
      ValidateDialogWidget(
          context: context, message: "Document tidak dapat diproses");
      return;
    }

    if ((_statusController.text == 'Cancel')) {
      ValidateDialogWidget(
          context: context,
          message: "Document tidak dapat diproses, document telah dicancel");
      return;
    }

    var data = _getState().data;

    try {
      bloc.emitEvent(
        InventoryTransferDetailEventCancel(id: data.id, data: data),
      );
    } catch (ex) {
      ValidateDialogWidget(
          context: context, message: "Delete : Unknown error $ex");
      return;
    }
  }

  Future _showAllData() async {
    var data = _getState().data;
    _showAllRow = true;

    try {
      bloc.emitEvent(
        InventoryTransferDetailEventGetId(id: data.id),
      );
    } catch (ex) {
      ValidateDialogWidget(
          context: context,
          message: "Show All Batch Number : Unknown error $ex");
      return;
    }
  }

  Future _showLessData() async {
    var data = _getState().data;
    _showAllRow = false;

    try {
      bloc.emitEvent(
        InventoryTransferDetailEventGetId(id: data.id),
      );
    } catch (ex) {
      ValidateDialogWidget(
          context: context,
          message: "Show All Batch Number : Unknown error $ex");
      return;
    }
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

  showAlertDialogDelete(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        Navigator.of(context).pop();
        _deleteData();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Perhatian !!!"),
      content: Text("Dokumen akan di cancel ?"),
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
        builder: (BuildContext context) => InventoryTransferDetailPage(0));
    Navigator.of(context).pushReplacement(newRoute);
  }

  void _errorMessage() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String errorMessage = (bloc.lastState ?? bloc.initialState).errorMessage;
      if ((errorMessage != null) && (errorMessage != "")) {
        // _player.play(
        //   'sounds/error-sound-effect.mp3',
        //   volume: 10.0,
        // );
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
                    bloc.emitEvent(InventoryTransferDetailEventNormal());
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
                    bloc.emitEvent(InventoryTransferDetailEventNormal());
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
      var state = bloc.lastState ?? bloc.initialState;
      var data = state.data;
      if (data.id > 0) {
        _update();
      }
    }
  }

  PreferredSizeWidget _appBar() {
    if (_getState().data.id == 0 && !_getState().isBusy) {
      return AppBar(
        title: Text("Draft Transfer"),
        backgroundColor: bgBlue,
        bottom: PreferredSize(
            child: Container(
              color: bgOrange,
              height: 5.0,
            ),
            preferredSize: Size.fromHeight(5.0)),
      );
    } else if (_getState().data.sapInventoryTransferId == 0 &&
        _getState().data.id > 0 &&
        _getState().data.status != "Cancel" &&
        !_getState().isBusy) {
      return AppBar(
        title: Text(
          "Create Transfer",
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
          ),
        ),
        // leading: new IconButton(
        //   icon: new Icon(Icons.ac_unit),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
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
    } else if (!_getState().isBusy) {
      return AppBar(
        title: Text("Inventory Transfer"),
        backgroundColor: bgBlue,
        bottom: PreferredSize(
            child: Container(
              color: bgOrange,
              height: 5.0,
            ),
            preferredSize: Size.fromHeight(5.0)),
        actions: <Widget>[
          (globalBloc.loginResponse.data.inventoryTransfer_Auth_Add == 'Y')
              ? IconButton(
                  onPressed: () {
                    _newTrans();
                  },
                  icon: Icon(Icons.add),
                )
              : Container(),
        ],
      );
    } else {
      return AppBar(
        title: Text("Please wait"),
        backgroundColor: bgBlue,
        bottom: PreferredSize(
            child: Shimmer.fromColors(
              baseColor: bgWhite,
              highlightColor: bgOrange,
              child: Container(
                color: bgOrange,
                height: 5.0,
              ),
            ),
            preferredSize: Size.fromHeight(5.0)),
      );
    }
  }

  InventoryTransferDetailState _getState() {
    return bloc.lastState ?? bloc.initialState;
  }

  BuildContext _context;

  Future _scanQR() async {
    // if (["", null].contains(_requestNoController.text)) {
    //   ValidateDialogWidget(
    //       context: context, message: "Transfer Request No harus di isi");
    //   return;
    // } else
    if (["", null].contains(_fromWhsCodeController.text)) {
      ValidateDialogWidget(
          context: context, message: "Warehouse from harus di isi");
      return;
    } else if (["", null].contains(_toWhsCodeController.text)) {
      ValidateDialogWidget(
          context: context, message: "Warehouse to harus di isi");
      return;
      // } else if (_fromWhsCodeController.text == _toWhsCodeController.text) {
      //   ValidateDialogWidget(
      //       context: context, message: "Warehouse from dan to tidak boleh sama");
      //   return;
    }

    _showAllRow = false;
    var data = _getState().data;

    try {
      String qrResult = await BarcodeScanner.scan();
      for (var item in _getState().data.items) {
        //if (("${item.itemCode}-${item.batchNo}" == qrResult)) {
        if (("${item.batchNo}" == qrResult)) {
          ValidateDialogWidget(
              context: context,
              message:
                  'Item Batch Number : ${item.batchNo} sudah pernah di scan');
          return;
        }
      }

      var reqId = 0;
      if (_requestIdController.text == "" ||
          _requestIdController.text == null) {
        reqId = 0;
      } else {
        reqId = int.parse(_requestIdController.text);
      }

      bloc.emitEvent(InventoryTransferDetailEventScan(
          requestId: reqId,
          requestNo: _requestNoController.text,
          whsCodeFrom: _fromWhsCodeController.text,
          absEntryFrom: int.parse(_fromAbsEntryController.text),
          binCodeFrom: _fromBinCodeController.text,
          qrResult: qrResult,
          data: data));
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
        _player.play(
          'sounds/store-scanner-beep-sound-effect.mp3',
          volume: 10.0,
        );
        bloc.emitEvent(InventoryTransferDetailEventNormal());
        Future<Item> item = Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                InventoryTransferDetailItemDetailPage(newItem),
          ),
        );

        item.then((Item item) {
          if (item != null) {
            bloc.emitEvent(InventoryTransferDetailEventItemAdd(
              item: item,
            ));

            if (_getState().data.id > 0) {
              _update();
            } else {
              _create();
            }
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    var data = _getState().data;
    return BlocEventStateBuilder<InventoryTransferDetailState>(
        bloc: bloc,
        builder: (BuildContext context, InventoryTransferDetailState state) {
          return SafeArea(
            child: Scaffold(
              key: _scaffoldKey,
              appBar: _appBar(),
              body: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(gradient: bgGradientPageWhite),
                // constraints: BoxConstraints.expand(),
                child: Stack(children: <Widget>[
                  SingleChildScrollView(
                    padding: EdgeInsets.all(0.0),
                    child: _buildForm(),
                  ),
                  _showCircularProgress(),
                ]),
              ),
              floatingActionButton:
                  _getState().data.sapInventoryTransferId == 0 &&
                          _getState().data.status != "Cancel"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FloatingActionButton.extended(
                              icon: Icon(Icons.camera_alt),
                              backgroundColor: btnBgOrange,
                              label: Text("Scan"),
                              onPressed: () {
                                _scanQR();
                              },
                            ),
                            SizedBox(
                              width: 70,
                            ),
                            FloatingActionButton(
                              heroTag: "btnDelete",
                              backgroundColor: Colors.red,
                              tooltip: "Delete",
                              child: Icon(Icons.delete_outline),
                              onPressed: () {
                                showAlertDialogDelete(context);
                              },
                            )
                          ],
                        )
                      : null,
              // floatingActionButton: _getState().data.sapInventoryTransferId == 0
              //     ? FloatingActionButton.extended(
              //         icon: Icon(Icons.camera_alt),
              //         backgroundColor: btnBgOrange,
              //         label: Text("Scan"),
              //         onPressed: () {
              //           _scanQR();
              //         },
              //       )
              //     : null,
              // floatingActionButtonLocation:
              //     FloatingActionButtonLocation.centerFloat,
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
            InventoryTransferDetailItemDetailPage(items[itemIndex]),
      ),
    );

    item.then((Item item) {
      if (item != null) {
        bloc.emitEvent(InventoryTransferDetailEventItemUpdate(
          item: item,
          itemIndex: itemIndex,
        ));

        _update();
      }
    });
  }

  Widget _buildForm() {
    _errorMessage();
    _successMessage();
    _showScanNewItemDetail();
    var state = bloc.lastState ?? bloc.initialState;
    var data = state.data;
    _transNoController.text = data.status == "Cancel"
        ? data.transNo + " [Canceled]"
        : data.transNo; //data.transNo;

    var cekData = _getState().data;
    //jika nama signature berbah di kasih tanda

    if (data.id != 0) {
      _idTxController.text = data.id.toString();
      _sapInventoryTransferNoController.text = data.sapInventoryTransferNo;
      _requestIdController.text = data.requestId.toString();
      _requestNoController.text = data.requestNo;
      transDate = data.transDate;
      if (transDate != null) {
        _transDateController.text = DateFormat("dd-MM-yyyy").format(transDate);
      } else {
        _transDateController.text = null;
      }
      _fromWhsCodeController.text = data.fromWhsCode;
      _fromWhsNameController.text = data.fromWhsName;
      _fromAbsEntryController.text = data.fromAbsEntry.toString();
      _fromBinCodeController.text = data.fromBinCode;
      _toWhsCodeController.text = data.toWhsCode;
      _toWhsNameController.text = data.toWhsName;
      _toAbsEntryController.text = data.toAbsEntry.toString();
      _toBinCodeController.text = data.toBinCode;
      _toBranchIdController.text = data.toBranchId.toString();
      _toBranchNameController.text = data.toBranchName;
      _commentsController.text = data.comments;
    }

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "${globalBloc.userName}",
                      style: subTitleTextStyle,
                    ),
                    Text(
                      " | "
                      "${globalBloc.getDatabaseName()}",
                      style: subTitleTextStyle,
                    ),
                  ],
                ),
                Divider(
                  color: bgGrey,
                  thickness: 0.0,
                ),
                (data.sapInventoryTransferId > 0)
                    ? TextFormField(
                        controller: _sapInventoryTransferNoController,
                        style: TextStyle(fontSize: 16, color: Colors.red),
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: "Transfer No.",
                          labelText: "Transfer No.",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                        ),
                      )
                    : Container(width: 0, height: 0),
                Padding(padding: EdgeInsets.only(top: 5)),
                (data.id > 0)
                    ? TextFormField(
                        controller: _transNoController,
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: "Scan No.",
                            labelText: "Scan No.",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0))))
                    : Container(width: 0, height: 0),
                // Padding(padding: EdgeInsets.only(top: 5)),
                FlatButton(
                  padding: EdgeInsets.only(top: 7),
                  onPressed: () {
                    if (data.sapInventoryTransferId == 0) {
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
                              hintText: "Transfer Date",
                              labelText: "Transfer Date",
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: (data.id == 0)
                                          ? Colors.blue
                                          : Colors.grey[400]),
                                  borderRadius: new BorderRadius.circular(
                                    10.0,
                                  ))),
                        ),
                      ),
                      (data.sapInventoryTransferId == 0)
                          ? Icon(
                              Icons.date_range,
                            )
                          : Container(width: 0, height: 0),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      color: isVisible ? bgOrange : bgBlue,
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      iconSize: 30,
                      icon: isVisible
                          ? Icon(Icons.arrow_drop_up)
                          : Icon(Icons.arrow_drop_down),
                    ),
                    // isVisible
                    //     ? Text("Show", style: subTitleTextStyle)
                    //     : Text("Hide", style: subTitleTextStyle)
                  ],
                ),
                (data.status == null || data.requestNo != null)
                    ? FlatButton(
                        padding: EdgeInsets.only(top: 5),
                        onPressed: () {
                          if (data.id == 0) {
                            Future<cflTransferRequest.Data> trq =
                                Navigator.push(
                                    context,
                                    MaterialPageRoute<cflTransferRequest.Data>(
                                        builder: (BuildContext context) =>
                                            CflTransferRequestPage(
                                                "InventoryTransfer")));

                            trq.then((cflTransferRequest.Data trq) {
                              setState(() {
                                if (trq != null) {
                                  _requestIdController.text = trq.id.toString();
                                  _requestNoController.text = trq.transNo;
                                  _fromWhsCodeController.text = trq.fromWhsCode;
                                  _fromWhsNameController.text = trq.fromWhsName;
                                  _fromAbsEntryController.text =
                                      trq.fromBinEntry.toString();
                                  _fromBinCodeController.text = trq.fromBinCode;
                                  _toWhsCodeController.text = trq.toWhsCode;
                                  _toWhsNameController.text = trq.toWhsName;
                                  _toBranchIdController.text =
                                      trq.toBranchId.toString();
                                  _toBranchNameController.text =
                                      trq.toBranchName;
                                  _toAbsEntryController.text =
                                      trq.toBinEntry.toString();
                                  _toBinCodeController.text = trq.toBinCode;
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Transfer Request No",
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 12.0),
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.only(left: 5),
                                      title: Text(_requestNoController.text),
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
                      )
                    : Container(width: 0, height: 0),
                Visibility(
                  visible: isVisible,
                  child: Column(
                    children: <Widget>[
                      //FromWarehouse
                      FlatButton(
                        padding: EdgeInsets.only(top: 5),
                        onPressed: () {
                          if (data.sapInventoryTransferId == 0) {
                            Future<cflWarehouse.Data> whs = Navigator.push(
                                context,
                                MaterialPageRoute<cflWarehouse.Data>(
                                    builder: (BuildContext context) =>
                                        CflWarehousePage(globalBloc.branchId)));

                            whs.then((cflWarehouse.Data whs) {
                              setState(() {
                                if (whs != null) {
                                  if (data.id == 0) {
                                    _fromWhsCodeController.text = whs.whsCode;
                                    _fromWhsNameController.text = whs.whsName;
                                    _fromAbsEntryController.text =
                                        whs.absEntry.toString();
                                    _fromBinCodeController.text = whs.binCode;
                                  } else {
                                    _getState().data.fromBranchId =
                                        whs.branchId;
                                    _getState().data.fromBranchName =
                                        whs.branchName;
                                    _getState().data.fromWhsCode = whs.whsCode;
                                    _getState().data.fromWhsName = whs.whsName;
                                    _getState().data.fromAbsEntry =
                                        whs.absEntry;
                                    _getState().data.fromBinCode = whs.binCode;
                                  }
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
                                  color: (data.sapInventoryTransferId == 0)
                                      ? Colors.blue
                                      : Colors.grey[400]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "From Warehouse",
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 12.0),
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.only(left: 5),
                                      title: Text(_fromWhsCodeController.text),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(_fromWhsNameController.text),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              (data.sapInventoryTransferId == 0)
                                  ? Icon(
                                      Icons.keyboard_arrow_right,
                                    )
                                  : Container(width: 0, height: 0),
                            ],
                          ),
                        ),
                      ),
                      //FromBinLocation
                      FlatButton(
                        padding: EdgeInsets.only(top: 5),
                        onPressed: () {
                          if (data.sapInventoryTransferId == 0) {
                            Future<cflBinLocation.Data> bin = Navigator.push(
                                context,
                                MaterialPageRoute<cflBinLocation.Data>(
                                    builder: (BuildContext context) =>
                                        CflBinLocationPage(
                                            _fromWhsCodeController.text)));

                            bin.then((cflBinLocation.Data bin) {
                              setState(() {
                                if (bin != null) {
                                  if (data.id == 0) {
                                    _fromAbsEntryController.text =
                                        bin.absEntry.toString();
                                    _fromBinCodeController.text = bin.binCode;
                                  } else {
                                    _getState().data.fromAbsEntry =
                                        bin.absEntry;
                                    _getState().data.fromBinCode = bin.binCode;
                                  }
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
                                  color: (data.sapInventoryTransferId == 0)
                                      ? Colors.blue
                                      : Colors.grey[400]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "From Bin Location",
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 12.0),
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.only(left: 5),
                                      title: Text(_fromBinCodeController.text),
                                    )
                                  ],
                                ),
                              ),
                              (data.sapInventoryTransferId == 0)
                                  ? Icon(
                                      Icons.keyboard_arrow_right,
                                    )
                                  : Container(width: 0, height: 0),
                            ],
                          ),
                        ),
                      ),
                      //ToWarehouse
                      FlatButton(
                        padding: EdgeInsets.only(top: 5),
                        onPressed: () {
                          if (data.sapInventoryTransferId == 0) {
                            Future<cflWarehouse.Data> whs = Navigator.push(
                                context,
                                MaterialPageRoute<cflWarehouse.Data>(
                                    builder: (BuildContext context) =>
                                        CflWarehousePage(globalBloc.branchId)));

                            whs.then((cflWarehouse.Data whs) {
                              setState(() {
                                if (whs != null) {
                                  if (data.id == 0) {
                                    _toBranchIdController.text =
                                        whs.branchId.toString();
                                    _toBranchNameController.text =
                                        whs.branchName;
                                    _toWhsCodeController.text = whs.whsCode;
                                    _toWhsNameController.text = whs.whsName;
                                    _toAbsEntryController.text =
                                        whs.absEntry.toString();
                                    _toBinCodeController.text = whs.binCode;
                                  } else {
                                    _getState().data.toBranchId = whs.branchId;
                                    _getState().data.toBranchName =
                                        whs.branchName;
                                    _getState().data.toWhsCode = whs.whsCode;
                                    _getState().data.toWhsName = whs.whsName;
                                    _getState().data.toAbsEntry = whs.absEntry;
                                    _getState().data.toBinCode = whs.binCode;
                                  }
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
                                  color: (data.sapInventoryTransferId == 0)
                                      ? Colors.blue
                                      : Colors.grey[400]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "To Warehouse",
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 12.0),
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.only(left: 5),
                                      title: Text(_toWhsCodeController.text),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(_toWhsNameController.text),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              (data.sapInventoryTransferId == 0)
                                  ? Icon(
                                      Icons.keyboard_arrow_right,
                                    )
                                  : Container(width: 0, height: 0),
                            ],
                          ),
                        ),
                      ),
                      //ToBinLocation
                      FlatButton(
                        padding: EdgeInsets.only(top: 5),
                        onPressed: () {
                          if (data.sapInventoryTransferId == 0) {
                            Future<cflBinLocation.Data> bin = Navigator.push(
                                context,
                                MaterialPageRoute<cflBinLocation.Data>(
                                    builder: (BuildContext context) =>
                                        CflBinLocationPage(
                                            _toWhsCodeController.text)));

                            bin.then((cflBinLocation.Data bin) {
                              setState(() {
                                if (bin != null) {
                                  if (data.id == 0) {
                                    _toAbsEntryController.text =
                                        bin.absEntry.toString();
                                    _toBinCodeController.text = bin.binCode;
                                  } else {
                                    _getState().data.toAbsEntry = bin.absEntry;
                                    _getState().data.toBinCode = bin.binCode;
                                  }
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
                                  color: (data.sapInventoryTransferId == 0)
                                      ? Colors.blue
                                      : Colors.grey[400]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "To Bin Location",
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 12.0),
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.only(left: 5),
                                      title: Text(_toBinCodeController.text),
                                    )
                                  ],
                                ),
                              ),
                              (data.sapInventoryTransferId == 0)
                                  ? Icon(
                                      Icons.keyboard_arrow_right,
                                    )
                                  : Container(width: 0, height: 0),
                            ],
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      (data.sapInventoryTransferId == 0)
                          ? TextField(
                              maxLength: 254,
                              enabled: true,
                              controller: _commentsController,
                              textAlign: TextAlign.left,
                              maxLines: 4,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: "",
                                  labelText: "Comments",
                                  alignLabelWithHint: true,
                                  contentPadding: new EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: (data.id == 0)
                                              ? Colors.blue
                                              : Colors.grey[400]),
                                      borderRadius: new BorderRadius.circular(
                                        10.0,
                                      ))),
                            )
                          : TextField(
                              enabled: false,
                              controller: _commentsController,
                              textAlign: TextAlign.left,
                              maxLines: 4,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: "",
                                  labelText: "Comments",
                                  alignLabelWithHint: true,
                                  contentPadding: new EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: (data.id == 0)
                                              ? Colors.blue
                                              : Colors.grey[400]),
                                      borderRadius: new BorderRadius.circular(
                                        10.0,
                                      ))),
                            ),
                    ],
                  ),
                ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("List of Items",
                        style: new TextStyle(fontWeight: FontWeight.bold)),
                    _showAllRow == false
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(
                                iconSize: 30,
                                icon: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.arrow_drop_down,
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  _showAllRow = true;
                                  _showAllData();
                                },
                              ),
                              Text("Show All", style: subTitleTextStyle)
                            ],
                          )
                        : Row(
                            children: <Widget>[
                              IconButton(
                                iconSize: 30,
                                icon: Icon(
                                  Icons.arrow_drop_up,
                                ),
                                onPressed: () {
                                  _showAllRow = false;
                                  _showLessData();
                                },
                              ),
                              Text("Back", style: subTitleTextStyle)
                            ],
                          ),
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
    int rowIndex = data.length - index;
    bool isDuplicateBatchNumber = _checkForDuplicateBatchNumber(data, index);
    // Warna yang akan digunakan untuk menandai duplikasi
    Color duplicateColor = bgOrange;

    return Container(
      margin: new EdgeInsets.symmetric(horizontal: 0.0, vertical: 1.0),
      decoration: BoxDecoration(
          color: isDuplicateBatchNumber
              ? duplicateColor
              : Colors.grey[400].withOpacity(0.5),
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
              Text('No. ' + "$rowIndex"),
              // Text("DetId : ${data[index].detId}"),
              Text("Item Code : ${data[index].itemCode}"),
              Text("Batch No. : ${data[index].batchNo}"),
              Text(
                  "Quantity : ${NumberFormat("#,###.##").format(data[index].qty)}" +
                      " ${data[index].uom}"),
              // Text(data[index].whsCode ?? ''),
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
      itemCount: _showAllRow == true ? data.length : 1,
      itemBuilder: (contex, index) {
        if (_getState().data.sapInventoryTransferId == 0 &&
            !_getState().isBusy) {
          return Dismissible(
            // key: Key(data[index].hashCode.toString()),
            key: UniqueKey(),
            onDismissed: (direction) {
              bloc.emitEvent(InventoryTransferDetailEventRemoveItem(
                  id: data[index].id, detId: data[index].detId));
              // bloc.emitEvent(
              //     InventoryTransferDetailEventItemRemove(itemIndex: index));
              // _update();
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

  bool _checkForDuplicateBatchNumber(List<Item> data, int currentIndex) {
    // Mendapatkan batch number untuk item saat ini
    String currentBatchNumber = data[currentIndex].batchNo;

    // Mengecek duplikasi batch number dengan item lain dalam daftar
    for (int i = 0; i < data.length; i++) {
      if (i != currentIndex && data[i].batchNo == currentBatchNumber) {
        return true; // Ada duplikasi batch number
      }
    }

    return false; // Tidak ada duplikasi batch number
  }
}
