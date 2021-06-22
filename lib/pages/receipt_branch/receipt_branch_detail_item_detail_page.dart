import 'package:admart_app/blocs/global_bloc.dart';
import 'package:admart_app/pages/cfl/cfl_warehouse_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:admart_app/bloc_widgets/bloc_state_builder.dart';
import 'package:admart_app/blocs/receipt_branch/detail_item_detail/receipt_branch_detail_item_detail_bloc.dart';
import 'package:admart_app/blocs/receipt_branch/detail_item_detail/receipt_branch_detail_item_detail_event.dart';
import 'package:admart_app/blocs/receipt_branch/detail_item_detail/receipt_branch_detail_item_detail_state.dart';
import 'package:admart_app/models/receipt_branch_detail_response.dart';
import 'package:admart_app/pages/cfl/cfl_binlocation_page.dart';
import 'package:admart_app/widgets/label_field_widget.dart';
import 'package:intl/intl.dart';
import 'package:admart_app/widgets/set_colors.dart';
import 'package:admart_app/widgets/validate_dialog_widget.dart';
import 'package:admart_app/models/cfl_binlocation_response.dart'
    as cflBinLocation;
import 'package:admart_app/models/cfl_warehouse_response.dart' as cflWarehouse;
import 'dart:math' as math;

class ReceiptBranchDetailItemDetailPage extends StatefulWidget {
  ReceiptBranchDetailItemDetailPage(this._data);
  final Item _data;
  @override
  _ReceiptBranchDetailItemDetailPageState createState() =>
      _ReceiptBranchDetailItemDetailPageState(_data);
}

class _ReceiptBranchDetailItemDetailPageState
    extends State<ReceiptBranchDetailItemDetailPage> {
  _ReceiptBranchDetailItemDetailPageState(this._data);

  final Item _data;
  ReceiptBranchDetailItemDetailBloc bloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _itemCodeController = TextEditingController();
  final _itemNameController = TextEditingController();
  final _uomController = TextEditingController();
  final _fromWhsCodeController = TextEditingController();
  final _fromWhsNameController = TextEditingController();
  final _fromBinAbsController = TextEditingController();
  final _fromBinCodeController = TextEditingController();
  final _whsCodeController = TextEditingController();
  final _whsNameController = TextEditingController();
  final _binAbsController = TextEditingController();
  final _binCodeController = TextEditingController();
  final _qtyIssueController = TextEditingController();
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
    bloc = ReceiptBranchDetailItemDetailBloc(this._data);
  }

  @override
  void dispose() {
    _qtyController?.dispose();
    _fromWhsCodeController?.dispose();
    _fromWhsNameController?.dispose();
    _fromBinAbsController?.dispose();
    _fromBinCodeController?.dispose();
    _whsCodeController?.dispose();
    _whsNameController?.dispose();
    _binAbsController?.dispose();
    _binCodeController?.dispose();
    _batchNumberController?.dispose();
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
    bloc.emitEvent(ReceiptBranchDetailItemDetailEventQty(
      qty: double.parse(_qtyController.text.replaceAll(new RegExp(','), '')),
      binAbs: int.parse(_binAbsController.text),
      binCode: _binCodeController.text,
    ));
    Navigator.pop(context, _getState().data);
  }

  ReceiptBranchDetailItemDetailState _getState() {
    return bloc.lastState ?? bloc.initialState;
  }

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<ReceiptBranchDetailItemDetailState>(
        bloc: bloc,
        builder:
            (BuildContext context, ReceiptBranchDetailItemDetailState state) {
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
    _batchNumberController.text = data.batchNo;
    _uomController.text = data.uom;
    _fromWhsCodeController.text = data.fromWhsCode;
    _fromWhsNameController.text = data.fromWhsName;
    _fromBinAbsController.text = data.fromBinAbs.toString();
    _fromBinCodeController.text = data.fromBinCode;
    _whsCodeController.text = data.whsCode;
    _whsNameController.text = data.whsName;
    _binAbsController.text = data.binAbs.toString();
    _binCodeController.text = data.binCode;
    _qtyIssueController.text = data.issueQty.toString();

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

    if (_data.issueQty != 0) {
      if (_qtyIssueController.text == "") {
        _qtyIssueController.text = NumberFormat("###,###.##")
            .format(double.parse(data.issueQty.toString()));
      } else {
        if (_data.issueQty ==
            double.parse(
                _qtyIssueController.text.replaceAll(new RegExp(','), ''))) {
          _qtyIssueController.text = NumberFormat("###,###.##")
              .format(double.parse(data.issueQty.toString()));
        }
      }
    }

    var mediaQueryData = MediaQuery.of(context);
    final double widthScreen = mediaQueryData.size.width;
    final double heightScreen = mediaQueryData.size.height;

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
                        controller: _fromWhsNameController,
                        enabled: false,
                        decoration: InputDecoration(
                            labelText: "From Warehouse",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0))),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      TextFormField(
                        controller: _fromBinCodeController,
                        enabled: false,
                        decoration: InputDecoration(
                            labelText: "From Bin Location",
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
                              Future<cflWarehouse.Data> whs = Navigator.push(
                                  context,
                                  MaterialPageRoute<cflWarehouse.Data>(
                                      builder: (BuildContext context) =>
                                          CflWarehousePage(
                                              globalBloc.branchId)));

                              whs.then((cflWarehouse.Data whs) {
                                if (whs != null) {
                                  _getState().data.whsCode = whs.whsCode;
                                  _getState().data.whsName = whs.whsName;
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
                                      "To Warehouse",
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
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
                        controller: _qtyIssueController,
                        enabled: false,
                        decoration: InputDecoration(
                            labelText: "Issue Quantity",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0))),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      _data.id == 0
                          ? TextField(
                              //autofocus: true,
                              enabled: false,
                              controller: _qtyController,
                              onEditingComplete: () {
                                setState(() {
                                  String newValue = NumberFormat("###,###.##")
                                      .format(double.parse(_qtyController.text
                                          .replaceAll(new RegExp(','), '')
                                          .replaceAll(new RegExp('-'), '')
                                          .replaceAll(new RegExp(' '), '')));
                                  _qtyController.text = newValue;
                                  _qtyController.selection =
                                      TextSelection.collapsed(
                                          offset: newValue.length);
                                });
                              },
                              inputFormatters: [
                                DecimalTextInputFormatter(decimalRange: 4)
                              ],
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              decoration: InputDecoration(
                                labelText: "Receipt Quantity",
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
                                  labelText: "Receipt Quantity",
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
                      Padding(padding: EdgeInsets.only(top: 10)),

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