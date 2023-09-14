import 'dart:convert';

import 'package:shimmer/shimmer.dart';
import 'package:wins_app/pages/cfl/cfl_transfer_production_page.dart';
import 'package:wins_app/pages/goods_issue_mixing/goods_issue_mixing_detail_item_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:wins_app/bloc_widgets/bloc_state_builder.dart';
import 'package:wins_app/blocs/goods_issue_mixing/detail/goods_issue_mixing_detail_bloc.dart';
import 'package:wins_app/blocs/goods_issue_mixing/detail/goods_issue_mixing_detail_event.dart';
import 'package:wins_app/blocs/goods_issue_mixing/detail/goods_issue_mixing_detail_state.dart';
import 'package:wins_app/blocs/global_bloc.dart';
import 'package:wins_app/models/goods_issue_mixing_detail_response.dart';
import 'package:wins_app/pages/goods_receipt/goods_receipt_detail_page.dart';
import 'package:wins_app/widgets/set_colors.dart';
import 'package:wins_app/widgets/validate_dialog_widget.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:uuid/uuid.dart';
import 'package:wins_app/models/cfl_transfer_production_response.dart'
    as cflTransferProduction;
import 'package:wins_app/pages/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audio_cache.dart';

class GoodsIssueMixingDetailPage extends StatefulWidget {
  GoodsIssueMixingDetailPage(this._id);
  final int _id;
  //final Data _newData;
  @override
  _GoodsIssueMixingDetailPageState createState() =>
      _GoodsIssueMixingDetailPageState(_id);
}

class _GoodsIssueMixingDetailPageState
    extends State<GoodsIssueMixingDetailPage> {
  _GoodsIssueMixingDetailPageState(this._id);

  GoodsIssueMixingDetailBloc bloc = GoodsIssueMixingDetailBloc();
  final int _id;
  //final Data _newData;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController;
  final _idTxController = TextEditingController();
  final _woIdController = TextEditingController();
  final _woNoController = TextEditingController();
  final _productCodeController = TextEditingController();
  final _productNameController = TextEditingController();
  final _transNoController = TextEditingController();
  final _transDateController = TextEditingController();
  final _baseNoController = TextEditingController();
  final _seriesNameWoController = TextEditingController();
  final _seriesNameController = TextEditingController();
  final _sapGoodsIssueNoController = TextEditingController();
  final _sapGoodsReceiptNoController = TextEditingController();
  final _statusController = TextEditingController();
  final _player = AudioCache();
  DateTime transDate; // = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (_id != 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bloc.emitEvent(GoodsIssueMixingDetailEventGetId(
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
    _statusController?.dispose();
    _idTxController?.dispose();
    _woIdController?.dispose();
    _woNoController?.dispose();
    _productCodeController?.dispose();
    _productNameController?.dispose();
    _transNoController?.dispose();
    _transDateController?.dispose();
    _baseNoController?.dispose();
    _seriesNameWoController?.dispose();
    _seriesNameController?.dispose();
    _sapGoodsIssueNoController?.dispose();

    bloc?.dispose();
    super.dispose();
  }

  void _create() {
    String productionType = _seriesNameWoController.text.substring(0, 5);
    var state = (bloc.lastState ?? bloc.initialState);
    var data = state.data; // (bloc.lastState ?? bloc.initialState).data;
    data.woNo = _woNoController.text;
    data.woId = int.parse(_woIdController.text);
    data.transDate = transDate;
    data.seriesName = _seriesNameController.text;
    data.seriesNameWo = _seriesNameWoController.text;
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
                "${item.woVisOrder}" +
                ' : Quantity tidak boleh kosong/0');
        return;
      }
      // if ((productionType != 'SPKMW' || productionType != 'SPKMT') &&
      //     (double.parse("${item.qty}") > double.parse("${item.woQty}"))) {
      //   ValidateDialogWidget(
      //       context: context,
      //       message: 'Line ' +
      //           "${item.woVisOrder}" +
      //           ' : Quantity tidak boleh lebih besar dari Planned Quantity');
      //   return;
      // }
      // if ((productionType != 'SPKMW' || productionType != 'SPKMT') &&
      //     (double.parse("${item.qty}") < double.parse("${item.woQty}"))) {
      //   ValidateDialogWidget(
      //       context: context,
      //       message: 'Line ' +
      //           "${item.woVisOrder}" +
      //           ' : Quantity tidak boleh kurang dari Planned Quantity');
      //   return;
      // }
    }

    bloc.emitEvent(GoodsIssueMixingDetailEventAdd(
      data: data,
    ));
  }

  void _updateTransDate() {
    var state = (bloc.lastState ?? bloc.initialState);
    var data = Data(); //state.data;

    if (!state.isBusy) {
      data.id = int.parse(_idTxController.text);
      data.woNo = _woNoController.text;
      data.woId = int.parse(_woIdController.text);
      data.transDate = transDate;
      data.seriesName = _seriesNameController.text;
      data.seriesNameWo = _seriesNameWoController.text;
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

      String setTransDate = DateFormat("yyyy-MM-dd").format(transDate);
      bloc.emitEvent(
        GoodsIssueMixingDetailEventUpdateTransDate(
          id: int.parse(_idTxController.text),
          transDate: setTransDate,
        ),
      );
    }
  }

  void _post() {
    var state = (bloc.lastState ?? bloc.initialState);
    var data = state.data; // (bloc.lastState ?? bloc.initialState).data;
    data.sapGoodsIssueNo = _sapGoodsIssueNoController.text;
    data.woNo = _woNoController.text;
    data.woId = int.parse(_woIdController.text);
    data.transDate = transDate;
    data.seriesName = _seriesNameController.text;
    data.seriesNameWo = _seriesNameWoController.text;
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
                "${item.woVisOrder}" +
                ' : Quantity tidak boleh kosong/0');
        return;
      }
    }

    bloc.emitEvent(GoodsIssueMixingDetailEventPost(
      data: data,
    ));
  }

  void _newTrans() {
    MaterialPageRoute newRoute = MaterialPageRoute(
        builder: (BuildContext context) => GoodsIssueMixingDetailPage(0));
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
                    bloc.emitEvent(GoodsIssueMixingDetailEventNormal());
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
                    bloc.emitEvent(GoodsIssueMixingDetailEventNormal());
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
      _updateTransDate();
    }
  }

  PreferredSizeWidget _appBar() {
    if (_getState().data.sapGoodsIssueId == 0 &&
        _getState().data.id > 0 &&
        _getState().data.status != "Cancel" &&
        !_getState().isBusy) {
      return AppBar(
        title: Text("Create Issue"),
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
                child: const Text('Submit'),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(15, 15)),
                ),
                onPressed: () {
                  showAlertDialogSubmit(context);
                },
              )),
        ],
      );
    } else if (_getState().data.sapGoodsIssueId > 0 &&
        _getState().data.sapGoodsReceiptId == 0 &&
        !_getState().isBusy) {
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
    } else if (!_getState().isBusy) {
      return AppBar(
        title: Text("Issue For Production"),
        backgroundColor: bgBlue,
        bottom: PreferredSize(
            child: Container(
              color: bgOrange,
              height: 5.0,
            ),
            preferredSize: Size.fromHeight(5.0)),
        actions: <Widget>[
          (globalBloc.loginResponse.data.goodsIssueMixing_Auth_Add == 'Y')
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
        automaticallyImplyLeading: false,
        title: Text("Issue For Production"),
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

  GoodsIssueMixingDetailState _getState() {
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

      bloc.emitEvent(GoodsIssueMixingDetailEventRefresh(
        woId: int.parse(_woIdController.text),
        transDate: setTransDate,
      ));
    } catch (ex) {
      ValidateDialogWidget(
          context: context, message: "Refresh : Unknown error $ex");
      return;
    }
  }

  Future _refreshAfter() async {
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
      bloc.emitEvent(
        GoodsIssueMixingDetailEventRefreshAfter(
            id: _id, newData: _getState().data),
      );
    } catch (ex) {
      ValidateDialogWidget(
          context: context, message: "Refresh : Unknown error $ex");
      return;
    }
  }

  Future _resetData() async {
    if (["", null].contains(_woNoController.text)) {
      ValidateDialogWidget(
          context: context, message: "Production Order No harus di isi");
      return;
    }

    if ((_sapGoodsIssueNoController.text.isNotEmpty)) {
      ValidateDialogWidget(
          context: context,
          message: "Document tidak dapat diproses, sudah terbuat Goods Issue");
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
        GoodsIssueMixingDetailEventResetData(id: data.id, woId: data.woId),
      );
    } catch (ex) {
      ValidateDialogWidget(
          context: context, message: "Refresh : Unknown error $ex");
      return;
    }
  }

  Future _deleteData() async {
    if (["", null].contains(_woNoController.text)) {
      ValidateDialogWidget(
          context: context, message: "Production Order No harus di isi");
      return;
    }

    if ((_sapGoodsIssueNoController.text.isNotEmpty)) {
      ValidateDialogWidget(
          context: context,
          message: "Document tidak dapat diproses, sudah terbuat Goods Issue");
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
        GoodsIssueMixingDetailEventCancel(id: data.id, data: data),
      );
    } catch (ex) {
      ValidateDialogWidget(
          context: context, message: "Delete : Unknown error $ex");
      return;
    }
  }

  // Future _scanQR() async {
  //   if (["", null].contains(_woNoController.text)) {
  //     ValidateDialogWidget(context: context, message: "WO No harus di isi");
  //     return;
  //   }
  //   var data = _getState().data;

  //   try {
  //     String qrResult = await BarcodeScanner.scan();
  //     for (var item in _getState().data.items) {
  //       if (("${item.batchNo}" == qrResult)) {
  //         ValidateDialogWidget(
  //             context: context, message: 'Item sudah pernah di scan');
  //         return;
  //       }
  //     }

  //     bloc.emitEvent(GoodsIssueMixingDetailEventScan(
  //         woId: int.parse(_woIdController.text),
  //         woNo: _woNoController.text,
  //         qrResult: qrResult,
  //         data: data));
  //   } on PlatformException catch (ex) {
  //     if (ex.code == BarcodeScanner.CameraAccessDenied) {
  //       ValidateDialogWidget(
  //           context: context, message: "Scan : Camera permition was denied");
  //       return;
  //     } else {
  //       ValidateDialogWidget(
  //           context: context, message: "Scan : Unknown error $ex");
  //       return;
  //     }
  //   } on FormatException {
  //     // ValidateDialogWidget(
  //     //     context: context,
  //     //     message: "Scan : You press back button before scan");
  //     return;
  //   } catch (ex) {
  //     ValidateDialogWidget(
  //         context: context, message: "Scan : Unknown error $ex");
  //     return;
  //   }
  // }

  void _showScanNewItemDetail() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var newItem = _getState().newItem;
      var newData = _getState().data;
      if (newItem != null) {
        bloc.emitEvent(GoodsIssueMixingDetailEventNormal());
        Future<Item> item = Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                GoodsIssueMixingDetailItemDetailPage(newItem, 0, newData),
          ),
        );

        item.then((Item item) {
          if (item != null) {
            bloc.emitEvent(GoodsIssueMixingDetailEventItemAdd(
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
    var getData = _getState().data;

    return BlocEventStateBuilder<GoodsIssueMixingDetailState>(
        bloc: bloc,
        builder: (BuildContext context, GoodsIssueMixingDetailState state) {
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
                    // _showCircularProgress(),
                  ]),
                ),
                //Floating Button
                floatingActionButton: !_getState().isBusy
                    ? Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FloatingActionButton(
                              heroTag: "btnReset",
                              backgroundColor: Colors.green,
                              tooltip: "Reset",
                              child: Icon(Icons.autorenew),
                              onPressed: () {
                                showAlertDialogReset(context);
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            FloatingActionButton(
                              heroTag: "btnCreateNew",
                              backgroundColor: Colors.blue,
                              tooltip: "New Document",
                              child: Icon(Icons.create),
                              onPressed: () {
                                showAlertDialogCreateNew(context);
                              },
                            ),
                            SizedBox(
                              width: 10,
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
                        ),
                      )
                    : Container(
                        height: 0,
                        width: 0,
                      )),
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
    final newData = _getState().data;
    final items = _getState().data.items;

    Future<Item> item = Navigator.push(
      context,
      MaterialPageRoute<Item>(
        builder: (BuildContext context) => GoodsIssueMixingDetailItemDetailPage(
            items[itemIndex], itemIndex, newData),
      ),
    );
    int _idItem = items[itemIndex].id;
    item.then((Item item) {
      if (item != null) {
        // bloc.emitEvent(GoodsIssueMixingDetailEventItemUpdate(
        //   item: item,
        //   itemIndex: itemIndex,
        // ));

        WidgetsBinding.instance.addPostFrameCallback((_) {
          bloc.emitEvent(GoodsIssueMixingDetailEventGetId(
            id: _idItem,
          ));
        });
      }
    });
  }

  Widget _buildForm() {
    _errorMessage();
    _successMessage();
    _showScanNewItemDetail();
    var state = bloc.lastState ?? bloc.initialState;
    var data = state.data;
    _woIdController.text = data.woId.toString();
    _woNoController.text = data.woNo;
    _transNoController.text = data.transNo;

    if (transDate != null) {
      _transDateController.text = DateFormat("dd-MM-yyyy").format(transDate);
    } else {
      _transDateController.text = null;
    }

    if (data.sapGoodsReceiptId != 0) {
      _sapGoodsReceiptNoController.text = data.sapGoodsReceiptNo;
    }
    if (data.id != 0) {
      _statusController.text = data.status;
      _idTxController.text = data.id.toString();
      _woIdController.text = data.woId.toString();
      _woNoController.text = data.woNo;
      _sapGoodsIssueNoController.text = data.sapGoodsIssueNo;
      _productCodeController.text = data.productCode;
      _productNameController.text = data.productName;
      _transNoController.text =
          data.status == "Cancel" ? data.transNo + " [Canceled]" : data.transNo;
      _baseNoController.text = data.baseNo;
      transDate = data.transDate;
      if (transDate != null) {
        _transDateController.text = DateFormat("dd-MM-yyyy").format(transDate);
      } else {
        _transDateController.text = null;
      }
      _seriesNameWoController.text = data.seriesNameWo;
      _seriesNameController.text = data.seriesName;
    }

    return
        // state.isBusy
        //     ? Shimmer.fromColors(
        //         baseColor: bgBlue,
        //         highlightColor: Colors.orange[100],
        //         child: _form(data, state),
        //       )
        //     :
        _form(data, state);
  }

  Widget _form(Data data, var state) {
    // var state = bloc.lastState ?? bloc.initialState;
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
                      style: TextStyle(fontSize: 16, color: Colors.red),
                      enabled: false,
                      decoration: InputDecoration(
                          hintText: "Issue Production No.",
                          labelText: "Issue Production No.",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0))))
                  : Container(width: 0, height: 0),
              FlatButton(
                padding: EdgeInsets.only(top: 5),
                onPressed: () {
                  if (data.id == 0 && !_getState().isBusy) {
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
                              hintText: "Issue Date",
                              labelText: "Issue Date",
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: (data.id == 0)
                                          ? Colors.blue
                                          : Colors.grey[300]),
                                  borderRadius: new BorderRadius.circular(
                                    10.0,
                                  )))),
                    ),
                    (data.sapGoodsIssueId == 0 && !_getState().isBusy)
                        ? IconButton(
                            icon: Icon(Icons.date_range),
                            onPressed: () {
                              _selectTransDate(context);
                            },
                          )
                        : Container(width: 0, height: 0),
                  ],
                ),
              ),
              (data.sapGoodsReceiptId > 0)
                  ? FlatButton(
                      padding: EdgeInsets.only(top: 5),
                      onPressed: () {},
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                                controller: _sapGoodsReceiptNoController,
                                enabled: false,
                                style:
                                    TextStyle(fontSize: 16, color: Colors.red),
                                decoration: InputDecoration(
                                    hintText: "Goods Receipt Production No.",
                                    labelText: "Goods Receipt Production No.",
                                    contentPadding: new EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 10.0),
                                    disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: (data.id == 0)
                                                ? Colors.blue
                                                : Colors.grey[300]),
                                        borderRadius: new BorderRadius.circular(
                                          10.0,
                                        )))),
                          ),
                          (data.sapGoodsReceiptId > 0)
                              ? IconButton(
                                  icon: Icon(
                                    Icons.view_list,
                                    color: bgOrange,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            GoodsReceiptDetailPage(data.baseId),
                                      ),
                                    );
                                  },
                                )
                              : Container(width: 0, height: 0),
                        ],
                      ),
                    )
                  : Container(width: 0, height: 0),
              (data.baseId > 0)
                  ? FlatButton(
                      padding: EdgeInsets.only(top: 5),
                      onPressed: () {},
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                                controller: _baseNoController,
                                enabled: false,
                                // style: TextStyle(fontSize: 16, color: Colors.red),
                                decoration: InputDecoration(
                                    hintText: "Ref No.",
                                    labelText: "Ref No.",
                                    contentPadding: new EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 10.0),
                                    disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: (data.id == 0)
                                                ? Colors.blue
                                                : Colors.grey[300]),
                                        borderRadius: new BorderRadius.circular(
                                          10.0,
                                        )))),
                          ),
                          (data.baseId > 0)
                              ? IconButton(
                                  icon: Icon(
                                    Icons.view_list,
                                    color: Colors.green,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            GoodsReceiptDetailPage(data.baseId),
                                      ),
                                    );
                                  },
                                )
                              : Container(width: 0, height: 0),
                        ],
                      ),
                    )
                  : Container(width: 0, height: 0),
              FlatButton(
                padding: EdgeInsets.only(top: 5),
                onPressed: () {
                  if (data.id == 0) {
                    Future<cflTransferProduction.Data> wo = Navigator.push(
                        context,
                        MaterialPageRoute<cflTransferProduction.Data>(
                            builder: (BuildContext context) =>
                                CflTransferProductionPage("M")));

                    wo.then((cflTransferProduction.Data wo) {
                      if (wo != null) {
                        _woIdController.text = wo.id.toString();
                        _woNoController.text = wo.transNo;
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
                          color:
                              (data.id == 0) ? Colors.blue : Colors.grey[400]),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Production Order No.",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 12.0),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 5),
                              title: Text(_woNoController.text),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
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
            child: (state.data.items != null ? state.data.items.length : 0) > 0
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
        )
      ],
    );
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
              Text('No. ' + "${items[index].woVisOrder}"),
              Text("Item Code : ${items[index].itemCode}"),

              //Text(data[index].itemCode),
              //Text(data[index].whsCode ?? '-'),
              //Text("Qty : ${NumberFormat("#,###.##").format(data[index].qty)}"),
              Text(
                  "Open Qty : ${NumberFormat("#,###.##").format(items[index].openQty)}" +
                      " ${items[index].uom}"),
              Text(
                  "Planned Qty : ${NumberFormat("#,###.##").format(items[index].woQty)}" +
                      " ${items[index].uom}"),
              //Text('Uom : ' + "${data[index].uom}"),
              // Text(data[index].whsCode ?? ''),

              //Text("Batch No. : ${data[index].batchNo}"),
              Text(
                  "Quantity : ${NumberFormat("#,###.##").format(items[index].qty)}" +
                      " ${items[index].uom}"),
              // Text(data[index].whsCode ?? ''),
              //Text("Warehouse : ${data[index].whsName}"),
            ],
          ),
          trailing: items[index].valuationMethod == 'FIFO' &&
                  data.sapGoodsIssueId == 0 &&
                  data.sapGoodsReceiptId == 0 &&
                  data.status != "Cancel"
              ? RaisedButton(
                  onPressed: () {
                    if (!_getState().isBusy) {
                      _showItemDetail(index);
                    }
                  },
                  color: bgBlue,
                  child: Text(
                    "FIFO",
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
                        if (!_getState().isBusy) {
                          _showItemDetail(index);
                        }
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
                        if (!_getState().isBusy) {
                          _showItemDetail(index);
                        }
                      },
                    ),
        ),
      ),
    );
  }

  Widget _buildList() {
    var state = bloc.lastState ?? bloc.initialState;
    final data = state.data;
    if (data.items != null) {
      return ListView.builder(
        controller: _scrollController,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: data.items.length,
        itemBuilder: (contex, index) {
          if (data.sapGoodsIssueId == 0 && data.id > 0 && !state.isBusy) {
            // return _rowDetail(data, index);
            return Dismissible(
              key: UniqueKey(), //Key(data.items[index].hashCode.toString()),
              onDismissed: (direction) {
                // bloc.emitEvent(
                //     GoodsIssueMixingDetailEventItemRemove(itemIndex: index));
                bloc.emitEvent(GoodsIssueMixingDetailEventRemoveItem(
                    id: data.items[index].id, detId: data.items[index].detId));
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

  // Show Dialog Button
  showAlertDialogSubmit(BuildContext context) {
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
        _create();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Perhatian !!!"),
      content: Text(
          "Apakah anda yakin Submit document? Jika menyimpan dokumen ini akan otomatis membuat Goods Issue dan Goods Receipt"),
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

  showAlertDialogCreateNew(BuildContext context) {
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
        _newTrans();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Perhatian !!!"),
      content: Text("Apakah anda ingin membuat Dokumen Baru ?"),
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

  showAlertDialogRefresh(BuildContext context) {
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
        _refreshAfter();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Perhatian !!!"),
      content: Text("Apakah anda ingin Refresh Data ?"),
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

  showAlertDialogReset(BuildContext context) {
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
        _resetData();
        // showModalBottomSheet<void>(
        //   context: context,
        //   isDismissible: false,
        //   builder: (BuildContext context) {
        //     return SizedBox(
        //       height: 200,
        //       child: Center(
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           mainAxisSize: MainAxisSize.min,
        //           children: <Widget>[
        //             // _showCircularProgress(),
        //             RaisedButton(
        //               onPressed: () {
        //                 _resetData();
        //                 Navigator.of(context).pop();
        //               },
        //               color: bgOrange,
        //               child: Text(
        //                 "Refresh",
        //                 style: TextStyle(
        //                   color: Colors.white,
        //                   fontWeight: FontWeight.w600,
        //                 ),
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //     );
        //   },
        // );
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Perhatian !!!"),
      content: Text(
          "Data Item akan di reset, Batch Number yang sudah di scan akan dihapus"),
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
}
