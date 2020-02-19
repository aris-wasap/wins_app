import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ncf_app/bloc_widgets/bloc_state_builder.dart';
import 'package:ncf_app/blocs/receipt_production/detail_item_detail/receipt_production_detail_item_detail_bloc.dart';
import 'package:ncf_app/blocs/receipt_production/detail_item_detail/receipt_production_detail_item_detail_event.dart';
import 'package:ncf_app/blocs/receipt_production/detail_item_detail/receipt_production_detail_item_detail_state.dart';
import 'package:ncf_app/models/receipt_production_detail_response.dart';
import 'package:ncf_app/widgets/label_field_widget.dart';
import 'package:intl/intl.dart';
import 'package:ncf_app/widgets/set_colors.dart';
import 'package:ncf_app/widgets/validate_dialog_widget.dart';
import 'dart:math' as math;

class ReceiptProductionDetailItemDetailPage extends StatefulWidget {
  ReceiptProductionDetailItemDetailPage(this._data);
  final Item _data;
  @override
  _ReceiptProductionDetailItemDetailPageState createState() =>
      _ReceiptProductionDetailItemDetailPageState(_data);
}

class _ReceiptProductionDetailItemDetailPageState
    extends State<ReceiptProductionDetailItemDetailPage> {
  _ReceiptProductionDetailItemDetailPageState(this._data);

  final Item _data;
  ReceiptProductionDetailItemDetailBloc bloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _woIdController = TextEditingController();
  final _woNoController = TextEditingController();
  final _itemCodeController = TextEditingController();
  final _itemNameController = TextEditingController();
  final _uomController = TextEditingController();
  final _qtyController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    bloc = ReceiptProductionDetailItemDetailBloc(this._data);
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
    bloc.emitEvent(ReceiptProductionDetailItemDetailEventQty(
      qty: double.parse(_qtyController.text.replaceAll(new RegExp(','), '')),
    ));
    Navigator.pop(context, _getState().data);
  }

  ReceiptProductionDetailItemDetailState _getState() {
    return bloc.lastState ?? bloc.initialState;
  }

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<ReceiptProductionDetailItemDetailState>(
        bloc: bloc,
        builder:
            (BuildContext context, ReceiptProductionDetailItemDetailState state) {
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
                    ? 
                    FlatButton(
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
    _woIdController.text = data.woId.toString();
    _woNoController.text = data.woNo;
    _itemCodeController.text = data.itemCode;
    _itemNameController.text = data.itemName;
    _uomController.text = data.uom;
    if(_data.quantity != 0){
      if(_qtyController.text==""){
        _qtyController.text = NumberFormat("###,###.####").format(double.parse(data.quantity.toString()));
      }
      else{
        if(_data.quantity == double.parse(_qtyController.text.replaceAll(new RegExp(','), ''))){
          _qtyController.text = NumberFormat("###,###.####").format(double.parse(data.quantity.toString()));
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
                  controller: _woIdController,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: "Wo ID.",
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
                  controller: _woNoController,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: "Wo No.",
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
                
                _data.id == 0
                    ? TextField(
                        enabled: false,
                        //autofocus: true,
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
                          labelText: "Receipt Qty",
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
                        labelText: "Receipt Qty",
                        valueText:
                            "${NumberFormat("#,###.00").format(data.quantity)}",
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