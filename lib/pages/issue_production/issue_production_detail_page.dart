import 'dart:convert';

import 'package:shimmer/shimmer.dart';
import 'package:wins_app/pages/cfl/cfl_production_order_page.dart';
import 'package:wins_app/pages/issue_production/issue_production_detail_item_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:wins_app/bloc_widgets/bloc_state_builder.dart';
import 'package:wins_app/blocs/issue_production/detail/issue_production_detail_bloc.dart';
import 'package:wins_app/blocs/issue_production/detail/issue_production_detail_event.dart';
import 'package:wins_app/blocs/issue_production/detail/issue_production_detail_state.dart';
import 'package:wins_app/blocs/global_bloc.dart';
import 'package:wins_app/models/issue_production_detail_response.dart';
import 'package:wins_app/widgets/set_colors.dart';
import 'package:wins_app/widgets/validate_dialog_widget.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:uuid/uuid.dart';
import 'package:wins_app/models/cfl_production_order_response.dart'
    as cflProductionOrder;
import 'package:wins_app/pages/barcode_scan.dart';
import 'package:flutter/services.dart';

class IssueProductionDetailPage extends StatefulWidget {
  IssueProductionDetailPage(this._id);
  final int _id;
  @override
  _IssueProductionDetailPageState createState() =>
      _IssueProductionDetailPageState(_id);
}

class _IssueProductionDetailPageState extends State<IssueProductionDetailPage> {
  _IssueProductionDetailPageState(this._id);

  IssueProductionDetailBloc bloc = IssueProductionDetailBloc();
  final int _id;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController;

  final _woIdController = TextEditingController();
  final _woNoController = TextEditingController();
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
        bloc.emitEvent(IssueProductionDetailEventGetId(
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
    data.transDate = transDate;
    data.seriesName = _seriesNameController.text;
    data.seriesNamePo = _seriesNamePoController.text;
    data.items = state.data.items;

    if ([null].contains(data.transDate)) {
      ValidateDialogWidget(context: context, message: "WO Date harus di isi");
      return;
    } else if (["", null].contains(data.woNo)) {
      ValidateDialogWidget(context: context, message: "WO No harus di isi");
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

    bloc.emitEvent(IssueProductionDetailEventAdd(
      data: data,
    ));
  }

  void _newTrans() {
    MaterialPageRoute newRoute = MaterialPageRoute(
        builder: (BuildContext context) => IssueProductionDetailPage(0));
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
                    bloc.emitEvent(IssueProductionDetailEventNormal());
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
                    bloc.emitEvent(IssueProductionDetailEventNormal());
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
        title: Text("Create Issue"),
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
    } else if (!_getState().isBusy) {
      return AppBar(
        title: Text("Issue From Production"),
        backgroundColor: bgBlue,
        bottom: PreferredSize(
            child: Container(
              color: bgOrange,
              height: 5.0,
            ),
            preferredSize: Size.fromHeight(5.0)),
        actions: <Widget>[
          (globalBloc.loginResponse.data.issueProduction_Auth_Add == 'Y')
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

  IssueProductionDetailState _getState() {
    return bloc.lastState ?? bloc.initialState;
  }

  BuildContext _context;

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

      bloc.emitEvent(IssueProductionDetailEventScan(
          woId: int.parse(_woIdController.text),
          woNo: _woNoController.text,
          qrResult: qrResult,
          data: data));

      // bloc
      //     .eventHandler(
      //         IssueProductionDetailEventScan(
      //             woId: int.parse(_woIdController.text),
      //             qrResult: qrResult,
      //             data: data),
      //         _getState())
      //     .listen((onData) {
      //   if (onData.newItem != null) {
      //     Future<Item> item = Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (BuildContext context) =>
      //             IssueProductionDetailItemDetailPage(onData.newItem),
      //       ),
      //     );

      //     item.then((Item item) {
      //       if (item != null) {
      //         bloc.emitEvent(IssueProductionDetailEventItemAdd(
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
        bloc.emitEvent(IssueProductionDetailEventNormal());
        Future<Item> item = Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                IssueProductionDetailItemDetailPage(newItem),
          ),
        );

        item.then((Item item) {
          if (item != null) {
            bloc.emitEvent(IssueProductionDetailEventItemAdd(
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

    return BlocEventStateBuilder<IssueProductionDetailState>(
        bloc: bloc,
        builder: (BuildContext context, IssueProductionDetailState state) {
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
            IssueProductionDetailItemDetailPage(items[itemIndex]),
      ),
    );

    item.then((Item item) {
      if (item != null) {
        bloc.emitEvent(IssueProductionDetailEventItemUpdate(
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
      transDate = data.transDate;
      if (transDate != null) {
        _transDateController.text = DateFormat("dd-MM-yyyy").format(transDate);
      } else {
        _transDateController.text = null;
      }
      _seriesNamePoController.text = data.seriesNamePo;
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
                    style: TextStyle(fontSize: 16, color: Colors.red),
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: "Issue Prodcution No.",
                        labelText: "Issue Prodcution No.",
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0)))),
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
                                hintText: "Issue Date",
                                labelText: "Issue Date",
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
                      Future<cflProductionOrder.Data> wo = Navigator.push(
                          context,
                          MaterialPageRoute<cflProductionOrder.Data>(
                              builder: (BuildContext context) =>
                                  CflProductionOrderPage()));

                      wo.then((cflProductionOrder.Data wo) {
                        if (wo != null) {
                          _woIdController.text = wo.id.toString();
                          _woNoController.text = wo.transNo;
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
                                // subtitle: Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: <Widget>[
                                //     Text(_issueNoController.text),
                                //   ],
                                // ),
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
        if (_getState().data.id == 0 && !_getState().isBusy) {
          return Dismissible(
            key: Key(data[index].hashCode.toString()),
            onDismissed: (direction) {
              bloc.emitEvent(
                  IssueProductionDetailEventItemRemove(itemIndex: index));
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
