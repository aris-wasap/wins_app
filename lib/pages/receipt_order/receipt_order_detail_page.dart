import 'dart:convert';

import 'package:shimmer/shimmer.dart';
import 'package:wins_app/pages/cfl/cfl_purchase_order_label_page.dart';
import 'package:wins_app/pages/cfl/cfl_purchase_order_page.dart';
import 'package:wins_app/pages/cfl/cfl_purchase_reference_page.dart';
import 'package:wins_app/pages/receipt_order/receipt_order_detail_item_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:wins_app/bloc_widgets/bloc_state_builder.dart';
import 'package:wins_app/blocs/receipt_order/detail/receipt_order_detail_bloc.dart';
import 'package:wins_app/blocs/receipt_order/detail/receipt_order_detail_event.dart';
import 'package:wins_app/blocs/receipt_order/detail/receipt_order_detail_state.dart';
import 'package:wins_app/blocs/global_bloc.dart';
import 'package:wins_app/models/receipt_order_detail_response.dart';
import 'package:wins_app/widgets/set_colors.dart';
import 'package:wins_app/widgets/validate_dialog_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:uuid/uuid.dart';
import 'package:wins_app/models/cfl_purchase_order_response.dart'
    as cflPurchaseOrder;
import 'package:wins_app/models/cfl_purchase_order_label_response.dart'
    as cflPurchaseOrderLabel;
import 'package:wins_app/models/cfl_purchase_reference_response.dart'
    as cflPurchaseReference;
import 'package:wins_app/pages/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audio_cache.dart';

class ReceiptOrderDetailPage extends StatefulWidget {
  ReceiptOrderDetailPage(this._id);
  final int _id;
  @override
  _ReceiptOrderDetailPageState createState() =>
      _ReceiptOrderDetailPageState(_id);
}

class _ReceiptOrderDetailPageState extends State<ReceiptOrderDetailPage> {
  _ReceiptOrderDetailPageState(this._id);

  ReceiptOrderDetailBloc bloc = ReceiptOrderDetailBloc();
  final int _id;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController;
  final _idTxController = TextEditingController();
  final _poIdController = TextEditingController();
  final _poNoController = TextEditingController();
  final _webIdController = TextEditingController();
  final _webNoController = TextEditingController();
  final _sapReceiptOrderNoController = TextEditingController();
  final _transNoController = TextEditingController();
  final _transDateController = TextEditingController();
  final _vendorCodeController = TextEditingController();
  final _vendorNameController = TextEditingController();
  final _refNoController = TextEditingController();
  final _scaleNoController = TextEditingController();
  final _seriesNamePoController = TextEditingController();
  final _seriesNameController = TextEditingController();
  final _branchIdController = TextEditingController();
  final _branchNameController = TextEditingController();
  final _statusController = TextEditingController();
  final _player = AudioCache();
  DateTime transDate; // = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (_id != 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bloc.emitEvent(ReceiptOrderDetailEventGetId(
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
    _poIdController?.dispose();
    _poNoController?.dispose();
    _webIdController?.dispose();
    _webNoController?.dispose();
    _sapReceiptOrderNoController?.dispose();
    _transNoController?.dispose();
    _transDateController?.dispose();
    _vendorCodeController?.dispose();
    _vendorNameController?.dispose();
    _refNoController?.dispose();
    _scaleNoController?.dispose();
    _seriesNamePoController?.dispose();
    _seriesNameController?.dispose();
    _branchIdController?.dispose();
    _branchNameController?.dispose();
    _statusController?.dispose();

    bloc?.dispose();

    super.dispose();
  }

  void _create() {
    var state = (bloc.lastState ?? bloc.initialState);
    var data = Data(); // (bloc.lastState ?? bloc.initialState).data;
    data.poNo = _poNoController.text;
    data.webNo = _webNoController.text;
    data.transDate = transDate;
    data.vendorCode = _vendorCodeController.text;
    data.vendorName = _vendorNameController.text;
    data.refNo = _refNoController.text;
    data.scaleNo = _scaleNoController.text;
    data.items = state.data.items;

    if ([null].contains(data.transDate)) {
      ValidateDialogWidget(
          context: context, message: "Purchase Order Date harus di isi");
      return;
    } else if (["", null].contains(data.poNo)) {
      ValidateDialogWidget(
          context: context, message: "Purchase Order No. harus di isi");
      return;
    } else if (["", null].contains(data.webNo)) {
      ValidateDialogWidget(
          context: context,
          message: "Labeling Purchase Order No. harus di isi");
      return;
    } else if (["", null].contains(data.refNo)) {
      ValidateDialogWidget(
          context: context, message: "Reference No. harus di isi");
      return;
    } else if (["", null].contains(data.vendorCode)) {
      ValidateDialogWidget(context: context, message: "Vendor harus di isi");
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
    data.poId = int.parse(_poIdController.text);
    data.webId = int.parse(_webIdController.text);
    data.seriesName = _seriesNameController.text;
    data.seriesNamePo = _seriesNamePoController.text;

    bloc.emitEvent(ReceiptOrderDetailEventAdd(
      data: data,
    ));
  }

  void _submit() {
    var state = (bloc.lastState ?? bloc.initialState);
    var data = Data(); // (bloc.lastState ?? bloc.initialState).data;
    data.id = int.parse(_idTxController.text);
    data.poId = int.parse(_poIdController.text);
    data.poNo = _poNoController.text;
    data.webId = int.parse(_webIdController.text);
    data.webNo = _webNoController.text;
    data.transDate = transDate;
    data.vendorCode = _vendorCodeController.text;
    data.vendorName = _vendorNameController.text;
    data.seriesName = _seriesNameController.text;
    data.seriesNamePo = _seriesNamePoController.text;
    data.refNo = _refNoController.text;
    data.scaleNo = _scaleNoController.text;
    data.items = state.data.items;

    if ([null].contains(data.transDate)) {
      ValidateDialogWidget(
          context: context, message: "Purchase Order Date harus di isi");
      return;
    } else if (["", null].contains(data.poNo)) {
      ValidateDialogWidget(
          context: context, message: "Purchase Order No harus di isi");
      return;
    } else if (["", null].contains(data.vendorCode)) {
      ValidateDialogWidget(context: context, message: "Vendor harus di isi");
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

    bloc.emitEvent(ReceiptOrderDetailEventPost(
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

  Future _deleteData() async {
    if ((_sapReceiptOrderNoController.text.isNotEmpty)) {
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
        ReceiptOrderDetailEventCancel(id: data.id, data: data),
      );
    } catch (ex) {
      ValidateDialogWidget(
          context: context, message: "Delete : Unknown error $ex");
      return;
    }
  }

  void _newTrans() {
    MaterialPageRoute newRoute = MaterialPageRoute(
        builder: (BuildContext context) => ReceiptOrderDetailPage(0));
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
                    bloc.emitEvent(ReceiptOrderDetailEventNormal());
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
                    bloc.emitEvent(ReceiptOrderDetailEventNormal());
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
    if (_getState().data.id == 0 && !_getState().isBusy) {
      return AppBar(
        title: Text("Draft Receipt"),
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
    } else if (_getState().data.sapReceiptOrderId == 0 &&
        _getState().data.id > 0 &&
        !_getState().isBusy) {
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
    } else if (!_getState().isBusy) {
      return AppBar(
        title: Text("Receipt From Purchase Order"),
        backgroundColor: bgBlue,
        bottom: PreferredSize(
            child: Container(
              color: bgOrange,
              height: 5.0,
            ),
            preferredSize: Size.fromHeight(5.0)),
        actions: <Widget>[
          (globalBloc.loginResponse.data.receiptOrder_Auth_Add == 'Y')
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

  ReceiptOrderDetailState _getState() {
    return bloc.lastState ?? bloc.initialState;
  }

  BuildContext _context;

  Future _scanQR() async {
    if (["", null].contains(_poNoController.text)) {
      ValidateDialogWidget(context: context, message: "PO No harus di isi");
      return;
    }
    var data = _getState().data;

    try {
      String qrResult = await BarcodeScanner.scan();
      for (var item in _getState().data.items) {
        if (("${item.batchNo}" == qrResult)) {
          ValidateDialogWidget(
              context: context,
              message:
                  'Item Batch Number : ${item.batchNo} sudah pernah di scan');
          return;
        }
      }

      bloc.emitEvent(ReceiptOrderDetailEventScan(
          webId: int.parse(_webIdController.text),
          webNo: _webNoController.text,
          qrResult: qrResult,
          data: data));

      // bloc
      //     .eventHandler(
      //         ReceiptOrderDetailEventScan(
      //             poId: int.parse(_poIdController.text),
      //             qrResult: qrResult,
      //             data: data),
      //         _getState())
      //     .listen((onData) {
      //   if (onData.newItem != null) {
      //     Future<Item> item = Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (BuildContext context) =>
      //             ReceiptOrderDetailItemDetailPage(onData.newItem),
      //       ),
      //     );

      //     item.then((Item item) {
      //       if (item != null) {
      //         bloc.emitEvent(ReceiptOrderDetailEventItemAdd(
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
        _player.play(
          'sounds/store-scanner-beep-sound-effect.mp3',
          volume: 10.0,
        );
        bloc.emitEvent(ReceiptOrderDetailEventNormal());
        Future<Item> item = Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                ReceiptOrderDetailItemDetailPage(newItem),
          ),
        );

        item.then((Item item) {
          if (item != null) {
            bloc.emitEvent(ReceiptOrderDetailEventItemAdd(
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

    return BlocEventStateBuilder<ReceiptOrderDetailState>(
        bloc: bloc,
        builder: (BuildContext context, ReceiptOrderDetailState state) {
          return SafeArea(
            child: Scaffold(
              key: _scaffoldKey,
              appBar: _appBar(),
              body: Container(
                // constraints: BoxConstraints.expand(),
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: bgGradientPageWhite,
                ),
                child: Stack(children: <Widget>[
                  SingleChildScrollView(
                    padding: EdgeInsets.all(0.0),
                    child: _buildForm(),
                  ),
                  _showCircularProgress(),
                ]),
              ),
              floatingActionButton: _getState().data.sapReceiptOrderId == 0
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
              // floatingActionButton: _getState().data.sapReceiptOrderId == 0
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
            ReceiptOrderDetailItemDetailPage(items[itemIndex]),
      ),
    );

    item.then((Item item) {
      if (item != null) {
        bloc.emitEvent(ReceiptOrderDetailEventItemUpdate(
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

    //jika nama signature berbah di kasih tanda

    if (data.id != 0) {
      _idTxController.text = data.id.toString();
      _poIdController.text = data.poId.toString();
      _poNoController.text = data.poNo;
      _webIdController.text = data.webId.toString();
      _webNoController.text = data.webNo;
      _refNoController.text = data.refNo;
      _scaleNoController.text = data.scaleNo;
      _sapReceiptOrderNoController.text = data.sapReceiptOrderNo;
      transDate = data.transDate;
      if (transDate != null) {
        _transDateController.text = DateFormat("dd-MM-yyyy").format(transDate);
      } else {
        _transDateController.text = null;
      }
      _vendorCodeController.text = data.vendorCode;
      _vendorNameController.text = data.vendorName;
      _seriesNamePoController.text = data.seriesNamePo;
      _seriesNameController.text = data.seriesName;
      _branchIdController.text = data.branchId.toString();
      _branchNameController.text = data.branchName;
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
                (data.sapReceiptOrderId > 0)
                    ? TextFormField(
                        controller: _sapReceiptOrderNoController,
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: "Receipt No.",
                            labelText: "Receipt No.",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0))),
                      )
                    : Container(width: 0, height: 0),
                Padding(padding: EdgeInsets.only(top: 5)),
                (_getState().data.id > 0)
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
                Padding(padding: EdgeInsets.only(top: 5)),
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
                                ),
                              ),
                            )
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
                      Future<cflPurchaseOrderLabel.Data> po = Navigator.push(
                          context,
                          MaterialPageRoute<cflPurchaseOrderLabel.Data>(
                              builder: (BuildContext context) =>
                                  CflPurchaseOrderLabelPage()));

                      po.then((cflPurchaseOrderLabel.Data po) {
                        setState(() {
                          if (po != null) {
                            if (data.id == 0) {
                              _poIdController.text = po.docEntry.toString();
                              _poNoController.text = po.docNum;
                              _webIdController.text = po.id.toString(); //webId
                              _webNoController.text = po.transNo; // WebNo
                              _vendorCodeController.text = po.vendorCode;
                              _vendorNameController.text = po.vendorName;
                              _refNoController.text = po.refNo;
                              _scaleNoController.text = po.scaleNo;
                              _branchIdController.text = po.branchId.toString();
                              _branchNameController.text = po.branchName;
                              _seriesNamePoController.text = po.seriesName;
                            }
                          } else {
                            _getState().data.poId = po.docEntry;
                            _getState().data.poNo = po.docNum;
                            _getState().data.webId = po.id; //webId
                            _getState().data.webNo = po.transNo; // WebNo
                            _getState().data.vendorCode = po.vendorCode;
                            _getState().data.vendorName = po.vendorName;
                            _getState().data.refNo = po.refNo;
                            _getState().data.scaleNo = po.scaleNo;
                            _getState().data.branchId = po.branchId;
                            _getState().data.branchName = po.branchName;
                            _getState().data.seriesNamePo = po.seriesName;
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
                                "Purchase Order No. : ",
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 12.0),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.only(left: 5),
                                title: Text(_webNoController.text,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal)),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(_poNoController.text),
                                    Text(_refNoController.text),
                                    Text(_scaleNoController.text),
                                    // Text(_branchNameController.text),
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
                Padding(padding: EdgeInsets.only(top: 5)),
                // TextFormField(
                //   controller: _poNoController,
                //   autofocus: false,
                //   enabled: data.id == 0 ? true : false,
                //   decoration: InputDecoration(
                //     hintText: "Purchase Order No.",
                //     labelText: "Purchase Order No.",
                //     contentPadding: new EdgeInsets.symmetric(
                //         vertical: 15.0, horizontal: 10.0),
                //     border: new OutlineInputBorder(
                //         borderRadius: new BorderRadius.circular(10.0)),
                //     disabledBorder: OutlineInputBorder(
                //       borderSide: BorderSide(
                //           color:
                //               (data.id == 0) ? Colors.blue : Colors.grey[400]),
                //       borderRadius: new BorderRadius.circular(
                //         10.0,
                //       ),
                //     ),
                //   ),
                // ),

                // FlatButton(
                //   padding: EdgeInsets.only(top: 5),
                //   onPressed: () {
                //     if (int.parse(_poIdController.text) > 0) {
                //       Future<cflPurchaseReference.Data> po = Navigator.push(
                //           context,
                //           MaterialPageRoute<cflPurchaseReference.Data>(
                //               builder: (BuildContext context) =>
                //                   CflPurchaseReferencePage(
                //                       int.parse(_poIdController.text))));

                //       po.then((cflPurchaseReference.Data po) {
                //         setState(() {
                //           if (po != null) {
                //             //_poIdController.text = po.id.toString();
                //             //_poNoController.text = po.transNo;
                //             //_vendorCodeController.text = po.vendorCode;
                //             //_vendorNameController.text = po.vendorName;
                //             _refNoController.text = po.refNo;
                //             _scaleNoController.text = po.scaleNo;
                //             //_branchIdController.text = po.branchId.toString();
                //             //_branchNameController.text = po.branchName;
                //             //_seriesNamePoController.text = po.seriesName;
                //           }
                //         });
                //       });
                //     }
                //   },
                //   child: Container(
                //     padding: EdgeInsets.only(left: 5, top: 5),
                //     alignment: Alignment.centerLeft,
                //     decoration: BoxDecoration(
                //         border: Border.all(
                //             color: (data.id == 0)
                //                 ? Colors.blue
                //                 : Colors.grey[400]),
                //         borderRadius: BorderRadius.all(Radius.circular(10))),
                //     child: Row(
                //       children: <Widget>[
                //         Expanded(
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: <Widget>[
                //               Text(
                //                 "Reference No.",
                //                 style: TextStyle(
                //                     color: Colors.blue, fontSize: 12.0),
                //               ),
                //               ListTile(
                //                 contentPadding: EdgeInsets.only(left: 5),
                //                 title: Text(_refNoController.text),
                //                 // subtitle: Column(
                //                 //   crossAxisAlignment: CrossAxisAlignment.start,
                //                 //   // children: <Widget>[
                //                 //   //   Text(_branchNameController.text),
                //                 //   // ],
                //                 // ),
                //               )
                //             ],
                //           ),
                //         ),
                //         (data.id == 0)
                //             ? Icon(
                //                 Icons.keyboard_arrow_right,
                //               )
                //             : Container(width: 0, height: 0),
                //       ],
                //     ),
                //   ),
                // ),
                // Padding(padding: EdgeInsets.only(top: 5)),
                // TextFormField(
                //   controller: _refNoController,
                //   autofocus: false,
                //   enabled: data.id == 0 ? true : false,
                //   decoration: InputDecoration(
                //     hintText: 'Ref No.',
                //     labelText: "Ref No.",
                //     contentPadding: new EdgeInsets.symmetric(
                //         vertical: 15.0, horizontal: 10.0),
                //     border: new OutlineInputBorder(
                //         borderRadius: new BorderRadius.circular(10.0)),
                //     disabledBorder: OutlineInputBorder(
                //       borderSide: BorderSide(
                //           color:
                //               (data.id == 0) ? Colors.blue : Colors.grey[400]),
                //       borderRadius: new BorderRadius.circular(
                //         10.0,
                //       ),
                //     ),
                //   ),
                // ),
                // Padding(padding: EdgeInsets.only(top: 5)),
                // TextFormField(
                //   controller: _scaleNoController,
                //   autofocus: false,
                //   enabled: data.id == 0 ? true : false,
                //   decoration: InputDecoration(
                //     hintText: 'Scale No.',
                //     labelText: "Scale No.",
                //     contentPadding: new EdgeInsets.symmetric(
                //         vertical: 15.0, horizontal: 10.0),
                //     border: new OutlineInputBorder(
                //         borderRadius: new BorderRadius.circular(10.0)),
                //     disabledBorder: OutlineInputBorder(
                //       borderSide: BorderSide(
                //           color:
                //               (data.id == 0) ? Colors.blue : Colors.grey[400]),
                //       borderRadius: new BorderRadius.circular(
                //         10.0,
                //       ),
                //     ),
                //   ),
                // ),
                FlatButton(
                  padding: EdgeInsets.only(top: 5),
                  onPressed: () {
                    if (data.id == 0) {}
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 5, top: 5),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[400]),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                        // border: Border(
                        //   bottom: BorderSide(
                        //     color: (data.id == 0) ? Colors.blue : Colors.grey,
                        //     width: 1.0,
                        //   ),
                        // ),
                        ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Supplier",
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 12.0),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.only(left: 5),
                                title: Text(_vendorNameController.text),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(_vendorCodeController.text),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
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
    int rowIndex = data.length - index;
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
              Text('No. ' + "$rowIndex"),
              Text("Item Code : ${data[index].itemCode}"),
              Text("Batch No. : ${data[index].batchNo}"),
              Text(
                  "Quantity : ${NumberFormat("#,###.##").format(data[index].qty)}" +
                      " ${data[index].uom}"),

              // Text(data[index].whsCode ?? ''),
              Text("Warehouse : ${data[index].whsName}"),
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
        if (_getState().data.sapReceiptOrderId == 0 && !_getState().isBusy) {
          return Dismissible(
            key: Key(data[index].hashCode.toString()),
            onDismissed: (direction) {
              bloc.emitEvent(
                  ReceiptOrderDetailEventItemRemove(itemIndex: index));
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
