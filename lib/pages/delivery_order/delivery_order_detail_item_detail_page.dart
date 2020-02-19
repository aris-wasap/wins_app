import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ncf_app/bloc_widgets/bloc_state_builder.dart';
import 'package:ncf_app/blocs/delivery_order/detail_item_detail/delivery_order_detail_item_detail_bloc.dart';
import 'package:ncf_app/blocs/delivery_order/detail_item_detail/delivery_order_detail_item_detail_event.dart';
import 'package:ncf_app/blocs/delivery_order/detail_item_detail/delivery_order_detail_item_detail_state.dart';
import 'package:ncf_app/models/delivery_order_detail_response.dart';
import 'package:ncf_app/widgets/label_field_widget.dart';
import 'package:intl/intl.dart';
import 'package:ncf_app/widgets/set_colors.dart';
import 'package:ncf_app/widgets/validate_dialog_widget.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    bloc = DeliveryOrderDetailItemDetailBloc(this._data);
  }

  @override
  void dispose() {
    _qtyController?.dispose();

    bloc?.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  void _done() {
    if (_qtyController.text == "0" || _qtyController.text == "") {
      ValidateDialogWidget(
          context: context, massage: "Qty harus lebih besar dari 0");
      return;
    }
    bloc.emitEvent(DeliveryOrderDetailItemDetailEventQty(
      qty: double.parse(_qtyController.text.replaceAll(new RegExp(','), '')),
    ));
    Navigator.pop(context, _getState().data);
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
              backgroundColor: Colors.blue[500],
              bottom: PreferredSize(
                child: Container(
                  color: Colors.orange[500],
                  height: 5.0,
                ),
                preferredSize: Size.fromHeight(5.0)
              ),
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
    _qtySoController.text = data.soQty.toString();
    if(_data.qty != 0){
      if(_qtyController.text==""){
        _qtyController.text = NumberFormat("###,###.####").format(double.parse(data.qty.toString()));
      }
      else{
        if(_data.qty == double.parse(_qtyController.text.replaceAll(new RegExp(','), ''))){
          _qtyController.text = NumberFormat("###,###.####").format(double.parse(data.qty.toString()));
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
                TextFormField(
                  controller: _itemCodeController,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: "Item Code",
                    contentPadding: new EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0)
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10)
                ),
                TextFormField(
                  controller: _itemNameController,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: "Item Name",
                    contentPadding: new EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0)
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10)
                ), 
                TextField(
                  controller: _qtySoController,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: "Open SO Qty",
                    contentPadding: new EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0)
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10)
                ), 
                _data.id == 0
                    ? TextField(
                        autofocus: true,
                        controller: _qtyController,
                        onEditingComplete: (){
                          setState(() {
                            String newValue = NumberFormat("###,###.####").format(double.parse(_qtyController.text.replaceAll(new RegExp(','), '').replaceAll(new RegExp('-'), '').replaceAll(new RegExp(' '), '')));
                            _qtyController.text = newValue;
                            _qtyController.selection = TextSelection.collapsed(offset: newValue.length);
                          });
                        },
                        inputFormatters: [DecimalTextInputFormatter(decimalRange: 4)],
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          labelText: "Delivery Qty",
                          contentPadding: new EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0)
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: new BorderRadius.circular(10.0)
                          ),
                        ))
                    : LabelFieldWidget(
                        labelText: "Delivery Qty",
                        valueText:
                            "${NumberFormat("#,###.00").format(data.qty)}",
                      ),
                Padding(
                  padding: EdgeInsets.only(top: 10)
                ),
                TextFormField(
                  controller: _uomController,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: "UoM",
                    contentPadding: new EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0)
                    )
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
                //   valueText: "${NumberFormat("#,###.0000").format(data.soQty)}",
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
                //             "${NumberFormat("#,###.0000").format(data.qty)}",
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
  DecimalTextInputFormatter({this.decimalRange}) : assert(decimalRange == null || decimalRange > 0);

  final int decimalRange;
  final money  = NumberFormat("###,###,###", "en_US");

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    TextSelection newSelection = newValue.selection;
    String truncated =  newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") && value.substring(value.indexOf(".") + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      }
      else if (value == ".") {
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