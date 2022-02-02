import 'dart:convert';

import 'package:wins_app/pages/cfl/cfl_binlocation_page.dart';
import 'package:wins_app/pages/cfl/cfl_db_warehouse_page.dart';
import 'package:wins_app/pages/cfl/cfl_production_order_page.dart';
import 'package:wins_app/pages/cfl/cfl_warehouse_page.dart';
import 'package:wins_app/pages/transfer_production/transfer_production_detail_item_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:wins_app/bloc_widgets/bloc_state_builder.dart';
import 'package:wins_app/blocs/transfer_production/detail/transfer_production_detail_bloc.dart';
import 'package:wins_app/blocs/transfer_production/detail/transfer_production_detail_event.dart';
import 'package:wins_app/blocs/transfer_production/detail/transfer_production_detail_state.dart';
import 'package:wins_app/blocs/global_bloc.dart';
import 'package:wins_app/models/transfer_production_detail_response.dart';
import 'package:wins_app/widgets/set_colors.dart';
import 'package:wins_app/widgets/validate_dialog_widget.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:uuid/uuid.dart';
import 'package:wins_app/models/cfl_db_warehouse_model.dart' as cflDbWarehouse;
import 'package:wins_app/pages/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:wins_app/models/cfl_production_order_response.dart'
    as cflProductionOrder;
import 'package:wins_app/models/cfl_warehouse_response.dart' as cflWarehouse;
import 'package:wins_app/models/cfl_binlocation_response.dart'
    as cflBinLocation;

class TransferProductionDetailPage extends StatefulWidget {
  TransferProductionDetailPage(this._id);
  final int _id;
  @override
  _TransferProductionDetailPageState createState() =>
      _TransferProductionDetailPageState(_id);
}

class _TransferProductionDetailPageState
    extends State<TransferProductionDetailPage> {
  _TransferProductionDetailPageState(this._id);

  TransferProductionDetailBloc bloc = TransferProductionDetailBloc();
  final int _id;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController;

  final _woIdController = TextEditingController();
  final _woNoController = TextEditingController();
  final _woDateController = TextEditingController();
  final _productCodeController = TextEditingController();
  final _productNameController = TextEditingController();
  final _transNoController = TextEditingController();
  final _transDateController = TextEditingController();
  final _fromWhsCodeController = TextEditingController();
  final _fromWhsNameController = TextEditingController();
  final _fromAbsEntryController = TextEditingController();
  final _fromBinCodeController = TextEditingController();
  final _toWhsCodeController = TextEditingController();
  final _toWhsNameController = TextEditingController();
  final _toAbsEntryController = TextEditingController();
  final _toBinCodeController = TextEditingController();

  DateTime transDate; // = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (_id != 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bloc.emitEvent(TransferProductionDetailEventGetId(
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
    _woDateController?.dispose();
    _productCodeController?.dispose();
    _productNameController?.dispose();
    _transNoController?.dispose();
    _transDateController?.dispose();
    _fromWhsCodeController?.dispose();
    _fromWhsNameController?.dispose();
    _toWhsCodeController?.dispose();
    _toWhsNameController?.dispose();
    _toAbsEntryController?.dispose();
    _toBinCodeController?.dispose();

    bloc?.dispose();

    super.dispose();
  }

  void _create() {
    var state = (bloc.lastState ?? bloc.initialState);
    var data = Data(); // (bloc.lastState ?? bloc.initialState).data;
    data.woNo = _woNoController.text;
    data.productCode = _productCodeController.text;
    data.productName = _productNameController.text;
    data.transDate = transDate;
    data.fromWhsCode = _fromWhsCodeController.text;
    data.fromWhsName = _fromWhsNameController.text;
    //data.fromAbsEntry = int.parse(_fromAbsEntryController.text);
    //data.fromBinCode = _fromBinCodeController.text;
    data.toWhsCode = _toWhsCodeController.text;
    data.toWhsName = _toWhsNameController.text;
    data.toBinCode = _toBinCodeController.text;
    data.items = state.data.items;

    if ([null].contains(data.transDate)) {
      ValidateDialogWidget(
          context: context, message: "Production Date harus di isi");
      return;
    } else if (["", null].contains(data.woNo)) {
      ValidateDialogWidget(
          context: context, message: "Production Order No harus di isi");
      return;
    } else if ([null, ""].contains(data.fromWhsCode)) {
      ValidateDialogWidget(
          context: context, message: "Warehouse from harus di isi");
      return;
    } else if ([null, ""].contains(data.toWhsCode)) {
      ValidateDialogWidget(
          context: context, message: "Warehouse to harus di isi");
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

    data.woId = int.parse(_woIdController.text);
    data.toAbsEntry = int.parse(_toAbsEntryController.text);

    bloc.emitEvent(TransferProductionDetailEventAdd(
      data: data,
    ));

    // _submitMessage(data);
  }

  void _newTrans() {
    MaterialPageRoute newRoute = MaterialPageRoute(
        builder: (BuildContext context) => TransferProductionDetailPage(0));
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
                    bloc.emitEvent(TransferProductionDetailEventNormal());
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
                    bloc.emitEvent(TransferProductionDetailEventNormal());
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

  void _submitMessage(Data data) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String submitMessage =
          "Do you want to save it, Please check Information before Submiting!";
      if ((submitMessage != null) && (submitMessage != "")) {
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Submit : '),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text("${submitMessage}"),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    bloc.emitEvent(TransferProductionDetailEventNormal());
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('Continue'),
                  onPressed: () {},
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
        title: Text("Create Transfer Production"),
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
              label: Text("Submit"))
        ],
      );
    } else {
      return AppBar(
        title: Text("Transfer Production"),
        backgroundColor: bgBlue,
        bottom: PreferredSize(
            child: Container(
              color: bgOrange,
              height: 5.0,
            ),
            preferredSize: Size.fromHeight(5.0)),
        actions: <Widget>[
          (globalBloc.loginResponse.data.transferProduction_Auth_Add == 'Y')
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

  TransferProductionDetailState _getState() {
    return bloc.lastState ?? bloc.initialState;
  }

  BuildContext _context;

  Future _scanQR() async {
    if (["", null].contains(_woNoController.text)) {
      ValidateDialogWidget(
          context: context, message: "Production Order No harus di isi");
      return;
    } else if (["", null].contains(_fromWhsCodeController.text)) {
      ValidateDialogWidget(
          context: context, message: "Warehouse from harus di isi");
      return;
    } else if (["", null].contains(_toWhsCodeController.text)) {
      ValidateDialogWidget(
          context: context, message: "Warehouse to harus di isi");
      return;
    }
    //else if (_fromWhsCodeController.text == _toWhsCodeController.text) {
    //   ValidateDialogWidget(
    //       context: context, message: "Warehouse from dan to tidak boleh sama");
    //   return;
    // }

    var data = _getState().data;

    try {
      String qrResult = await BarcodeScanner.scan();
      for (var item in _getState().data.items) {
        //if (("${item.itemCode}-${item.batchNo}" == qrResult)) {
        if (("${item.batchNo}" == qrResult)) {
          ValidateDialogWidget(
              context: context, message: 'Batch No. sudah pernah di scan');
          return;
        }
      }

      bloc.emitEvent(TransferProductionDetailEventScan(
          woId: int.parse(_woIdController.text),
          woNo: _woNoController.text,
          fromWhsCode: _fromWhsCodeController.text,
          qrResult: qrResult,
          data: data));

      // bloc
      //     .eventHandler(
      //         TransferProductionDetailEventScan(
      //             woId: int.parse(_woIdController.text),
      //             fromWhsCode: _fromWhsCodeController.text,
      //             qrResult: qrResult,
      //             data: data),
      //         _getState())
      //     .listen((onData) {
      //   if (onData.newItem != null) {
      //     Future<Item> item = Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (BuildContext context) =>
      //             TransferProductionDetailItemDetailPage(onData.newItem),
      //       ),
      //     );

      //     item.then((Item item) {
      //       if (item != null) {
      //         bloc.emitEvent(TransferProductionDetailEventItemAdd(
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
        bloc.emitEvent(TransferProductionDetailEventNormal());
        Future<Item> item = Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                TransferProductionDetailItemDetailPage(newItem),
          ),
        );

        item.then((Item item) {
          if (item != null) {
            bloc.emitEvent(TransferProductionDetailEventItemAdd(
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
    return BlocEventStateBuilder<TransferProductionDetailState>(
        bloc: bloc,
        builder: (BuildContext context, TransferProductionDetailState state) {
          return SafeArea(
            child: Scaffold(
              key: _scaffoldKey,
              appBar: _appBar(),
              body: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: bgGradientPageWhite,
                ),
                // constraints: BoxConstraints.expand(),
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
                      backgroundColor: bgOrange,
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
            TransferProductionDetailItemDetailPage(items[itemIndex]),
      ),
    );

    item.then((Item item) {
      if (item != null) {
        bloc.emitEvent(TransferProductionDetailEventItemUpdate(
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
      transDate = data.transDate;
      if (transDate != null) {
        _transDateController.text = DateFormat("dd-MM-yyyy").format(transDate);
      } else {
        _transDateController.text = null;
      }
      _woNoController.text = data.woNo;
      if (data.woDate != null) {
        _woDateController.text = DateFormat("dd-MM-yyyy").format(data.woDate);
      } else {
        _woDateController.text = "";
      }

      _productCodeController.text = data.productCode;
      _productNameController.text = data.productName;
      _fromWhsCodeController.text = data.fromWhsCode;
      _fromWhsNameController.text = data.fromWhsName;
      _toWhsCodeController.text = data.toWhsCode;
      _toWhsNameController.text = data.toWhsName;
      _toBinCodeController.text = data.toBinCode;
    }
    // else {
    //   _fromWhsCodeController.text =
    //       globalBloc.loginResponse.data.transferProduction_WhsCodeFrom ?? '';
    //   _fromWhsNameController.text =
    //       globalBloc.loginResponse.data.transferProduction_WhsNameFrom ?? '';
    //   _toWhsCodeController.text =
    //       globalBloc.loginResponse.data.transferProduction_WhsCodeTo ?? '';
    //   _toWhsNameController.text =
    //       globalBloc.loginResponse.data.transferProduction_WhsCodeTo ?? '';
    // }

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
                    style: TextStyle(fontSize: 16, color: Colors.red),
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: "Transfer No.",
                        labelText: "Transfer No.",
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0)))),
                FlatButton(
                  padding: EdgeInsets.only(top: 7),
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
                      Future<cflProductionOrder.Data> prodOrder =
                          Navigator.push(
                              context,
                              MaterialPageRoute<cflProductionOrder.Data>(
                                  builder: (BuildContext context) =>
                                      CflProductionOrderPage()));

                      prodOrder.then((cflProductionOrder.Data prodOrder) {
                        if (prodOrder != null) {
                          _woIdController.text = prodOrder.id.toString();
                          _woNoController.text = prodOrder.transNo;
                          _woDateController.text = DateFormat("dd-MM-yyyy")
                              .format(prodOrder.transDate);
                          _productCodeController.text = prodOrder.productCode;
                          _productNameController.text = prodOrder.productName;
                          _fromWhsCodeController.text = prodOrder.whsCode;
                          _fromWhsNameController.text = prodOrder.whsName;
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
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Production Order No",
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 12.0),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.all(0),
                                title: Text(_woNoController.text),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(_woDateController.text),
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
                                "Product",
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 12.0),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.only(left: 5),
                                title: Text(_productNameController.text),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(_productCodeController.text),
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
                 Padding(padding: EdgeInsets.only(top: 10)),
                FlatButton(
                  padding: EdgeInsets.only(top: 5),
                  onPressed: () {
                    if (data.id == 0) {
                      Future<cflWarehouse.Data> whs = Navigator.push(
                          context,
                          MaterialPageRoute<cflWarehouse.Data>(
                              builder: (BuildContext context) =>
                                  CflWarehousePage(globalBloc.branchId)));

                      whs.then((cflWarehouse.Data whs) {
                        setState(() {
                          // if (whs != null) {
                          //   _fromWhsCodeController.text = whs.whsCode;
                          //   _fromWhsNameController.text = whs.whsName;
                          // }
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
                                "From Warehouse",
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 12.0),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.only(left: 5),
                                title: Text( _fromWhsCodeController.text),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(_fromWhsNameController.text),
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
                //     if (data.id == 0) {
                //       Future<cflDbWarehouse.CflDbWarehouseModel> warehouse =
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute<
                //                       cflDbWarehouse.CflDbWarehouseModel>(
                //                   builder: (BuildContext context) =>
                //                       CflDbWarehousePage()));

                //       warehouse
                //           .then((cflDbWarehouse.CflDbWarehouseModel warehouse) {
                //         if (warehouse != null || _woIdController.text != null) {
                //           _fromWhsCodeController.text = warehouse.whsCode;
                //           _fromWhsNameController.text = warehouse.whsName;
                //         }
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
                //                 "From Warehouse",
                //                 style: TextStyle(
                //                     color: Colors.blue, fontSize: 12.0),
                //               ),
                //               ListTile(
                //                 contentPadding: EdgeInsets.all(0),
                //                 title: Text(_fromWhsCodeController.text),
                //                 subtitle: Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: <Widget>[
                //                     Text(_fromWhsNameController.text),
                //                   ],
                //                 ),
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
                // FlatButton(
                //   padding: EdgeInsets.only(top: 5),
                //   onPressed: () {
                //     if (data.id == 0) {
                //       Future<cflBinLocation.Data> bin = Navigator.push(
                //           context,
                //           MaterialPageRoute<cflBinLocation.Data>(
                //               builder: (BuildContext context) =>
                //                   CflBinLocationPage(
                //                       _fromWhsCodeController.text)));

                //       bin.then((cflBinLocation.Data bin) {
                //         if (bin != null) {
                //           _fromAbsEntryController.text =
                //               bin.absEntry.toString();
                //           _fromBinCodeController.text = bin.binCode;
                //         }
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
                //                 "From Bin Location",
                //                 style: TextStyle(
                //                     color: Colors.blue, fontSize: 12.0),
                //               ),
                //               ListTile(
                //                 contentPadding: EdgeInsets.only(left: 5),
                //                 title: Text(_fromBinCodeController.text),
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
                // FlatButton(
                //   padding: EdgeInsets.only(top: 5),
                //   onPressed: () {
                //     if (data.id == 0) {
                //       Future<cflDbWarehouse.CflDbWarehouseModel> warehouse =
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute<
                //                       cflDbWarehouse.CflDbWarehouseModel>(
                //                   builder: (BuildContext context) =>
                //                       CflDbWarehousePage()));

                //       warehouse
                //           .then((cflDbWarehouse.CflDbWarehouseModel warehouse) {
                //         if (warehouse != null) {
                //           _toWhsCodeController.text = warehouse.whsCode;
                //           _toWhsNameController.text = warehouse.whsName;
                //         }
                //       });
                //     }
                //   },
                //   child: Container(
                //     padding: EdgeInsets.only(left: 5, top: 5),
                //     alignment: Alignment.centerLeft,
                //     decoration: BoxDecoration(
                //       border: Border.all(
                //           color:
                //               (data.id == 0) ? Colors.blue : Colors.grey[400]),
                //       borderRadius: BorderRadius.all(Radius.circular(10)),
                //     ),
                //     child: Row(
                //       children: <Widget>[
                //         Expanded(
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: <Widget>[
                //               Text(
                //                 "To Warehouse",
                //                 style: TextStyle(
                //                     color: Colors.blue, fontSize: 12.0),
                //               ),
                //               ListTile(
                //                 contentPadding: EdgeInsets.all(0),
                //                 title: Text(_toWhsCodeController.text),
                //                 subtitle: Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: <Widget>[
                //                     Text(_toWhsNameController.text),
                //                   ],
                //                 ),
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
                Padding(padding: EdgeInsets.only(top: 10)),
                FlatButton(
                  padding: EdgeInsets.only(top: 5),
                  onPressed: () {
                    if (data.id == 0) {
                      Future<cflWarehouse.Data> whs = Navigator.push(
                          context,
                          MaterialPageRoute<cflWarehouse.Data>(
                              builder: (BuildContext context) =>
                                  CflWarehousePage(globalBloc.branchId)));

                      whs.then((cflWarehouse.Data whs) {
                        setState(() {
                          if (whs != null) {
                           _toWhsCodeController.text = whs.whsCode;
                           _toWhsNameController.text = whs.whsName;
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
                                "To Warehouse",
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 12.0),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.only(left: 5),
                                title: Text(_toWhsCodeController.text),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(_toWhsNameController.text),
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
                FlatButton(
                  padding: EdgeInsets.only(top: 5),
                  onPressed: () {
                    if (data.id == 0) {
                      Future<cflBinLocation.Data> bin = Navigator.push(
                          context,
                          MaterialPageRoute<cflBinLocation.Data>(
                              builder: (BuildContext context) =>
                                  CflBinLocationPage(
                                      _toWhsCodeController.text)));

                      bin.then((cflBinLocation.Data bin) {
                        if (bin != null) {
                          _toAbsEntryController.text = bin.absEntry.toString();
                          _toBinCodeController.text = bin.binCode;
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
                    Text("List of Items",
                        style: new TextStyle(fontWeight: FontWeight.bold)),
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
              // Text(data[index].itemCode),
              // Text("Qty : ${NumberFormat("#,###.00").format(data[index].qty)}"),
              // Text(data[index].batchNo ?? ''),
              Text("Item Code : ${data[index].itemCode}", ),
              Text("Batch No. : ${data[index].batchNo}"),
              Text(
                  "Quantity : ${NumberFormat("#,###.##").format(data[index].qty)}" +
                      " ${data[index].uom}"),
              // Text(data[index].whsCode ?? ''),
              //Text("Warehouse : ${data[index].whsName}"),
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
                  TransferProductionDetailEventItemRemove(itemIndex: index));
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
