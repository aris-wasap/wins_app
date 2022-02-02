import 'package:wins_app/widgets/set_colors.dart';
import 'package:wins_app/widgets/validate_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wins_app/bloc_widgets/bloc_state_builder.dart';
import 'package:wins_app/blocs/inventory_transfer/detail_item_detail/inventory_transfer_detail_item_detail_bloc.dart';
import 'package:wins_app/blocs/inventory_transfer/detail_item_detail/inventory_transfer_detail_item_detail_event.dart';
import 'package:wins_app/blocs/inventory_transfer/detail_item_detail/inventory_transfer_detail_item_detail_state.dart';
import 'package:wins_app/models/inventory_transfer_detail_response.dart';
import 'package:wins_app/widgets/label_field_widget.dart';
import 'package:intl/intl.dart';

import 'dart:math' as math;

class InventoryTransferDetailItemDetailPage extends StatefulWidget {
  InventoryTransferDetailItemDetailPage(this._data);
  final Item _data;
  @override
  _InventoryTransferDetailItemDetailPageState createState() =>
      _InventoryTransferDetailItemDetailPageState(_data);
}

class _InventoryTransferDetailItemDetailPageState
    extends State<InventoryTransferDetailItemDetailPage> {
  _InventoryTransferDetailItemDetailPageState(this._data);

  final Item _data;
  InventoryTransferDetailItemDetailBloc bloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _itemCodeController = TextEditingController();
  final _itemNameController = TextEditingController();
  final _uomController = TextEditingController();
  final _availableQtyController = TextEditingController();
  final _qtyController = TextEditingController();
  final _batchNumberController = TextEditingController();
  final _lengthController = TextEditingController();
  final _widthController = TextEditingController();
  final _itemTypeController = TextEditingController();
  FocusNode _focusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode = FocusNode();
    bloc = InventoryTransferDetailItemDetailBloc(this._data);
  }

  @override
  void dispose() {
    //super.dispose();
    _qtyController?.dispose();
    _itemCodeController?.dispose();
    _itemNameController?.dispose();
    _uomController?.dispose();
    _availableQtyController?.dispose();
    _focusNode?.dispose();
    bloc?.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  void _done() {
    if (_qtyController.text == "0" || _qtyController.text == "") {
      ValidateDialogWidget(
          context: context, message: "Qty harus lebih besar dari 0");
      return;
    }
    bloc.emitEvent(InventoryTransferDetailItemDetailEventQty(
      qty: double.parse(_qtyController.text.replaceAll(new RegExp(','), '')),
    ));
    Navigator.pop(context, _getState().data);
  }

  InventoryTransferDetailItemDetailState _getState() {
    return bloc.lastState ?? bloc.initialState;
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

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<InventoryTransferDetailItemDetailState>(
        bloc: bloc,
        builder: (BuildContext context,
            InventoryTransferDetailItemDetailState state) {
          return SafeArea(
              child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text("Item Detail"),
              //automaticallyImplyLeading: false,
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
                          //_done();
                          showAlertDialogUpdate(context);
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

    _itemCodeController.text = data.itemCode;
    _itemNameController.text = data.itemName;
    _uomController.text = data.uom;
    _batchNumberController.text = data.batchNo;
    _lengthController.text = data.length.toString();
    _widthController.text = data.width.toString();
    _itemTypeController.text = data.itemType;
    _availableQtyController.text = data.availableQty.toString();
    if (_data.qty != 0) {
      if (_qtyController.text == "") {
        _qtyController.text = NumberFormat("###,###.####")
            .format(double.parse(data.qty.toString()));
      } else {
        if (_data.qty ==
            double.parse(_qtyController.text.replaceAll(new RegExp(','), ''))) {
          _qtyController.text = NumberFormat("###,###.####")
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
            double.parse(
                _availableQtyController.text.replaceAll(new RegExp(','), ''))) {
          _availableQtyController.text = NumberFormat("###,###.####")
              .format(double.parse(data.availableQty.toString()));
        }
      }
    }

    if (_data.length != 0) {
      if (_lengthController.text == "") {
        _lengthController.text = NumberFormat("###,###.####")
            .format(double.parse(data.length.toString()));
      } else {
        if (_data.length ==
            double.parse(
                _lengthController.text.replaceAll(new RegExp(','), ''))) {
          _lengthController.text = NumberFormat("###,###.####")
              .format(double.parse(data.length.toString()));
        }
      }
    }

    if (_data.width != 0) {
      if (_widthController.text == "") {
        _widthController.text = NumberFormat("###,###.####")
            .format(double.parse(data.width.toString()));
      } else {
        if (_data.width ==
            double.parse(
                _widthController.text.replaceAll(new RegExp(','), ''))) {
          _widthController.text = NumberFormat("###,###.####")
              .format(double.parse(data.width.toString()));
        }
      }
    }

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: bgGradientPageWhite,
            ),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                                "Batch Number",
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 12.0),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.only(left: 5),
                                title: Text(_batchNumberController.text),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(_itemNameController.text),
                                    _itemTypeController.text == 'L'
                                        ? Text(_widthController.text +
                                            " X " +
                                            _lengthController.text)
                                        : Text(""),
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
                // TextFormField(
                //   controller: _itemCodeController,
                //   enabled: false,
                //   decoration: InputDecoration(
                //       labelText: "Item Code",
                //       contentPadding: new EdgeInsets.symmetric(
                //           vertical: 15.0, horizontal: 10.0),
                //       border: new OutlineInputBorder(
                //           borderRadius: new BorderRadius.circular(10.0))),
                // ),
                // Padding(padding: EdgeInsets.only(top: 10)),
                // TextFormField(
                //   controller: _itemNameController,
                //   enabled: false,
                //   decoration: InputDecoration(
                //       labelText: "Item Name",
                //       contentPadding: new EdgeInsets.symmetric(
                //           vertical: 15.0, horizontal: 10.0),
                //       border: new OutlineInputBorder(
                //           borderRadius: new BorderRadius.circular(10.0))),
                // ),
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
                _data.id == 0
                    ? TextField(
                        autofocus: false,
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
                          DecimalTextInputFormatter(decimalRange: 2),
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
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: new BorderRadius.circular(10.0)),
                        ))
                    : TextField(
                        controller: _qtyController,
                        enabled: false,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                            labelText: "Qty",
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
