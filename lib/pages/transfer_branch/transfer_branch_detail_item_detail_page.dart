import 'package:admart_app/blocs/global_bloc.dart';
import 'package:admart_app/pages/cfl/cfl_batch_location_page.dart';
import 'package:admart_app/pages/cfl/cfl_warehouse_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:admart_app/bloc_widgets/bloc_state_builder.dart';
import 'package:admart_app/blocs/transfer_branch/detail_item_detail/transfer_branch_detail_item_detail_bloc.dart';
import 'package:admart_app/blocs/transfer_branch/detail_item_detail/transfer_branch_detail_item_detail_event.dart';
import 'package:admart_app/blocs/transfer_branch/detail_item_detail/transfer_branch_detail_item_detail_state.dart';
import 'package:admart_app/models/transfer_branch_detail_response.dart';
import 'package:admart_app/pages/cfl/cfl_binlocation_page.dart';
import 'package:admart_app/widgets/label_field_widget.dart';
import 'package:intl/intl.dart';
import 'package:admart_app/widgets/set_colors.dart';
import 'package:admart_app/widgets/validate_dialog_widget.dart';
import 'package:admart_app/models/cfl_batch_location_response.dart'
    as cflBatchLocation;
import 'package:admart_app/models/cfl_warehouse_response.dart' as cflWarehouse;
import 'dart:math' as math;

class TransferBranchDetailItemDetailPage extends StatefulWidget {
  TransferBranchDetailItemDetailPage(this._data);
  final Item _data;
  @override
  _TransferBranchDetailItemDetailPageState createState() =>
      _TransferBranchDetailItemDetailPageState(_data);
}

class _TransferBranchDetailItemDetailPageState
    extends State<TransferBranchDetailItemDetailPage> {
  _TransferBranchDetailItemDetailPageState(this._data);

  final Item _data;
  TransferBranchDetailItemDetailBloc bloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _itemCodeController = TextEditingController();
  final _itemNameController = TextEditingController();
  final _uomController = TextEditingController();
  final _whsCodeController = TextEditingController();
  final _whsNameController = TextEditingController();
  final _binAbsController = TextEditingController();
  final _binCodeController = TextEditingController();
  final _reqQtyController = TextEditingController();
  final _qtyController = TextEditingController();
  final _availableQtyController = TextEditingController();
  final _batchNumberController = TextEditingController();
  final _lengthController = TextEditingController();
  final _length2Controller = TextEditingController();
  final _widthController = TextEditingController();
  final _itemTypeController = TextEditingController();
  FocusNode _focusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode = FocusNode();
    bloc = TransferBranchDetailItemDetailBloc(this._data);
  }

  @override
  void dispose() {
    _reqQtyController?.dispose();
    _qtyController?.dispose();
    _availableQtyController?.dispose();
    _binAbsController?.dispose();
    _binCodeController?.dispose();
    _focusNode?.dispose();
    bloc?.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  void _done() {
    if (_whsCodeController.text == "" || _whsCodeController.text == null) {
      ValidateDialogWidget(
          context: context, message: "Silahkan input Warehouse");
      return;
    } else if (_binCodeController.text == "" ||
        _binCodeController.text == null) {
      ValidateDialogWidget(
          context: context, message: "Silahkan input Bin Location");
      return;
    }
    if (_qtyController.text == "0" || _qtyController.text == "") {
      ValidateDialogWidget(
          context: context, message: "Qty harus lebih besar dari 0");
      return;
    }

    bloc.emitEvent(TransferBranchDetailItemDetailEventQty(
      qty: double.parse(_qtyController.text.replaceAll(new RegExp(','), '')),
      binAbs: int.parse(_binAbsController.text),
      binCode: _binCodeController.text,
    ));
    Navigator.pop(context, _getState().data);
  }

  TransferBranchDetailItemDetailState _getState() {
    return bloc.lastState ?? bloc.initialState;
  }

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<TransferBranchDetailItemDetailState>(
        bloc: bloc,
        builder:
            (BuildContext context, TransferBranchDetailItemDetailState state) {
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
                    ? FlatButton(
                        onPressed: () {
                          _done();
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
          ));
        });
  }

  Widget _buildForm() {
    var data = _getState().data;

    _itemCodeController.text = data.itemCode;
    _itemNameController.text = data.itemName;
    _uomController.text = data.uom;
    _whsCodeController.text = data.whsCode;
    _whsNameController.text = data.whsName;
    _binAbsController.text = data.binAbs.toString();
    _binCodeController.text = data.binCode;
    _batchNumberController.text = data.batchNo;
    _lengthController.text = data.length.toString();
    _length2Controller.text = data.length2.toString();
    _widthController.text = data.width.toString();
    _itemTypeController.text = data.itemType;
    // _reqQtyController.text =
    //     NumberFormat("###,###.##").format(double.parse(data.reqQty.toString()));
    // _availableQtyController.text =
    //     NumberFormat("###,###.##").format(double.parse(data.availableQty.toString()));

    if (_data.reqQty != 0) {
      if (_reqQtyController.text == "") {
        _reqQtyController.text = NumberFormat("###,###.####")
            .format(double.parse(data.reqQty.toString()));
      } else {
        if (_data.reqQty ==
            double.parse(
                _reqQtyController.text.replaceAll(new RegExp(','), ''))) {
          _reqQtyController.text = NumberFormat("###,###.####")
              .format(double.parse(data.reqQty.toString()));
        }
      }
    }

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

    if (_data.length2 != 0) {
      if (_length2Controller.text == "") {
        _length2Controller.text = NumberFormat("###,###.####")
            .format(double.parse(data.length2.toString()));
      } else {
        if (_data.length2 ==
            double.parse(
                _length2Controller.text.replaceAll(new RegExp(','), ''))) {
          _length2Controller.text = NumberFormat("###,###.####")
              .format(double.parse(data.length2.toString()));
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

    return Container(
      color: Colors.blue[100],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Column(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(_itemNameController.text),
                                          _itemTypeController.text == 'L'
                                              ? Text(_widthController.text +
                                                  " X " +
                                                  _length2Controller.text)
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
                      //   controller: _batchNumberController,
                      //   enabled: false,
                      //   decoration: InputDecoration(
                      //       labelText: "Batch Number",
                      //       contentPadding: new EdgeInsets.symmetric(
                      //           vertical: 15.0, horizontal: 10.0),
                      //       border: new OutlineInputBorder(
                      //           borderRadius: new BorderRadius.circular(10.0))),
                      // ),
                      // Padding(padding: EdgeInsets.only(top: 10)),
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
                      FlatButton(
                        autofocus: true,
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
                                  _getState().data.whsCode = whs.whsCode;
                                  _getState().data.whsName = whs.whsName;
                                  _getState().data.binCode = "";
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
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
                                      title: Text(_whsCodeController.text),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(_whsNameController.text),
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
                          if (data.id == 0) {
                            Future<cflBatchLocation.Data> bin = Navigator.push(
                                context,
                                MaterialPageRoute<cflBatchLocation.Data>(
                                    builder: (BuildContext context) =>
                                        CflBatchLocationPage(
                                            _whsCodeController.text,
                                            _batchNumberController.text,
                                            _itemCodeController.text)));

                            bin.then((cflBatchLocation.Data bin) {
                              setState(() {
                                if (bin != null) {
                                  _getState().data.binAbs = bin.absEntry;
                                  _getState().data.binCode = bin.binCode;
                                  _getState().data.availableQty =
                                      bin.availableQty;
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
                                      ? bgBlue
                                      : Colors.grey[400]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "From Bin Location",
                                      style: TextStyle(
                                          color: bgBlue, fontSize: 12.0),
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.only(left: 5),
                                      title: Text(_binCodeController.text),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          _availableQtyController.text != ""
                                              ? Text("Stock Quantity : " +
                                                  _availableQtyController.text)
                                              : Text(""),
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
                      TextFormField(
                        controller: _reqQtyController,
                        enabled: false,
                        decoration: InputDecoration(
                            labelText: "Request Quantity",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0))),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      _data.id == 0
                          ? TextField(
                              autofocus: true,
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
                                  _qtyController.selection =
                                      TextSelection.collapsed(
                                          offset: newValue.length);
                                });
                                _focusNode.unfocus();
                              },
                              inputFormatters: [
                                DecimalTextInputFormatter(decimalRange: 4)
                              ],
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              decoration: InputDecoration(
                                labelText: "Quantity",
                                contentPadding: new EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 10.0),
                                border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius:
                                        new BorderRadius.circular(10.0)),
                              ))
                          : TextFormField(
                              controller: _qtyController,
                              enabled: false,
                              decoration: InputDecoration(
                                  labelText: "Quantity",
                                  contentPadding: new EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0))),
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

                      // LabelFieldWidget(
                      //   labelText: "Item Code",
                      //   valueText: "${data.itemCode}",
                      // ),
                      // LabelFieldWidget(
                      //   labelText: "Item Name",
                      //   valueText: "${data.itemName}",
                      // ),
                      // LabelFieldWidget(
                      //   labelText: "Open SO Qty",
                      //   valueText: "${NumberFormat("#,###.00").format(data.soQty)}",
                      // ),
                      // _data.id == 0
                      //     ? TextField(
                      //         controller: _qtyController,
                      //         keyboardType: TextInputType.number,
                      //         // onChanged: (text) {},
                      //         decoration: InputDecoration(
                      //           labelText: "Request Qty",
                      //           contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                      //           enabledBorder: UnderlineInputBorder(
                      //               borderSide: BorderSide(color: Colors.blue)),
                      //         ))
                      //     : LabelFieldWidget(
                      //         labelText: "Request Qty",
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
              ]),
        ),
      ),
    );
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
