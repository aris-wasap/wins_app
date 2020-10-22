import 'package:admart_app/blocs/global_bloc.dart';
import 'package:admart_app/pages/cfl/cfl_warehouse_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:admart_app/bloc_widgets/bloc_state_builder.dart';
import 'package:admart_app/blocs/receipt_supplier/detail_item_detail/receipt_supplier_detail_item_detail_bloc.dart';
import 'package:admart_app/blocs/receipt_supplier/detail_item_detail/receipt_supplier_detail_item_detail_event.dart';
import 'package:admart_app/blocs/receipt_supplier/detail_item_detail/receipt_supplier_detail_item_detail_state.dart';
import 'package:admart_app/models/cfl_purchase_item_response.dart'
    as cflPurchaseItem;
import 'package:admart_app/models/receipt_supplier_detail_response.dart';
import 'package:admart_app/pages/cfl/cfl_binlocation_page.dart';
import 'package:admart_app/pages/cfl/cfl_purchase_item_page.dart';
import 'package:admart_app/widgets/label_field_widget.dart';
import 'package:intl/intl.dart';
import 'package:admart_app/widgets/set_colors.dart';
import 'package:admart_app/widgets/validate_dialog_widget.dart';
import 'package:admart_app/models/cfl_binlocation_response.dart'
    as cflBinLocation;
import 'package:admart_app/models/cfl_warehouse_response.dart' as cflWarehouse;
import 'dart:math' as math;

class ReceiptSupplierDetailItemDetailPage extends StatefulWidget {
  ReceiptSupplierDetailItemDetailPage(this._data);
  final Item _data;
  @override
  _ReceiptSupplierDetailItemDetailPageState createState() =>
      _ReceiptSupplierDetailItemDetailPageState(_data);
}

class _ReceiptSupplierDetailItemDetailPageState
    extends State<ReceiptSupplierDetailItemDetailPage> {
  _ReceiptSupplierDetailItemDetailPageState(this._data);

  final Item _data;
  ReceiptSupplierDetailItemDetailBloc bloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _poIdController = TextEditingController();
  final _lineNoController = TextEditingController();
  final _batchNumberController = TextEditingController();
  final _itemCodeController = TextEditingController();
  final _itemNameController = TextEditingController();
  final _uomController = TextEditingController();
  final _whsCodeController = TextEditingController();
  final _whsNameController = TextEditingController();
  final _binAbsController = TextEditingController();
  final _binCodeController = TextEditingController();
  final _qtyPoController = TextEditingController();
  final _qtyController = TextEditingController();
  final _isAssetController = TextEditingController();
  final _isBatchController = TextEditingController();
  final _lengthController = TextEditingController();
  final _widthController = TextEditingController();
  final _unitPriceTcController = TextEditingController();
  final _itemTypeController = TextEditingController();
  FocusNode _focusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode = FocusNode();
    bloc = ReceiptSupplierDetailItemDetailBloc(this._data);
  }

  @override
  void dispose() {
    _qtyController?.dispose();
    _binAbsController?.dispose();
    _binCodeController?.dispose();
    _focusNode?.dispose();
    bloc?.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  void _done() {
    if (_qtyController.text == "0.0" || _qtyController.text == "") {
      ValidateDialogWidget(
          context: context, message: "Receipt Qty harus lebih besar dari 0");
      return;
    }

    if (_whsCodeController.text == null || _whsCodeController.text == "") {
      ValidateDialogWidget(
          context: context, message: "Pilih Warehouse terlebih dahulu");
      return;
    }
    if (_binCodeController.text == null || _binCodeController.text == "") {
      ValidateDialogWidget(
          context: context, message: "Pilih Bin Location terlebih dahulu");
      return;
    }

    bloc.emitEvent(ReceiptSupplierDetailItemDetailEventQty(
      qty: double.parse(_qtyController.text.replaceAll(new RegExp(','), '')),
    ));
    Navigator.pop(context, _getState().data);
  }

  ReceiptSupplierDetailItemDetailState _getState() {
    return bloc.lastState ?? bloc.initialState;
  }

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<ReceiptSupplierDetailItemDetailState>(
        bloc: bloc,
        builder:
            (BuildContext context, ReceiptSupplierDetailItemDetailState state) {
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
    _poIdController.text = data.poId.toString();
    _lineNoController.text = data.poLineNo.toString();
    _batchNumberController.text = data.batchNo;
    _itemCodeController.text = data.itemCode;
    _itemNameController.text = data.itemName;
    _uomController.text = data.uom;
    _whsCodeController.text = data.whsCode;
    _whsNameController.text = data.whsName;
    _binAbsController.text = data.binAbs.toString();
    _binCodeController.text = data.binCode;
    _isAssetController.text = data.isAsset;
    _isBatchController.text = data.isBatch;

    if (_data.unitPriceTc != 0) {
      if (_unitPriceTcController.text == "") {
        _unitPriceTcController.text = NumberFormat("###,###.####")
            .format(double.parse(data.unitPriceTc.toString()));
      } else {
        if (_data.unitPriceTc ==
            double.parse(
                _unitPriceTcController.text.replaceAll(new RegExp(','), ''))) {
          _unitPriceTcController.text = NumberFormat("###,###.####")
              .format(double.parse(data.unitPriceTc.toString()));
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

    if (_data.poQty != 0) {
      if (_qtyPoController.text == "") {
        _qtyPoController.text = NumberFormat("###,###.####")
            .format(double.parse(data.poQty.toString()));
      } else {
        if (_data.poQty ==
            double.parse(
                _qtyPoController.text.replaceAll(new RegExp(','), ''))) {
          _qtyPoController.text = NumberFormat("###,###.####")
              .format(double.parse(data.poQty.toString()));
        }
      }
    }

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(gradient: bgGradientPageWhite),
            padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // TextFormField(
                //   controller: _poIdController,
                //   enabled: false,
                //   decoration: InputDecoration(
                //       labelText: "PO No.",
                //       contentPadding: new EdgeInsets.symmetric(
                //           vertical: 15.0, horizontal: 10.0),
                //       border: new OutlineInputBorder(
                //           borderRadius: new BorderRadius.circular(10.0))),
                // ),
                // Padding(padding: EdgeInsets.only(top: 10)),
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
                  autofocus: true,
                  padding: EdgeInsets.only(top: 5),
                  onPressed: () {
                    if (data.id == 0) {
                      Future<cflPurchaseItem.Data> pi = Navigator.push(
                          context,
                          MaterialPageRoute<cflPurchaseItem.Data>(
                              builder: (BuildContext context) =>
                                  CflPurchaseItemPage(
                                      int.parse(_poIdController.text))));

                      pi.then((cflPurchaseItem.Data pi) {
                        if (pi != null) {
                          _getState().data.poLineNo = pi.lineNum;
                          _getState().data.itemCode = pi.itemCode;
                          _getState().data.itemName = pi.itemName;
                          _getState().data.itemType = pi.itemType;
                          _getState().data.poQty = pi.quantity;
                          _getState().data.unitPriceTc = pi.unitPriceTc;
                          //_getState().data.qty = pi.quantity;
                          _getState().data.uom = pi.uom;
                          _getState().data.length = pi.length;
                          _getState().data.width = pi.width;
                          _getState().data.whsCode = pi.whsCode;
                          _getState().data.whsName = pi.whsName;
                          _getState().data.isAsset = pi.isAsset;
                          _getState().data.isBatch = pi.isBatch;
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
                                "Item Code",
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 12.0),
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
                TextField(
                  controller: _qtyPoController,
                  enabled: false,
                  decoration: InputDecoration(
                      labelText: "Open PO Qty",
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
                Padding(padding: EdgeInsets.only(top: 10)),
                // TextFormField(
                //   controller: _whsCodeController,
                //   enabled: false,
                //   decoration: InputDecoration(
                //       labelText: "To Warehouse Code",
                //       contentPadding: new EdgeInsets.symmetric(
                //           vertical: 15.0, horizontal: 10.0),
                //       border: new OutlineInputBorder(
                //           borderRadius: new BorderRadius.circular(10.0))),
                // ),
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
                                    CflWarehousePage(globalBloc.branchId)));

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
