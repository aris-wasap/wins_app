import 'package:wins_app/pages/cfl/cfl_batch_location_page.dart';
import 'package:wins_app/pages/cfl/cfl_item_batch__page.dart';
import 'package:wins_app/widgets/set_colors.dart';
import 'package:wins_app/widgets/validate_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wins_app/bloc_widgets/bloc_state_builder.dart';
import 'package:wins_app/blocs/transfer_production/detail_item_detail/transfer_production_detail_item_detail_bloc.dart';
import 'package:wins_app/blocs/transfer_production/detail_item_detail/transfer_production_detail_item_detail_event.dart';
import 'package:wins_app/blocs/transfer_production/detail_item_detail/transfer_production_detail_item_detail_state.dart';
import 'package:wins_app/models/transfer_production_detail_response.dart';
import 'package:wins_app/widgets/label_field_widget.dart';
import 'package:intl/intl.dart';
import 'package:wins_app/models/cfl_batch_location_response.dart'
    as cflBatchLocation;
import 'package:wins_app/models/cfl_item_batch_response.dart' as cflItemBatch;

import 'dart:math' as math;

class TransferProductionDetailItemDetailPage extends StatefulWidget {
  TransferProductionDetailItemDetailPage(this._data);
  final Item _data;
  @override
  _TransferProductionDetailItemDetailPageState createState() =>
      _TransferProductionDetailItemDetailPageState(_data);
}

class _TransferProductionDetailItemDetailPageState
    extends State<TransferProductionDetailItemDetailPage> {
  _TransferProductionDetailItemDetailPageState(this._data);

  final Item _data;
  TransferProductionDetailItemDetailBloc bloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _woIdController = TextEditingController();
  final _lineNumController = TextEditingController();
  final _itemCodeController = TextEditingController();
  final _itemNameController = TextEditingController();
  final _uomController = TextEditingController();
  final _whsCodeController = TextEditingController();
  final _whsNameController = TextEditingController();
  final _binAbsController = TextEditingController();
  final _binCodeController = TextEditingController();
  final _batchNumberController = TextEditingController();
  final _availableQtyController = TextEditingController();
  final _plannedQtyController = TextEditingController();
  final _qtyController = TextEditingController();
  final _openQtyController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    bloc = TransferProductionDetailItemDetailBloc(this._data);
  }

  @override
  void dispose() {
    _qtyController?.dispose();

    bloc?.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  void _done() {
    if (_data.openQty <= 0 ) {
      ValidateDialogWidget(
          context: context, message: "Open Qty sudah terpenuhi, silahkan scan QR dengan itemcode yang berbeda");
      return;
    }
    if (_qtyController.text == "0" || _qtyController.text == "") {
      ValidateDialogWidget(
          context: context, message: "Qty harus lebih besar dari 0");
      return;
    }
    bloc.emitEvent(TransferProductionDetailItemDetailEventQty(
      qty: double.parse(_qtyController.text.replaceAll(new RegExp(','), '')),
    ));
    Navigator.pop(context, _getState().data);
  }

  TransferProductionDetailItemDetailState _getState() {
    return bloc.lastState ?? bloc.initialState;
  }

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<TransferProductionDetailItemDetailState>(
        bloc: bloc,
        builder: (BuildContext context,
            TransferProductionDetailItemDetailState state) {
          return SafeArea(
              child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text("Item Detail"),
              backgroundColor: bgBlue,
              bottom: PreferredSize(
                  child: Container(
                    color: bgOrange,
                    height: 5.0,
                  ),
                  preferredSize: Size.fromHeight(5.0)),
              actions: <Widget>[
                _data.id == 0
                    ? FlatButton.icon(
                        icon: Icon(Icons.check),
                        onPressed: () {
                          _done();
                        },
                        textColor: Colors.white,
                        label: Text("DONE"),
                      )
                    : Container(),
              ],
            ),
            body: SingleChildScrollView(
              child: _buildForm(),
            ),
          ));
        });
  }

  Widget _buildForm() {
    var data = _getState().data;

    _woIdController.text = data.woId.toString();
    _lineNumController.text = data.woLineNo.toString();
    _batchNumberController.text = data.batchNo;
    _itemCodeController.text = data.itemCode;
    _itemNameController.text = data.itemName;
    _uomController.text = data.uom;
    _whsCodeController.text = data.fromWhsCode;
    _whsNameController.text = data.fromWhsName;
    _binAbsController.text = data.fromAbsEntry.toString();
    _binCodeController.text = data.fromBinCode;
    _availableQtyController.text = data.availableQty.toString();
    _plannedQtyController.text = data.plannedQty.toString();
    _openQtyController.text = data.openQty.toString();

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

    if (_data.availableQty != 0) {
      if (_availableQtyController.text == "") {
        _availableQtyController.text = NumberFormat("###,###.####")
            .format(double.parse(data.availableQty.toString()));
      } else {
        if (_data.availableQty ==
            double.parse(_availableQtyController.text.replaceAll(new RegExp(','), ''))) {
          _availableQtyController.text = NumberFormat("###,###.####")
              .format(double.parse(data.availableQty.toString()));
        }
      }
    }

    if (_data.openQty != 0) {
      if (_openQtyController.text == "") {
        _openQtyController.text = NumberFormat("###,###.####")
            .format(double.parse(data.openQty.toString()));
      } else {
        if (_data.openQty ==
            double.parse(_openQtyController.text.replaceAll(new RegExp(','), ''))) {
          _openQtyController.text = NumberFormat("###,###.####")
              .format(double.parse(data.openQty.toString()));
        }
      }
    }

    if (_data.plannedQty != 0) {
      if (_plannedQtyController.text == "") {
        _plannedQtyController.text = NumberFormat("###,###.####")
            .format(double.parse(data.plannedQty.toString()));
      } else {
        if (_data.plannedQty ==
            double.parse(
                _plannedQtyController.text.replaceAll(new RegExp(','), ''))) {
          _plannedQtyController.text = NumberFormat("###,###.####")
              .format(double.parse(data.plannedQty.toString()));
        }
      }
    }
    

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            //height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: bgGradientPageWhite,
            ),
            padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _batchNumberController,
                  enabled: false,
                  decoration: InputDecoration(
                      labelText: "Batch Number",
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
                        Future<cflItemBatch.Data> itemBatch = Navigator.push(
                            context,
                            MaterialPageRoute<cflItemBatch.Data>(
                                builder: (BuildContext context) =>
                                    CflItemBatchPage(
                                      _whsCodeController.text,
                                      _batchNumberController.text,
                                      int.parse(_woIdController.text),
                                    )));

                        itemBatch.then((cflItemBatch.Data itemBatch) {
                          if (itemBatch != null) {
                            // _binAbsController.text = bin.absEntry.toString();
                            // _binCodeController.text =  bin.binCode;
                            _getState().data.woLineNo = itemBatch.lineNum;
                            _getState().data.itemCode = itemBatch.itemCode;
                            _getState().data.itemName = itemBatch.itemName;
                            _getState().data.fromAbsEntry = itemBatch.absEntry;
                            _getState().data.fromBinCode = itemBatch.binCode;
                            _getState().data.availableQty =
                                double.parse(itemBatch.availableQty.toString());
                            _getState().data.plannedQty =
                                double.parse(itemBatch.plannedQty.toString());
                            _getState().data.openQty =
                                double.parse(itemBatch.openQty.toString());
                            _getState().data.issueQty =
                                double.parse(itemBatch.issueQty.toString());
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
                            color: (data.id == 0) ? bgBlue : Colors.grey[400]),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Item Code",
                                style: TextStyle(color: bgBlue, fontSize: 12.0),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.only(left: 5),
                                title: Text(_itemCodeController.text),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(_itemNameController.text),
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
                Padding(padding: EdgeInsets.only(top: 10)),
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
                        //     color: (data.id == 0) ? bgBlue : Colors.grey,
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
                                "Warehouse",
                                style: TextStyle(color: bgBlue, fontSize: 12.0),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.only(left: 5),
                                title: Text(_whsCodeController.text),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(_whsNameController.text),
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
                      setState(() {
                        Future<cflBatchLocation.Data> bin = Navigator.push(
                            context,
                            MaterialPageRoute<cflBatchLocation.Data>(
                                builder: (BuildContext context) =>
                                    CflBatchLocationPage(
                                        _whsCodeController.text,
                                        _batchNumberController.text,
                                        _itemCodeController.text)));

                        bin.then((cflBatchLocation.Data bin) {
                          if (bin != null) {
                            // _binAbsController.text = bin.absEntry.toString();
                            // _binCodeController.text =  bin.binCode;
                            _getState().data.fromAbsEntry = bin.absEntry;
                            _getState().data.fromBinCode = bin.binCode;
                            _getState().data.availableQty =
                                double.parse(bin.availableQty.toString());
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
                            color: (data.id == 0) ? bgBlue : Colors.grey[400]),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "From Bin Location",
                                style: TextStyle(color: bgBlue, fontSize: 12.0),
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
                  controller: _availableQtyController,
                  enabled: false,
                  decoration: InputDecoration(
                      labelText: "Available Qty",
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                TextField(
                  controller: _plannedQtyController,
                  enabled: false,
                  decoration: InputDecoration(
                      labelText: "Planned Qty",
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                TextField(
                  controller: _openQtyController,
                  enabled: false,
                  decoration: InputDecoration(
                      labelText: "Open Qty",
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                _data.id == 0
                    ? TextField(
                        autofocus: true,
                        controller: _qtyController,
                        onEditingComplete: () {
                          setState(() {
                            String newValue = NumberFormat("###,###.##").format(
                                double.parse(_qtyController.text
                                    .replaceAll(new RegExp(','), '')
                                    .replaceAll(new RegExp('-'), '')
                                    .replaceAll(new RegExp(' '), '')));
                            _qtyController.text = newValue;
                            _qtyController.selection = TextSelection.collapsed(
                                offset: newValue.length);
                          });
                        },
                        inputFormatters: [
                          DecimalTextInputFormatter(decimalRange: 4)
                        ],
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          labelText: "Qty",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: bgBlue),
                              borderRadius: new BorderRadius.circular(10.0)),
                        ))
                    : TextField(
                        controller: _qtyController,
                        enabled: false,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                            labelText: " Qty",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0))),
                      ),
                Padding(padding: EdgeInsets.only(top: 10)),
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
              ],
            ),
          ),
        ]);
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
