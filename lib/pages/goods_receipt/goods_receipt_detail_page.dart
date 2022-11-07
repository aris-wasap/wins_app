import 'dart:convert';

import 'package:wins_app/pages/cfl/cfl_receipt_production_label_page.dart';
import 'package:wins_app/pages/cfl/cfl_receipt_production_page.dart';
import 'package:wins_app/pages/goods_receipt/goods_receipt_detail_item_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:wins_app/bloc_widgets/bloc_state_builder.dart';
import 'package:wins_app/blocs/goods_receipt/detail/goods_receipt_detail_bloc.dart';
import 'package:wins_app/blocs/goods_receipt/detail/goods_receipt_detail_event.dart';
import 'package:wins_app/blocs/goods_receipt/detail/goods_receipt_detail_state.dart';
import 'package:wins_app/blocs/global_bloc.dart';
import 'package:wins_app/models/goods_receipt_detail_response.dart';
import 'package:wins_app/pages/goods_receipt/goods_receipt_detail_scan_detail_page.dart';
import 'package:wins_app/widgets/set_colors.dart';
import 'package:wins_app/widgets/validate_dialog_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:uuid/uuid.dart';
import 'package:wins_app/models/cfl_receipt_production_label_response.dart'
    as cflReceiptProductionLabel;
import 'package:wins_app/pages/barcode_scan.dart';
import 'package:flutter/services.dart';

class GoodsReceiptDetailPage extends StatefulWidget {
  GoodsReceiptDetailPage(this._id);
  final int _id;
  @override
  _GoodsReceiptDetailPageState createState() =>
      _GoodsReceiptDetailPageState(_id);
}

class _GoodsReceiptDetailPageState extends State<GoodsReceiptDetailPage> {
  _GoodsReceiptDetailPageState(this._id);

  GoodsReceiptDetailBloc bloc = GoodsReceiptDetailBloc();
  final int _id;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController;
  final _idTxController = TextEditingController();
  final _woIdController = TextEditingController();
  final _woNoController = TextEditingController();
  final _webIdController = TextEditingController();
  final _webNoController = TextEditingController();
  final _sapGoodsReceiptNoController = TextEditingController();
  final _sapGoodsIssueIdController = TextEditingController();
  final _sapGoodsIssueNoController = TextEditingController();
  final _productCodeController = TextEditingController();
  final _productNameController = TextEditingController();
  final _transNoController = TextEditingController();
  final _baseIdController = TextEditingController();
  final _baseNoController = TextEditingController();
  final _transDateController = TextEditingController();
  final _seriesNamePoController = TextEditingController();
  final _seriesNameController = TextEditingController();
  DateTime transDate; // = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (_id != 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bloc.emitEvent(GoodsReceiptDetailEventGetId(
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
    _woIdController?.dispose();
    _woNoController?.dispose();
    _webIdController?.dispose();
    _webNoController?.dispose();
    _productCodeController?.dispose();
    _productNameController?.dispose();
    _sapGoodsReceiptNoController?.dispose();
    _sapGoodsIssueIdController?.dispose();
    _sapGoodsIssueNoController?.dispose();
    _transNoController?.dispose();
    _transDateController?.dispose();
    _baseIdController?.dispose();
    _baseNoController?.dispose();
    _seriesNamePoController?.dispose();
    _seriesNameController?.dispose();

    bloc?.dispose();

    super.dispose();
  }

  void _create() {
    var state = (bloc.lastState ?? bloc.initialState);
    var data = Data(); // (bloc.lastState ?? bloc.initialState).data;
    data.woNo = _woNoController.text;
    data.woId = int.parse(_woIdController.text);
    data.sapGoodsReceiptNo = _sapGoodsReceiptNoController.text;
    data.sapGoodsIssueNo = _sapGoodsIssueNoController.text;
    // data.baseId = int.parse(_baseIdController.text);
    // data.baseNo = _baseNoController.text;
    data.productCode = _productCodeController.text;
    data.productName = _productNameController.text;
    data.transDate = transDate;
    data.seriesName = _seriesNameController.text;
    data.seriesNameWo = _seriesNamePoController.text;
    data.items = state.data.items;

    if ([null].contains(data.transDate)) {
      ValidateDialogWidget(
          context: context, message: "Production Date harus di isi");
      return;
    } else if (["", null].contains(data.woNo)) {
      ValidateDialogWidget(
          context: context, message: "Production Order No harus di isi");
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
    data.webId = int.parse(_webIdController.text);
    data.webNo = _webNoController.text;

    bloc.emitEvent(GoodsReceiptDetailEventAdd(
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

  showAlertDialogPostSap(BuildContext context) {
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
        _post();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Perhatian !!!"),
      content: Text(
          "Apakah anda yakin Submit document ? Jika menyimpan dokumen ini akan otomatis membuat Goods Receipt"),
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

  void _post() {
    var state = (bloc.lastState ?? bloc.initialState);
    var data = state.data; // (bloc.lastState ?? bloc.initialState).data;
    data.sapGoodsIssueNo = _sapGoodsIssueNoController.text;
    data.woNo = _woNoController.text;
    data.woId = int.parse(_woIdController.text);
    data.transDate = transDate;
    data.seriesName = _seriesNameController.text;
    // data.seriesNameWo = _seriesNameWoController.text;
    data.items = state.data.items;

    if ([null].contains(data.transDate)) {
      ValidateDialogWidget(
          context: context, message: "Production Date harus di isi");
      return;
    } else if (["", null].contains(data.woNo)) {
      ValidateDialogWidget(
          context: context, message: "Production Order No harus di isi");
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

    for (var item in _getState().data.items) {
      if (("${item.qty}" == null) || (double.parse("${item.qty}") <= 0)) {
        ValidateDialogWidget(
            context: context,
            message: 'Line ' +
                "${item.itemCode}" +
                ' : Quantity tidak boleh kosong/0');
        return;
      }
    }

    bloc.emitEvent(GoodsReceiptDetailEventPost(
      data: data,
    ));
  }

  // void _update() {
  //   var state = (bloc.lastState ?? bloc.initialState);
  //   var data = Data(); // (bloc.lastState ?? bloc.initialState).data;
  //   data.id = int.parse(_idTxController.text);
  //   data.woNo = _woNoController.text;
  //   data.woId = int.parse(_woIdController.text);
  //   data.productCode = _productCodeController.text;
  //   data.productName = _productNameController.text;
  //   data.transDate = transDate;
  //   data.seriesName = _seriesNameController.text;
  //   data.seriesNameWo = _seriesNamePoController.text;
  //   data.items = state.data.items;

  //   if ([null].contains(data.transDate)) {
  //     ValidateDialogWidget(
  //         context: context, message: "Production Date harus di isi");
  //     return;
  //   } else if (["", null].contains(data.woNo)) {
  //     ValidateDialogWidget(
  //         context: context, message: "Production Order No harus di isi");
  //     return;
  //   }

  //   bloc.emitEvent(GoodsReceiptDetailEventUpdate(
  //     data: data,
  //   ));
  // }

  void _submit() {
    var state = (bloc.lastState ?? bloc.initialState);
    var data = Data(); // (bloc.lastState ?? bloc.initialState).data;
    data.id = int.parse(_idTxController.text);
    data.woNo = _woNoController.text;
    data.woId = int.parse(_woIdController.text);
    data.baseNo = _baseNoController.text;
    data.baseId = int.parse(_baseIdController.text);
    data.sapGoodsIssueNo = _sapGoodsIssueNoController.text;
    data.sapGoodsIssueId = int.parse(_sapGoodsIssueIdController.text);
    data.productCode = _productCodeController.text;
    data.productName = _productNameController.text;
    data.transDate = transDate;
    data.seriesName = _seriesNameController.text;
    data.seriesNameWo = _seriesNamePoController.text;
    data.items = state.data.items;

    if ([null].contains(data.transDate)) {
      ValidateDialogWidget(
          context: context, message: "Production Date harus di isi");
      return;
    } else if (["", null].contains(data.woNo)) {
      ValidateDialogWidget(
          context: context, message: "Production Order No harus di isi");
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

    bloc.emitEvent(GoodsReceiptDetailEventPost(
      data: data,
    ));
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
        builder: (BuildContext context) => GoodsReceiptDetailPage(0));
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
                    bloc.emitEvent(GoodsReceiptDetailEventNormal());
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
                    bloc.emitEvent(GoodsReceiptDetailEventNormal());
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
        title: Text("Draft Receipt"),
        backgroundColor: bgBlue,
        bottom: PreferredSize(
            child: Container(
              color: bgOrange,
              height: 5.0,
            ),
            preferredSize: Size.fromHeight(5.0)),
        actions: <Widget>[
          // FlatButton.icon(
          //   icon: Icon(
          //     Icons.save,
          //     color: Colors.yellowAccent,
          //   ),
          //   onPressed: () {
          //     showAlertDialogCreate(context);
          //   },
          //   textColor: Colors.white,
          //   label: Text("Save"),
          // )
        ],
      );
    } else if (_getState().data.sapGoodsReceiptId == 0 &&
        _getState().data.id > 0) {
      return AppBar(
        title: Text("Create Receipt"),
        backgroundColor: bgBlue,
        bottom: PreferredSize(
            child: Container(
              color: bgOrange,
              height: 5.0,
            ),
            preferredSize: Size.fromHeight(5.0)),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: const Text('Post'),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.elliptical(15, 15)),
              ),
              onPressed: () {
                showAlertDialogPostSap(context);
              },
            ),
          ),
        ],
      );
    } else {
      return AppBar(
        title: Text("Receipt From Production"),
        backgroundColor: bgBlue,
        bottom: PreferredSize(
            child: Container(
              color: bgOrange,
              height: 5.0,
            ),
            preferredSize: Size.fromHeight(5.0)),
        actions: <Widget>[
          (globalBloc.loginResponse.data.goodsReceipt_Auth_Add == 'Y')
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

  GoodsReceiptDetailState _getState() {
    return bloc.lastState ?? bloc.initialState;
  }

  BuildContext _context;

  Future _refreshDetailItem() async {
    if (["", null].contains(_woNoController.text)) {
      ValidateDialogWidget(
          context: context, message: "Production Order No harus di isi");
      return;
    }
    //var data = _getState().data;
    //   for (var item in _getState().data.items) {
    //     if (("${item.batchNo}" == qrResult)) {
    //       ValidateDialogWidget(
    //           context: context, message: 'Item sudah pernah di scan');
    //       return;
    //     }
    //   }
    try {
      String setTransDate = DateFormat("yyyy-MM-dd").format(transDate);

      bloc.emitEvent(GoodsReceiptDetailEventRefresh(
        webId: int.parse(_webIdController.text),
        transDate: setTransDate,
      ));
    } catch (ex) {
      ValidateDialogWidget(
          context: context, message: "Refresh : Unknown error $ex");
      return;
    }
  }

  Future _scanQR() async {
    if (["", null].contains(_woNoController.text)) {
      ValidateDialogWidget(
          context: context, message: "Production Order No harus di isi");
      return;
    }
    var data = _getState().data;

    try {
      // String qrResult = await BarcodeScanner.scan();
      // for (var item in _getState().data.items) {
      //   if (("${item.batchNo}" == qrResult)) {
      //     ValidateDialogWidget(
      //         context: context,
      //         message:
      //             'Item Batch Number : ${item.batchNo} sudah pernah di scan');
      //     return;
      //   }
      // }

      // bloc.emitEvent(GoodsReceiptDetailEventScan(
      //     woId: int.parse(_woIdController.text),
      //     qrResult: qrResult,
      //     data: data));

      return _showItemScanDetail();
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
      var newData = _getState().data;
      if (newItem != null) {
        bloc.emitEvent(GoodsReceiptDetailEventNormal());
        Future<Item> item = Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                GoodsReceiptDetailItemDetailPage(newItem, 0, newData),
          ),
        );

        item.then((Item item) {
          if (item != null) {
            bloc.emitEvent(GoodsReceiptDetailEventItemAdd(
              item: item,
            ));
          }
        });
      }
    });
  }

  void _showItemScanDetail() {
    final items = _getState().data.items;
    Navigator.push(
        context,
        MaterialPageRoute<Item>(
          builder: (BuildContext context) =>
              GoodsReceiptDetailScanDetailPage(items[0]),
        ));
  }

  void _showItemDetail(int itemIndex) {
    final newData = _getState().data;
    final items = _getState().data.items;
    Future<Item> item = Navigator.push(
      context,
      MaterialPageRoute<Item>(
        builder: (BuildContext context) => GoodsReceiptDetailItemDetailPage(
            items[itemIndex], itemIndex, newData),
      ),
    );

    item.then((Item item) {
      if (item != null) {
        bloc.emitEvent(GoodsReceiptDetailEventItemUpdate(
          item: item,
          itemIndex: itemIndex,
        ));
        // _update();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    var data = _getState().data;

    return BlocEventStateBuilder<GoodsReceiptDetailState>(
        bloc: bloc,
        builder: (BuildContext context, GoodsReceiptDetailState state) {
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
              // floatingActionButton: _getState().data.sapGoodsReceiptId != 0
              //     ? FloatingActionButton.extended(
              //         icon: Icon(Icons.camera_alt),
              //         backgroundColor: btnBgOrange,
              //         label: Text("Scan"),
              //         onPressed: () {
              //           _scanQR();
              //           //_refreshDetailItem();
              //         },
              //       )
              //     : null,
              // floatingActionButtonLocation:
              //     FloatingActionButtonLocation.centerFloat,
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
      _woIdController.text = data.woId.toString();
      _woNoController.text = data.woNo;
      _sapGoodsReceiptNoController.text = data.sapGoodsReceiptNo;
      _sapGoodsIssueIdController.text = data.sapGoodsIssueId.toString();
      _sapGoodsIssueNoController.text = data.sapGoodsIssueNo;
      _baseIdController.text = data.baseId.toString();
      _baseNoController.text = data.baseNo;
      _webNoController.text = data.webNo;
      _productCodeController.text = data.productCode;
      _productNameController.text = data.productName;
      transDate = data.transDate;
      if (transDate != null) {
        _transDateController.text = DateFormat("dd-MM-yyyy").format(transDate);
      } else {
        _transDateController.text = null;
      }
      _seriesNamePoController.text = data.seriesNameWo;
      _seriesNameController.text = data.seriesNameWo;
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
                (data.sapGoodsReceiptId > 0)
                    ? TextFormField(
                        controller: _sapGoodsReceiptNoController,
                        enabled: false,
                        style: TextStyle(fontSize: 16, color: Colors.red),
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
                Padding(padding: EdgeInsets.only(top: 5)),
                (data.sapGoodsIssueId > 0)
                    ? TextFormField(
                        controller: _sapGoodsIssueNoController,
                        enabled: false,
                        style: TextStyle(fontSize: 16, color: Colors.red),
                        decoration: InputDecoration(
                            hintText: "Issue No.",
                            labelText: "Issue No.",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0))),
                      )
                    : Container(width: 0, height: 0),
                Padding(padding: EdgeInsets.only(top: 5)),
                (data.baseId > 0)
                    ? TextFormField(
                        controller: _baseNoController,
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: "Base No.",
                            labelText: "Base No.",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0))))
                    : Container(width: 0, height: 0),
                FlatButton(
                  padding: EdgeInsets.only(top: 5),
                  onPressed: () {
                    if (data.sapGoodsReceiptId == 0) {
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
                                    )))),
                      ),
                      (data.sapGoodsReceiptId == 0)
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
                      Future<cflReceiptProductionLabel.Data> wo =
                          Navigator.push(
                              context,
                              MaterialPageRoute<cflReceiptProductionLabel.Data>(
                                  builder: (BuildContext context) =>
                                      CflReceiptProductionLabelPage()));

                      wo.then((cflReceiptProductionLabel.Data wo) {
                        if (wo != null) {
                          _webIdController.text = wo.id.toString(); //webId
                          _webNoController.text = wo.transNo; // WebNo
                          _woIdController.text = wo.woId.toString();
                          _woNoController.text = wo.woNo;
                          _productCodeController.text = wo.productCode;
                          _productNameController.text = wo.productName;
                          _refreshDetailItem();
                        }
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
                                "Production Order No.",
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 12.0),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.only(left: 5),
                                title: Text(_woNoController.text),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(_webNoController.text),
                                    Text(_productCodeController.text),
                                    Text(_productNameController.text),
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
        ]);
  }

  Widget _rowDetail(Data data, List<Item> items, int index) {
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
          title: Text("${items[index].itemName}"),
          subtitle: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Item Code : ${items[index].itemCode}",
              ),
              Text(
                  "Open Qty : ${NumberFormat("#,###.##").format(items[index].openQty)}" +
                      " ${items[index].uom}"),
              Text(
                  "Planned Qty : ${NumberFormat("#,###.##").format(items[index].woQty)}" +
                      " ${items[index].uom}"),
              Text(
                  "Quantity : ${NumberFormat("#,###.##").format(items[index].qty)}" +
                      " ${items[index].uom}"),
              // Text("Batch No. : ${data[index].batchNo}"),
              // Text(data[index].whsCode ?? ''),
            ],
          ),
          trailing: items[index].valuationMethod == 'FIFO' &&
                  data.sapGoodsIssueId == 0 &&
                  data.sapGoodsReceiptId == 0 &&
                  data.status != "Cancel"
              // ? IconButton(
              //     icon: Icon(Icons.keyboard_arrow_right),
              //     iconSize: 30.0,
              //     onPressed: () {
              //       _showItemDetail(index);
              //     },

              //   )
              ? RaisedButton(
                  onPressed: () {
                    _showItemDetail(index);
                  },
                  color: bgBlue,
                  child: Text(
                    "ADD",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              : data.sapGoodsIssueId == 0 &&
                      data.sapGoodsReceiptId == 0 &&
                      data.status != "Cancel"
                  ? RaisedButton(
                      onPressed: () {
                        _showItemDetail(index);
                      },
                      color: bgOrange,
                      child: Text(
                        "SCAN",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : IconButton(
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
    final data = state.data;

    return ListView.builder(
      controller: _scrollController,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: data.items.length,
      itemBuilder: (contex, index) {
        if (_getState().data.sapGoodsReceiptId == 0) {
          return Dismissible(
            key: Key(data.items[index].hashCode.toString()),
            onDismissed: (direction) {
              bloc.emitEvent(
                  GoodsReceiptDetailEventItemRemove(itemIndex: index));
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
            child: _rowDetail(data, data.items, index),
          );
        } else {
          return _rowDetail(data, data.items, index);
        }
      },
    );
  }
}
