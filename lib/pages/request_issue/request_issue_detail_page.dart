import 'dart:convert';

import 'package:admart_app/blocs/request_issue/detail/request_issue_detail_bloc.dart';
import 'package:admart_app/blocs/request_issue/detail/request_issue_detail_event.dart';
import 'package:admart_app/blocs/request_issue/detail/request_issue_detail_state.dart';
import 'package:admart_app/pages/cfl/cfl_goods_issue_page.dart';

import 'package:admart_app/pages/cfl/cfl_transfer_request_page.dart';
import 'package:admart_app/pages/request_issue/request_issue_detail_item_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:admart_app/bloc_widgets/bloc_state_builder.dart';
import 'package:admart_app/blocs/global_bloc.dart';
import 'package:admart_app/models/request_issue_detail_response.dart';
import 'package:admart_app/widgets/validate_dialog_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:uuid/uuid.dart';
import 'package:admart_app/models/cfl_goods_issue_response.dart'
    as cflGoodsIssue;
import 'package:admart_app/models/cfl_transfer_request_response.dart'
    as cflTransferRequest;
import 'package:admart_app/pages/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:admart_app/widgets/set_colors.dart';

class RequestIssueDetailPage extends StatefulWidget {
  RequestIssueDetailPage(this._id);
  final int _id;
  @override
  _RequestIssueDetailPageState createState() =>
      _RequestIssueDetailPageState(_id);
}

class _RequestIssueDetailPageState extends State<RequestIssueDetailPage> {
  _RequestIssueDetailPageState(this._id);

  RequestIssueDetailBloc bloc = RequestIssueDetailBloc();
  final int _id;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController;
  final _idTxController = TextEditingController();
  final _sapRequestIssueNoController = TextEditingController();
  final _requestIdController = TextEditingController();
  final _requestNoController = TextEditingController();
  final _seriesNameController = TextEditingController();
  final _seriesNameReqNoController = TextEditingController();
  final _transNoController = TextEditingController();
  final _docNumController = TextEditingController();
  final _transDateController = TextEditingController();
  final _customerCodeController = TextEditingController();
  final _customerNameController = TextEditingController();
  final _branchIdController = TextEditingController();
  final _branchNameController = TextEditingController();

  DateTime transDate; // = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (_id != 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bloc.emitEvent(RequestIssueDetailEventGetId(
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
    _sapRequestIssueNoController?.dispose();
    _requestIdController?.dispose();
    _requestNoController?.dispose();
    _seriesNameController?.dispose();
    _seriesNameReqNoController?.dispose();
    _transNoController?.dispose();
    _docNumController?.dispose();
    _transDateController?.dispose();
    _customerCodeController?.dispose();
    _customerNameController?.dispose();
    _branchIdController?.dispose();
    _branchNameController?.dispose();

    bloc?.dispose();

    super.dispose();
  }

  void _create() {
    var state = (bloc.lastState ?? bloc.initialState);
    var data = Data(); // (bloc.lastState ?? bloc.initialState).data;
    data.seriesName = _seriesNameController.text;
    data.transDate = transDate;
    data.requestNo = _requestNoController.text;
    data.items = state.data.items;

    if ([null].contains(data.transDate)) {
      ValidateDialogWidget(
          context: context, message: "Issue Date harus di isi");
      return;
    } else if (["", null].contains(data.requestNo)) {
      ValidateDialogWidget(
          context: context, message: "Transfer Request No harus di isi");
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
    data.requestId = int.parse(_requestIdController.text);
    data.seriesName = _seriesNameController.text;
    data.seriesNameReqNo = _seriesNameReqNoController.text;
    
    bloc.emitEvent(RequestIssueDetailEventAdd(
      data: data,
    ));
  }

  void _submit() {
    var state = (bloc.lastState ?? bloc.initialState);
    var data = Data(); // (bloc.lastState ?? bloc.initialState).data;
    data.id = int.parse(_idTxController.text);
    data.requestId = int.parse(_requestIdController.text);
    data.requestNo = _requestNoController.text;
    data.seriesName = _seriesNameController.text;
    data.transDate = transDate;
    data.items = state.data.items;

    if ([null].contains(data.transDate)) {
      ValidateDialogWidget(
          context: context, message: "Issue Date harus di isi");
      return;
    }else if (["", null].contains(data.requestNo)) {
      ValidateDialogWidget(
          context: context, message: "Transfer Request No harus di isi");
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

    bloc.emitEvent(RequestIssueDetailEventPost(
      data: data,
    ));
  }

  void _newTrans() {
    MaterialPageRoute newRoute = MaterialPageRoute(
        builder: (BuildContext context) => RequestIssueDetailPage(0));
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
                    bloc.emitEvent(RequestIssueDetailEventNormal());
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
                    bloc.emitEvent(RequestIssueDetailEventNormal());
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
          FlatButton.icon(
            icon: Icon(
              Icons.save,
              color: Colors.yellowAccent,
            ),
            onPressed: () {
              _create();
            },
            textColor: Colors.white,
            label: Text("Save"),
          )
        ],
      );
    } else if (_getState().data.sapRequestIssueId == 0 &&
        _getState().data.id > 0) {
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
        title: Text("Request From Issue"),
        backgroundColor: bgBlue,
        bottom: PreferredSize(
            child: Container(
              color: bgOrange,
              height: 5.0,
            ),
            preferredSize: Size.fromHeight(5.0)),
        actions: <Widget>[
          (globalBloc.loginResponse.data.requestIssue_Auth_Add == 'Y')
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

  RequestIssueDetailState _getState() {
    return bloc.lastState ?? bloc.initialState;
  }

  BuildContext _context;

  Future _scanQR() async {
    if (["", null].contains(_requestNoController.text)) {
      ValidateDialogWidget(
          context: context, message: "Request No harus di isi");
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

      bloc.emitEvent(RequestIssueDetailEventScan(
          requestId: int.parse(_requestIdController.text),
          requestNo: _requestNoController.text,
          qrResult: qrResult,
          data: data));

      // bloc
      //     .eventHandler(
      //         RequestIssueDetailEventScan(
      //             issueId: int.parse(_requestIdController.text),
      //             qrResult: qrResult,
      //             data: data),
      //         _getState())
      //     .listen((onData) {
      //   if (onData.newItem != null) {
      //     Future<Item> item = Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (BuildContext context) =>
      //             RequestIssueDetailItemDetailPage(onData.newItem),
      //       ),
      //     );

      //     item.then((Item item) {
      //       if (item != null) {
      //         bloc.emitEvent(RequestIssueDetailEventItemAdd(
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
        bloc.emitEvent(RequestIssueDetailEventNormal());
        Future<Item> item = Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                RequestIssueDetailItemDetailPage(newItem),
          ),
        );

        item.then((Item item) {
          if (item != null) {
            bloc.emitEvent(RequestIssueDetailEventItemAdd(
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

    return BlocEventStateBuilder<RequestIssueDetailState>(
        bloc: bloc,
        builder: (BuildContext context, RequestIssueDetailState state) {
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
              floatingActionButton: _getState().data.sapRequestIssueId == 0
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
            RequestIssueDetailItemDetailPage(items[itemIndex]),
      ),
    );

    item.then((Item item) {
      if (item != null) {
        bloc.emitEvent(RequestIssueDetailEventItemUpdate(
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
      _seriesNameController.text = data.seriesName;
      _sapRequestIssueNoController.text = data.sapRequestIssueNo;
      _requestIdController.text = data.requestId.toString();
      _requestNoController.text = data.requestNo;
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
                    controller: _sapRequestIssueNoController,
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: "Request No.",
                        labelText: "Request No.",
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
                                hintText: "Request Date",
                                labelText: "Request Date",
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
                      Future<cflTransferRequest.Data> trq = Navigator.push(
                          context,
                          MaterialPageRoute<cflTransferRequest.Data>(
                              builder: (BuildContext context) =>
                                  CflTransferRequestPage("RequestIssue")));

                      trq.then((cflTransferRequest.Data trq) {
                        if (trq != null) {
                          _requestIdController.text = trq.id.toString();
                          _requestNoController.text = trq.transNo;
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
                ),
                // FlatButton(
                //   padding: EdgeInsets.only(top: 5),
                //   onPressed: () {
                //     if (data.id == 0) {
                //       Future<cflGoodsIssue.Data> gi = Navigator.push(
                //           context,
                //           MaterialPageRoute<cflGoodsIssue.Data>(
                //               builder: (BuildContext context) =>
                //                   CflGoodsIssuePage()));

                //       gi.then((cflGoodsIssue.Data gi) {
                //         if (gi != null) {
                //           _requestIdController.text = gi.id.toString();
                //           _requestNoController.text = gi.transNo;
                //           _seriesNameController.text = gi.seriesName;
                //           _docNumController.text = gi.docNum;
                //          }
                //       });
                //     }
                //   },
                //   child: Container(
                //     padding: EdgeInsets.only(left: 5, top: 5),
                //     alignment: Alignment.centerLeft,
                //     decoration: BoxDecoration(
                //       border: Border.all(
                //         color: (data.id == 0) ? Colors.blue : Colors.grey[400]
                //       ),
                //       borderRadius: BorderRadius.all(
                //           Radius.circular(10)
                //       )
                //     ),
                //     child: Row(
                //       children: <Widget>[
                //         Expanded(
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: <Widget>[
                //               Text(
                //                 "Issue No.",
                //                 style: TextStyle(color: Colors.blue, fontSize: 12.0),
                //               ),
                //               ListTile(
                //                 contentPadding: EdgeInsets.only(left: 5),
                //                 title: Text(_docNumController.text),
                //                 // subtitle: Column(
                //                 //   crossAxisAlignment: CrossAxisAlignment.start,
                //                 //   children: <Widget>[
                //                 //     Text(_requestNoController.text),
                //                 //   ],
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
                  "Quantity : ${NumberFormat("#,###.00").format(data[index].qty)}"),
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
        if (_getState().data.sapRequestIssueId == 0) {
          return Dismissible(
            key: Key(data[index].hashCode.toString()),
            onDismissed: (direction) {
              bloc.emitEvent(
                  RequestIssueDetailEventItemRemove(itemIndex: index));
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
