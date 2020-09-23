import 'dart:convert';

import 'package:admart_app/pages/cfl/cfl_payable_return_request_page.dart';
import 'package:admart_app/pages/cfl/cfl_purchase_order_page.dart';
import 'package:admart_app/pages/payable_credit/payable_credit_detail_item_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:admart_app/bloc_widgets/bloc_state_builder.dart';
import 'package:admart_app/blocs/payable_credit/detail/payable_credit_detail_bloc.dart';
import 'package:admart_app/blocs/payable_credit/detail/payable_credit_detail_event.dart';
import 'package:admart_app/blocs/payable_credit/detail/payable_credit_detail_state.dart';
import 'package:admart_app/blocs/global_bloc.dart';
import 'package:admart_app/models/payable_credit_detail_response.dart';
import 'package:admart_app/widgets/set_colors.dart';
import 'package:admart_app/widgets/validate_dialog_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:uuid/uuid.dart';
import 'package:admart_app/models/cfl_payable_return_request_response.dart'
    as cflPayableReturnRequest;
import 'package:admart_app/pages/barcode_scan.dart';
import 'package:flutter/services.dart';

class PayableCreditDetailPage extends StatefulWidget {
  PayableCreditDetailPage(this._id);
  final int _id;
  @override
  _PayableCreditDetailPageState createState() =>
      _PayableCreditDetailPageState(_id);
}

class _PayableCreditDetailPageState extends State<PayableCreditDetailPage> {
  _PayableCreditDetailPageState(this._id);

  PayableCreditDetailBloc bloc = PayableCreditDetailBloc();
  final int _id;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController;

  final _idTxController = TextEditingController();
  final _returnRequestIdController = TextEditingController();
  final _returnRequestNoController = TextEditingController();
  final _transNoController = TextEditingController();
  final _transDateController = TextEditingController();
  final _vendorCodeController = TextEditingController();
  final _vendorNameController = TextEditingController();
  final _refNoController = TextEditingController();
  final _seriesNameReturnRequestController = TextEditingController();
  final _seriesNameController = TextEditingController();
  final _branchIdController = TextEditingController();
  final _branchNameController = TextEditingController();
  DateTime transDate; // = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (_id != 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bloc.emitEvent(PayableCreditDetailEventGetId(
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
    _returnRequestIdController?.dispose();
    _returnRequestNoController?.dispose();
    _transNoController?.dispose();
    _transDateController?.dispose();
    _vendorCodeController?.dispose();
    _vendorNameController?.dispose();
    _refNoController?.dispose();
    _seriesNameReturnRequestController?.dispose();
    _seriesNameController?.dispose();
    _branchIdController?.dispose();
    _branchNameController?.dispose();

    bloc?.dispose();

    super.dispose();
  }

  void _create() {
    var state = (bloc.lastState ?? bloc.initialState);
    var data = Data(); // (bloc.lastState ?? bloc.initialState).data;
    data.returnRequestNo = _returnRequestNoController.text;
    data.transDate = transDate;
    data.vendorCode = _vendorCodeController.text;
    data.vendorName = _vendorNameController.text;
    data.items = state.data.items;
    
    if ([null].contains(data.transDate)) {
      ValidateDialogWidget(
          context: context, message: "Return Date harus di isi");
      return;
    } else if (["", null].contains(data.returnRequestNo)) {
      ValidateDialogWidget(
          context: context, message: "Return Request No harus di isi");
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
    data.returnRequestId = int.parse(_returnRequestIdController.text);
    data.refNo = _refNoController.text;
    data.seriesName = _seriesNameController.text;
    data.seriesNameReturnRequest = _seriesNameReturnRequestController.text;
    
    bloc.emitEvent(PayableCreditDetailEventAdd(
      data: data,
    ));
  }

  void _submit() {
    var state = (bloc.lastState ?? bloc.initialState);
    var data = Data(); // (bloc.lastState ?? bloc.initialState).data;
    data.id = int.parse(_idTxController.text);
    data.returnRequestId = int.parse(_returnRequestIdController.text);
    data.returnRequestNo = _returnRequestNoController.text;
    data.transDate = transDate;
    data.vendorCode = _vendorCodeController.text;
    data.vendorName = _vendorNameController.text;
    data.refNo = _refNoController.text;
    data.seriesName = _seriesNameController.text;
    data.seriesNameReturnRequest = _seriesNameReturnRequestController.text;
    data.items = state.data.items;

    if ([null].contains(data.transDate)) {
      ValidateDialogWidget(
          context: context, message: "Return Request Date harus di isi");
      return;
    } else if (["", null].contains(data.returnRequestNo)) {
      ValidateDialogWidget(
          context: context, message: "Return Request No harus di isi");
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

    bloc.emitEvent(PayableCreditDetailEventPost(
      data: data,
    ));
  }

  void _newTrans() {
    MaterialPageRoute newRoute = MaterialPageRoute(
        builder: (BuildContext context) => PayableCreditDetailPage(0));
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
                    bloc.emitEvent(PayableCreditDetailEventNormal());
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
                    bloc.emitEvent(PayableCreditDetailEventNormal());
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
        title: Text("Draft Return"),
        backgroundColor: bgBlue,
        bottom: PreferredSize(
            child: Container(
              color: bgOrange,
              height: 5.0,
            ),
            preferredSize: Size.fromHeight(5.0)),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.save, color: Colors.yellowAccent,),
            onPressed: () {
              _create();
            },
            textColor: Colors.white,
            label: Text("Save"),
          )
        ],
      );
    } else if (_getState().data.sapReturnId == 0 && _getState().data.id > 0) {
      return AppBar(
        title: Text(
          "Create Return",
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
              _submit();
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
        title: Text("Payable Credit Memo"),
        backgroundColor: bgBlue,
        bottom: PreferredSize(
            child: Container(
              color: bgOrange,
              height: 5.0,
            ),
            preferredSize: Size.fromHeight(5.0)),
        actions: <Widget>[
          (globalBloc.loginResponse.data.payableCredit_Auth_Add == 'Y')
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

  PayableCreditDetailState _getState() {
    return bloc.lastState ?? bloc.initialState;
  }

  BuildContext _context;

  Future _scanQR() async {
    if (["", null].contains(_returnRequestNoController.text)) {
      ValidateDialogWidget(
          context: context, message: "Return Request No harus di isi");
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

      bloc.emitEvent(PayableCreditDetailEventScan(
          returnRequestId: int.parse(_returnRequestIdController.text),
          returnRequestNo: _returnRequestNoController.text,
          qrResult: qrResult,
          data: data));

      // bloc
      //     .eventHandler(
      //         PayableCreditDetailEventScan(
      //             returnRequestId: int.parse(_returnRequestIdController.text),
      //             qrResult: qrResult,
      //             data: data),
      //         _getState())
      //     .listen((onData) {
      //   if (onData.newItem != null) {
      //     Future<Item> item = Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (BuildContext context) =>
      //             PayableCreditDetailItemDetailPage(onData.newItem),
      //       ),
      //     );

      //     item.then((Item item) {
      //       if (item != null) {
      //         bloc.emitEvent(PayableCreditDetailEventItemAdd(
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
        bloc.emitEvent(PayableCreditDetailEventNormal());
        Future<Item> item = Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                PayableCreditDetailItemDetailPage(newItem),
          ),
        );

        item.then((Item item) {
          if (item != null) {
            bloc.emitEvent(PayableCreditDetailEventItemAdd(
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

    return BlocEventStateBuilder<PayableCreditDetailState>(
        bloc: bloc,
        builder: (BuildContext context, PayableCreditDetailState state) {
          return SafeArea(
            child: Scaffold(
              key: _scaffoldKey,
              appBar: _appBar(),
              body: Container(
                color: Colors.blue[100],
                // constraints: BoxConstraints.expand(),
                height: MediaQuery.of(context).size.height,
                // decoration: BoxDecoration(
                //   gradient: bgGradientPageWhite,
                // ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 3.0, left: 3.0),
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
              floatingActionButton: _getState().data.sapReturnId == 0
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
            PayableCreditDetailItemDetailPage(items[itemIndex]),
      ),
    );

    item.then((Item item) {
      if (item != null) {
        bloc.emitEvent(PayableCreditDetailEventItemUpdate(
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
      _returnRequestIdController.text = data.returnRequestId.toString();
      _returnRequestNoController.text = data.returnRequestNo;
      transDate = data.transDate;
      if (transDate != null) {
        _transDateController.text = DateFormat("dd-MM-yyyy").format(transDate);
      } else {
        _transDateController.text = null;
      }
      _vendorCodeController.text = data.vendorCode;
      _vendorNameController.text = data.vendorName;
      _seriesNameReturnRequestController.text = data.seriesNameReturnRequest;
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
                // TextFormField(
                //   controller: _seriesNameController,
                //   enabled: false,
                //   decoration: InputDecoration(
                //     hintText: "Series No.",
                //     labelText: "Series No.",
                //     contentPadding: new EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                //     border: new OutlineInputBorder(
                //       borderRadius: new BorderRadius.circular(10.0)
                //     )
                //   )
                // ),
                // Padding(
                //   padding: EdgeInsets.only(top: 5)
                // ),
                TextFormField(
                    controller: _transNoController,
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: "Return No.",
                        labelText: "Return No.",
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
                                hintText: "Return Date",
                                labelText: "Return Date",
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
                      Future<cflPayableReturnRequest.Data> req = Navigator.push(
                          context,
                          MaterialPageRoute<cflPayableReturnRequest.Data>(
                              builder: (BuildContext context) =>
                                  CflPayableReturnRequestPage()));

                      req.then((cflPayableReturnRequest.Data req) {
                        if (req != null) {
                          _returnRequestIdController.text = req.id.toString();
                          _returnRequestNoController.text =
                              req.seriesName + '-' + req.transNo;
                          _vendorCodeController.text = req.vendorCode;
                          _vendorNameController.text = req.vendorName;
                          _refNoController.text = req.refNo;
                          _branchIdController.text = req.branchId.toString();
                          _branchNameController.text = req.branchName;
                          _seriesNameReturnRequestController.text =
                              req.seriesName;
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
                                "Return Request No.",
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 12.0),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.only(left: 5),
                                title: Text(_returnRequestNoController.text),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(_branchNameController.text),
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
            height: 75,
            color: Colors.transparent,
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
        if (_getState().data.sapReturnId == 0 && _getState().data.id > 0) {
          return Dismissible(
            key: Key(data[index].hashCode.toString()),
            onDismissed: (direction) {
              bloc.emitEvent(
                  PayableCreditDetailEventItemRemove(itemIndex: index));
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
