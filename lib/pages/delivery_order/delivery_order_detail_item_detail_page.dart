import 'package:wins_app/blocs/global_bloc.dart';
import 'package:wins_app/pages/cfl/cfl_binlocation_page.dart';
import 'package:wins_app/pages/cfl/cfl_warehouse_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wins_app/bloc_widgets/bloc_state_builder.dart';
import 'package:wins_app/blocs/delivery_order/detail_item_detail/delivery_order_detail_item_detail_bloc.dart';
import 'package:wins_app/blocs/delivery_order/detail_item_detail/delivery_order_detail_item_detail_event.dart';
import 'package:wins_app/blocs/delivery_order/detail_item_detail/delivery_order_detail_item_detail_state.dart';
import 'package:wins_app/models/delivery_order_detail_response.dart';
import 'package:wins_app/pages/cfl/cfl_db_warehouse_page.dart';
import 'package:wins_app/widgets/label_field_widget.dart';
import 'package:intl/intl.dart';
import 'package:wins_app/widgets/set_colors.dart';
import 'package:wins_app/widgets/validate_dialog_widget.dart';
import 'package:wins_app/models/cfl_db_warehouse_model.dart' as cflDbWarehouse;
import 'package:wins_app/models/cfl_binlocation_response.dart'
    as cflBinLocation;
import 'package:wins_app/models/cfl_warehouse_response.dart' as cflWarehouse;
import 'dart:math' as math;

class DeliveryOrderDetailItemDetailPage extends StatefulWidget {
  DeliveryOrderDetailItemDetailPage(this._data);
  final Item _data;
  @override
  _DeliveryOrderDetailItemDetailPageState createState() =>
      _DeliveryOrderDetailItemDetailPageState(_data);
}

class _DeliveryOrderDetailItemDetailPageState
    extends State<DeliveryOrderDetailItemDetailPage> {
  _DeliveryOrderDetailItemDetailPageState(this._data);

  final Item _data;
  DeliveryOrderDetailItemDetailBloc bloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _itemCodeController = TextEditingController();
  final _itemNameController = TextEditingController();
  final _uomController = TextEditingController();
  final _qtySoController = TextEditingController();
  final _qtyController = TextEditingController();
  final _whsCodeController = TextEditingController();
  final _whsNameController = TextEditingController();
  final _binAbsController = TextEditingController();
  final _binCodeController = TextEditingController();
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
    bloc = DeliveryOrderDetailItemDetailBloc(this._data);
  }

  @override
  void dispose() {
    _qtyController?.dispose();
    _binAbsController?.dispose();
    _binCodeController?.dispose();
    _whsCodeController?.dispose();
    _whsNameController?.dispose();
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
    bloc.emitEvent(DeliveryOrderDetailItemDetailEventQty(
      qty: double.parse(_qtyController.text.replaceAll(new RegExp(','), '')),
    ));
    Navigator.pop(context, _getState().data);
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

  DeliveryOrderDetailItemDetailState _getState() {
    return bloc.lastState ?? bloc.initialState;
  }

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<DeliveryOrderDetailItemDetailState>(
        bloc: bloc,
        builder:
            (BuildContext context, DeliveryOrderDetailItemDetailState state) {
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
          ));
        });
  }

  Widget _buildForm() {
    var data = _getState().data;

    _itemCodeController.text = data.itemCode;
    _itemNameController.text = data.itemName;
    _batchNumberController.text = data.batchNo;
    _whsCodeController.text = data.whsCode;
    _whsNameController.text = data.whsName;
    _binAbsController.text = data.binAbs.toString();
    _binCodeController.text = data.binCode;
    _uomController.text = data.uom;
    _lengthController.text = data.length.toString();
    _widthController.text = data.width.toString();
    _itemTypeController.text = data.itemType;

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

    if (_data.soQty != 0) {
      if (_qtySoController.text == "") {
        _qtySoController.text = NumberFormat("###,###.####")
            .format(double.parse(data.soQty.toString()));
      } else {
        if (_data.soQty ==
            double.parse(
                _qtySoController.text.replaceAll(new RegExp(','), ''))) {
          _qtySoController.text = NumberFormat("###,###.####")
              .format(double.parse(data.soQty.toString()));
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
            padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
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
                TextField(
                  controller: _qtySoController,
                  enabled: false,
                  decoration: InputDecoration(
                      labelText: "Open SO Qty",
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                _data.id == 0
                    ? TextField(
                        enabled: false,
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
                          labelText: "Delivery Qty",
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
                            labelText: "Delivery Qty",
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
                Padding(padding: EdgeInsets.only(top: 10)),
                FlatButton(
                  padding: EdgeInsets.only(top: 5),
                  onPressed: () {},
                  child: Container(
                    padding: EdgeInsets.only(left: 5, top: 5),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        border: Border.all(
                            // color: (data.id == 0)
                            //     ? Colors.blue
                            //     : Colors.grey[400]
                            color: Colors.grey[400]),
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
                        // (data.id == 0)
                        //     ? Icon(
                        //         Icons.keyboard_arrow_right,
                        //       )
                        //     : Container(width: 0, height: 0),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                FlatButton(
                  padding: EdgeInsets.only(top: 5),
                  onPressed: () {
                    if (data.id == 0) {
                      Future<cflBinLocation.Data> bin = Navigator.push(
                          context,
                          MaterialPageRoute<cflBinLocation.Data>(
                              builder: (BuildContext context) =>
                                  CflBinLocationPage(
                                      _getState().data.whsCode)));

                      bin.then((cflBinLocation.Data bin) {
                        setState(() {
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
                            // color: (data.id == 0)
                            //     ? Colors.blue
                            //     : Colors.grey[400]),
                            color: Colors.grey[400]),
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
                        // (data.id == 0)
                        //     ? Icon(
                        //         Icons.keyboard_arrow_right,
                        //       )
                        //     : Container(width: 0, height: 0),
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
                //   labelText: "Open SO Qty",
                //   valueText: "${NumberFormat("#,###.00").format(data.soQty)}",
                // ),
                // _data.id == 0
                //     ? TextField(
                //         controller: _qtyController,
                //         keyboardType: TextInputType.number,
                //         // onChanged: (text) {},
                //         decoration: InputDecoration(
                //           labelText: "Delivery Qty",
                //           contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                //           enabledBorder: UnderlineInputBorder(
                //               borderSide: BorderSide(color: Colors.blue)),
                //         ))
                //     : LabelFieldWidget(
                //         labelText: "Delivery Qty",
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
