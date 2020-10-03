import 'package:admart_app/blocs/global_bloc.dart';
import 'package:admart_app/pages/cfl/cfl_warehouse_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:admart_app/bloc_widgets/bloc_state_builder.dart';
import 'package:admart_app/blocs/payable_credit/detail_item_detail/payable_credit_detail_item_detail_bloc.dart';
import 'package:admart_app/blocs/payable_credit/detail_item_detail/payable_credit_detail_item_detail_event.dart';
import 'package:admart_app/blocs/payable_credit/detail_item_detail/payable_credit_detail_item_detail_state.dart';
import 'package:admart_app/models/payable_credit_detail_response.dart';
import 'package:admart_app/pages/cfl/cfl_binlocation_page.dart';
import 'package:admart_app/widgets/label_field_widget.dart';
import 'package:intl/intl.dart';
import 'package:admart_app/widgets/set_colors.dart';
import 'package:admart_app/widgets/validate_dialog_widget.dart';
import 'package:admart_app/models/cfl_binlocation_response.dart'
    as cflBinLocation;
import 'package:admart_app/models/cfl_warehouse_response.dart' as cflWarehouse;
import 'dart:math' as math;

class PayableCreditDetailItemDetailPage extends StatefulWidget {
  PayableCreditDetailItemDetailPage(this._data);
  final Item _data;
  @override
  _PayableCreditDetailItemDetailPageState createState() =>
      _PayableCreditDetailItemDetailPageState(_data);
}

class _PayableCreditDetailItemDetailPageState
    extends State<PayableCreditDetailItemDetailPage> {
  _PayableCreditDetailItemDetailPageState(this._data);

  final Item _data;
  PayableCreditDetailItemDetailBloc bloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _itemCodeController = TextEditingController();
  final _itemNameController = TextEditingController();
  final _uomController = TextEditingController();
  final _whsCodeController = TextEditingController();
  final _whsNameController = TextEditingController();
  final _binAbsController = TextEditingController();
  final _binCodeController = TextEditingController();
  final _qtyPoController = TextEditingController();
  final _qtyController = TextEditingController();
  final _batchNumberController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    bloc = PayableCreditDetailItemDetailBloc(this._data);
  }

  @override
  void dispose() {
    _qtyController?.dispose();
    _binAbsController?.dispose();
    _binCodeController?.dispose();

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
    bloc.emitEvent(PayableCreditDetailItemDetailEventQty(
      qty: double.parse(_qtyController.text.replaceAll(new RegExp(','), '')),
      binAbs: int.parse(_binAbsController.text),
      binCode: _binCodeController.text,
    ));
    Navigator.pop(context, _getState().data);
  }

  PayableCreditDetailItemDetailState _getState() {
    return bloc.lastState ?? bloc.initialState;
  }

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<PayableCreditDetailItemDetailState>(
        bloc: bloc,
        builder:
            (BuildContext context, PayableCreditDetailItemDetailState state) {
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
    _whsCodeController.text = data.whsCode;
    _whsNameController.text = data.whsName;
    _binAbsController.text = data.binAbs.toString();
    _binCodeController.text = data.binCode;
    _qtyPoController.text = data.reqQty.toString();
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
                TextField(
                  controller: _qtyPoController,
                  enabled: false,
                  decoration: InputDecoration(
                      labelText: "Request Qty",
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                _data.id == 0
                    ? TextField(
                        //autofocus: true,
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
                        },
                        inputFormatters: [
                          DecimalTextInputFormatter(decimalRange: 4)
                        ],
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          labelText: "Return Qty",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: new BorderRadius.circular(10.0)),
                        ))
                    : Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: LabelFieldWidget(
                          labelText: "Return Qty",
                          valueText:
                              "${NumberFormat("#,###.00").format(data.qty)}",
                        ),
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
                                "From Warehouse",
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
                                "From Bin Location",
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
                //           labelText: "Return Qty",
                //           contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                //           enabledBorder: UnderlineInputBorder(
                //               borderSide: BorderSide(color: Colors.blue)),
                //         ))
                //     : LabelFieldWidget(
                //         labelText: "Return Qty",
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
