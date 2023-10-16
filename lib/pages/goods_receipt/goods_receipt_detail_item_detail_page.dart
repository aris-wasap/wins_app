import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wins_app/bloc_widgets/bloc_state_builder.dart';
import 'package:wins_app/blocs/goods_receipt/detail_item_detail/goods_receipt_detail_item_detail_bloc.dart';
import 'package:wins_app/blocs/goods_receipt/detail_item_detail/goods_receipt_detail_item_detail_event.dart';
import 'package:wins_app/blocs/goods_receipt/detail_item_detail/goods_receipt_detail_item_detail_state.dart';
import 'package:wins_app/models/goods_receipt_detail_response.dart';
import 'package:wins_app/pages/barcode_scan.dart';
import 'package:wins_app/pages/cfl/cfl_binlocation_page.dart';
import 'package:wins_app/widgets/label_field_widget.dart';
import 'package:intl/intl.dart';
import 'package:wins_app/widgets/set_colors.dart';
import 'package:wins_app/widgets/validate_dialog_widget.dart';
import 'package:wins_app/models/cfl_binlocation_response.dart'
    as cflBinLocation;

import 'dart:math' as math;

class GoodsReceiptDetailItemDetailPage extends StatefulWidget {
  GoodsReceiptDetailItemDetailPage(this._data, this._index, this._newData);
  final int _index;
  final Item _data;
  final Data _newData;
  @override
  _GoodsReceiptDetailItemDetailPageState createState() =>
      _GoodsReceiptDetailItemDetailPageState(_data, _index, _newData);
}

class _GoodsReceiptDetailItemDetailPageState
    extends State<GoodsReceiptDetailItemDetailPage> {
  _GoodsReceiptDetailItemDetailPageState(
      this._data, this._index, this._newData);

  final int _index;
  final Item _data;
  final Data _newData;
  GoodsReceiptDetailItemDetailBloc bloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _idController = TextEditingController();
  final _detIdController = TextEditingController();
  final _woIdController = TextEditingController();
  final _woLineNoController = TextEditingController();
  final _itemCodeController = TextEditingController();
  final _itemNameController = TextEditingController();
  final _uomController = TextEditingController();
  final _whsCodeController = TextEditingController();
  final _whsNameController = TextEditingController();
  final _binAbsController = TextEditingController();
  final _binCodeController = TextEditingController();
  final _qtyWoController = TextEditingController();
  final _qtyController = TextEditingController();
  FocusNode _focusNode;
  ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode = FocusNode();
    bloc = GoodsReceiptDetailItemDetailBloc(this._data);
  }

  @override
  void dispose() {
    _idController?.dispose();
    _detIdController?.dispose();
    _woIdController?.dispose();
    _woLineNoController?.dispose();
    _itemCodeController?.dispose();
    _itemNameController?.dispose();
    _uomController?.dispose();
    _qtyController?.dispose();
    _whsCodeController?.dispose();
    _whsNameController?.dispose();
    _binAbsController?.dispose();
    _binCodeController?.dispose();
    _focusNode?.dispose();

    bloc?.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  void _done() {
    // if (_qtyController.text == "0" || _qtyController.text == "") {
    //   ValidateDialogWidget(
    //       context: context, message: "Qty harus lebih besar dari 0");
    //   return;
    // }
    bloc.emitEvent(GoodsReceiptDetailItemDetailEventQty(
      qty: double.parse(_qtyController.text.replaceAll(new RegExp(','), '')),
      binAbs: int.parse(_binAbsController.text),
      binCode: _binCodeController.text,
    ));
    Navigator.pop(context, _getState().data);
  }

  Future _scanQR() async {
    if (["", null].contains(_itemCodeController.text)) {
      ValidateDialogWidget(
          context: context, message: "Item Code No harus di isi");
      return;
    }
    var data = _getState().data;

    try {
      String qrResult = await BarcodeScanner.scan();

      for (var itemBatchs in _getState().data.batchs) {
        if (("${itemBatchs.batchNo}" == qrResult)) {
          ValidateDialogWidget(
              context: context, message: 'Batch Number sudah pernah di scan');
          return;
        }
      }

      bloc.emitEvent(
        GoodsReceiptDetailItemDetailEventScan(
          id: _data.id,
          detId: _data.detId,
          webId: _newData.webId,
          sapGoodsIssueId: _newData.sapGoodsIssueId,
          woId: _newData.woId,
          woLineNo: 0,
          qrResult: qrResult,
          data: data,
        ),
      );

      //_newData.items[_index] = _data;

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

  showAlertDialogUpdate(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        Navigator.of(context).pop();
        _done();
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
      content: Text("Apakah anda yakin simpan Batch Number?"),
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

  GoodsReceiptDetailItemDetailState _getState() {
    return bloc.lastState ?? bloc.initialState;
  }

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<GoodsReceiptDetailItemDetailState>(
        bloc: bloc,
        builder:
            (BuildContext context, GoodsReceiptDetailItemDetailState state) {
          return WillPopScope(
            onWillPop: () async {
              if (_newData.sapGoodsReceiptId == 0) {
                if (await confirm(context)) {
                  // items.id = _newData.id;
                  // Navigator.pop(context, items);
                  _done();
                  // _refreshDetail();
                } else {
                  return;
                }
              } else {
                Navigator.pop(context);
              }
            },
            child: SafeArea(
              child: Scaffold(
                key: _scaffoldKey,
                appBar: AppBar(
                  title: Text("Item Detail"),
                  backgroundColor: bgBlue,
                  bottom: PreferredSize(
                      child: state.isBusy
                          ? Shimmer.fromColors(
                              baseColor: bgWhite,
                              highlightColor: bgOrange,
                              child: Container(
                                color: bgOrange,
                                height: 5.0,
                              ),
                            )
                          : Container(
                              color: bgOrange,
                              height: 5.0,
                            ),
                      preferredSize: Size.fromHeight(5.0)),
                  actions: <Widget>[
                    _data.id == 0
                        ? FlatButton(
                            onPressed: () {
                              //_done();
                              showAlertDialogUpdate(context);
                            },
                            textColor: Colors.white,
                            child: Row(
                              children: <Widget>[Text("DONE")],
                            ),
                          )
                        : Container(),
                  ],
                ),
                body: SingleChildScrollView(
                  child: _buildForm(),
                ),
                floatingActionButton: _newData.sapGoodsReceiptId == 0
                    ? FloatingActionButton.extended(
                        icon: Icon(Icons.camera_alt),
                        backgroundColor: btnBgOrange,
                        label: Text("Scan"),
                        onPressed: () {
                          //_refreshDetailItem();
                          _scanQR();
                        },
                      )
                    : null,
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
              ),
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
                    bloc.emitEvent(GoodsReceiptDetailItemEventNormal());
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

  Widget _buildForm() {
    _errorMessage();
    var data = _getState().data;

    _itemCodeController.text = data.itemCode;
    _itemNameController.text = data.itemName;
    _uomController.text = data.uom;
    _whsCodeController.text = data.whsCode;
    _whsNameController.text = data.whsName;
    _binAbsController.text = data.binAbs.toString();
    _binCodeController.text = data.binCode;
    _qtyWoController.text = data.woQty.toString();
    // _qtyController.text = data.qty.toString();
    _qtyController.text =
        NumberFormat("###,###.####").format(double.parse(data.qty.toString()));

    if (_data.qty != 0) {
      if (_qtyController.text == "") {
        _qtyController.text = NumberFormat("###,###.##")
            .format(double.parse(data.qty.toString()));
      } else {
        if (_data.qty ==
            double.parse(_qtyController.text.replaceAll(new RegExp(','), ''))) {
          _qtyController.text = NumberFormat("###,###.##")
              .format(double.parse(data.qty.toString()));
        }
      }
    }

    if (_data.woQty != 0) {
      if (_qtyWoController.text == "") {
        _qtyWoController.text = NumberFormat("###,###.##")
            .format(double.parse(data.woQty.toString()));
      } else {
        if (_data.woQty ==
            double.parse(
                _qtyWoController.text.replaceAll(new RegExp(','), ''))) {
          _qtyWoController.text = NumberFormat("###,###.##")
              .format(double.parse(data.woQty.toString()));
        }
      }
    }

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            // height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: bgGradientPageWhite,
            ),
            padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _itemCodeController,
                  enabled: false,
                  decoration: InputDecoration(
                      labelText: "Item Code",
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                TextFormField(
                  controller: _itemNameController,
                  enabled: false,
                  decoration: InputDecoration(
                      labelText: "Item Name",
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                TextFormField(
                  controller: _whsCodeController,
                  enabled: false,
                  decoration: InputDecoration(
                      labelText: "To Warehouse Code",
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                TextFormField(
                  controller: _whsNameController,
                  enabled: false,
                  decoration: InputDecoration(
                      labelText: "To Warehouse Name",
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                FlatButton(
                  padding: EdgeInsets.only(top: 5),
                  onPressed: () {
                    if (data.id == 0) {
                      setState(() {
                        Future<cflBinLocation.Data> bin = Navigator.push(
                            context,
                            MaterialPageRoute<cflBinLocation.Data>(
                                builder: (BuildContext context) =>
                                    CflBinLocationPage(
                                        _whsCodeController.text)));

                        bin.then((cflBinLocation.Data bin) {
                          if (bin != null) {
                            // _binAbsController.text = bin.absEntry.toString();
                            // _binCodeController.text =  bin.binCode;
                            _getState().data.binAbs = bin.absEntry;
                            _getState().data.binCode = bin.binCode;
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
                                "To Bin Location",
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 12.0),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.only(left: 5),
                                title: Text(_binCodeController.text),
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
                Padding(padding: EdgeInsets.only(top: 10)),
                TextField(
                  controller: _qtyWoController,
                  enabled: false,
                  decoration: InputDecoration(
                      labelText: "Planned Qty",
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                _newData.sapGoodsReceiptId == 0
                    ? TextField(
                        autofocus: false,
                        enabled: false,
                        textInputAction: TextInputAction.done,
                        focusNode: _focusNode,
                        controller: _qtyController,
                        onEditingComplete: () {
                          setState(() {
                            String newValue = NumberFormat("###,###.####")
                                .format(double.parse(_qtyController.text
                                    .replaceAll(new RegExp(','), '')
                                    .replaceAll(new RegExp('-'), '')
                                    .replaceAll(new RegExp(' '), '')));
                            _qtyController.text = newValue;
                            _qtyController.selection = TextSelection.collapsed(
                                offset: newValue.length);
                          });
                          _focusNode.unfocus();
                        },
                        inputFormatters: [
                          DecimalTextInputFormatter(decimalRange: 4)
                        ],
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          labelText: "Receipt Qty",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: new BorderRadius.circular(10.0)),
                        ))
                    : TextField(
                        controller: _qtyController,
                        enabled: false,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                            labelText: "Receipt Qty",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0))),
                      ),
                Padding(padding: EdgeInsets.only(top: 15)),
                TextFormField(
                  controller: _uomController,
                  enabled: false,
                  decoration: InputDecoration(
                      labelText: "UoM",
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                ),

                // LabelFieldWidget(
                //   labelText: "Item Code",
                //   valueText: "${data.itemCode}",
                // ),
                // LabelFieldWidget(
                //   labelText: "Item Name",
                //   valueText: "${data.itemName}",
                // ),
                // LabelFieldWidget(
                //   labelText: "Open PO Qty",
                //   valueText: "${NumberFormat("#,###.00").format(data.soQty)}",
                // ),
                // _data.id == 0
                //     ? TextField(
                //         controller: _qtyController,
                //         keyboardType: TextInputType.number,
                //         // onChanged: (text) {},
                //         decoration: InputDecoration(
                //           labelText: "Receipt Qty",
                //           contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                //           enabledBorder: UnderlineInputBorder(
                //               borderSide: BorderSide(color: Colors.blue)),
                //         ))
                //     : LabelFieldWidget(
                //         labelText: "Receipt Qty",
                //         valueText:
                //             "${NumberFormat("#,###.00").format(data.qty)}",
                //       ),
                // LabelFieldWidget(
                //   labelText: "UoM",
                //   valueText: "${data.uom}",
                // ),
              ],
            ),
          ),
          _showCircularProgress(),
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
              child: (data.batchs.length > 0)
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

  Widget _rowDetail(int index, Item newData) {
    return newData.batchs != null
        ? Container(
            margin: new EdgeInsets.symmetric(horizontal: 0.0, vertical: 1.0),
            decoration: BoxDecoration(
                color: Colors.grey[400].withOpacity(0.5),
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.grey[500]),
                    left: BorderSide(width: 5, color: Colors.blue))),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: ListTile(
                title: Text("Batch No. : ${newData.batchs[index].batchNo}"),
                subtitle: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Text("Batch No. : ${newData.batchs[index].batchNo}"),
                    Text(
                        "Qty Batch : ${NumberFormat("#,###.##").format(newData.batchs[index].quantity)}"),
                  ],
                ),
              ),
            ),
          )
        : null;
  }

  Widget _buildList() {
    var state = bloc.lastState ?? bloc.initialState;
    final data = state.data;
    if (data != null) {
      return ListView.builder(
        controller: _scrollController,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: data.batchs.length,
        itemBuilder: (contex, index) {
          if (data.batchs[index].batchNo != null &&
              _newData.sapGoodsReceiptId == 0) {
            // return _rowDetail(index, data);
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                if (_getState().data.batchs[index].detDetId != 0) {
                  bloc.emitEvent(
                    GoodsReceiptDetailItemDetailEventRemoveContent(
                      id: _getState().data.id,
                      detId: _getState().data.detId,
                      detDetId: data.batchs[index].detDetId,
                    ),
                  );
                } else if (_getState().data.batchs[index].detDetId == 0) {
                  setState(() {
                    _getState().data.batchs.removeAt(index);
                  });
                  return null;
                }
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
              child: _rowDetail(index, data),
            );
          } else {
            return _rowDetail(index, data);
          }
        },
      );
    }
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({this.decimalRange})
      : assert(decimalRange == null || decimalRange > 0);

  final int decimalRange;
  final money = NumberFormat("###,###,###", "en_US");

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}
