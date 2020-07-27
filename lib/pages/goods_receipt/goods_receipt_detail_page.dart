import 'dart:convert';

import 'package:admart_app/pages/cfl/cfl_transfer_production_page.dart';
import 'package:admart_app/pages/goods_receipt/goods_receipt_detail_item_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:admart_app/bloc_widgets/bloc_state_builder.dart';
import 'package:admart_app/blocs/goods_receipt/detail/goods_receipt_detail_bloc.dart';
import 'package:admart_app/blocs/goods_receipt/detail/goods_receipt_detail_event.dart';
import 'package:admart_app/blocs/goods_receipt/detail/goods_receipt_detail_state.dart';
import 'package:admart_app/blocs/global_bloc.dart';
import 'package:admart_app/models/goods_receipt_detail_response.dart';
import 'package:admart_app/widgets/set_colors.dart';
import 'package:admart_app/widgets/validate_dialog_widget.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:uuid/uuid.dart';
import 'package:admart_app/models/cfl_transfer_production_response.dart'
    as cflTransferProduction;
import 'package:admart_app/pages/barcode_scan.dart';
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

  final _woIdController = TextEditingController();
  final _woNoController = TextEditingController();
  final _productCodeController = TextEditingController();
  final _productNameController = TextEditingController();
  final _transNoController = TextEditingController();
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
    _woIdController?.dispose();
    _woNoController?.dispose();
    _productCodeController?.dispose();
    _productNameController?.dispose();
    _transNoController?.dispose();
    _transDateController?.dispose();
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

    bloc.emitEvent(GoodsReceiptDetailEventAdd(
      data: data,
    ));
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
        title: Text("Create Receipt"),
        backgroundColor: bgBlue,
        bottom: PreferredSize(
            child: Container(
              color: bgOrange,
              height: 5.0,
            ),
            preferredSize: Size.fromHeight(5.0)),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.check),
            onPressed: () {
              _create();
            },
            textColor: Colors.white,
            label: Text("Submit"),
          )
        ],
      );
    } else {
      return AppBar(
        title: Text("Receipt For Production"),
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
      ValidateDialogWidget(context: context, message: "WO No harus di isi");
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
      bloc.emitEvent(GoodsReceiptDetailEventRefresh(
          woId: int.parse(_getState().data.woId.toString())));
    } on PlatformException catch (ex) {
      if (ex.code != "") {
        ValidateDialogWidget(
            context: context, message: "Refresh : Permition was denied");
        return;
      } else {
        ValidateDialogWidget(
            context: context, message: "Refresh : Unknown error $ex");
        return;
      }
    } on FormatException {
      // ValidateDialogWidget(
      //     context: context,
      //     message: "Scan : You press back button before scan");
      return;
    } catch (ex) {
      ValidateDialogWidget(
          context: context, message: "Refresh : Unknown error $ex");
      return;
    }
  }

  Future _scanQR() async {
    if (["", null].contains(_woNoController.text)) {
      ValidateDialogWidget(context: context, message: "WO No harus di isi");
      return;
    }
    var data = _getState().data;

    try {
      String qrResult = await BarcodeScanner.scan();
      for (var item in _getState().data.items) {
        if (("${item.batchNo}" == qrResult)) {
          ValidateDialogWidget(
              context: context, message: 'Item sudah pernah di scan');
          return;
        }
      }

      bloc.emitEvent(GoodsReceiptDetailEventScan(
          woId: int.parse(_woIdController.text),
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
        bloc.emitEvent(GoodsReceiptDetailEventNormal());
        Future<Item> item = Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                GoodsReceiptDetailItemDetailPage(newItem),
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
              floatingActionButton: _getState().data.id == 0
                  ? FloatingActionButton.extended(
                      icon: Icon(Icons.camera_alt),
                      backgroundColor: btnBgOrange,
                      label: Text("Scan"),
                      onPressed: () {
                        _scanQR();
                        //_refreshDetailItem();
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
            GoodsReceiptDetailItemDetailPage(items[itemIndex]),
      ),
    );

    item.then((Item item) {
      if (item != null) {
        bloc.emitEvent(GoodsReceiptDetailEventItemUpdate(
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
      _woIdController.text = data.woId.toString();
      _woNoController.text = data.woNo;
      _productCodeController.text = data.productCode;
      _productNameController.text = data.productName;
      transDate = data.transDate;
      if (transDate != null) {
        _transDateController.text = DateFormat("dd-MM-yyyy").format(transDate);
      } else {
        _transDateController.text = null;
      }
      _seriesNamePoController.text = data.seriesNameWo;
      _seriesNameController.text = data.seriesName;
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
                    controller: _transNoController,
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: "Receipt Production No.",
                        labelText: "Receipt Production No.",
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0)))),
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
                                    )))),
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
                      Future<cflTransferProduction.Data> wo = Navigator.push(
                          context,
                          MaterialPageRoute<cflTransferProduction.Data>(
                              builder: (BuildContext context) =>
                                  CflTransferProductionPage()));

                      wo.then((cflTransferProduction.Data wo) {
                        if (wo != null) {
                          _woIdController.text = wo.id.toString();
                          _woNoController.text = wo.transNo;
                          _productCodeController.text = wo.productCode;
                          _productNameController.text = wo.productName;
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
              Text(data[index].itemCode),
              Text("Qty : ${NumberFormat("#,###.00").format(data[index].qty)}"),
              Text(data[index].batchNo ?? ''),
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
      itemCount: data.length,
      itemBuilder: (contex, index) {
        if (_getState().data.id == 0) {
          return Dismissible(
            key: Key(data[index].hashCode.toString()),
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
            child: _rowDetail(data, index),
          );
        } else {
          return _rowDetail(data, index);
        }
      },
    );
  }
}
