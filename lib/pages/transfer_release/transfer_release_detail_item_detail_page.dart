import 'package:wins_app/widgets/currency.dart';
import 'package:wins_app/widgets/validate_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wins_app/bloc_widgets/bloc_state_builder.dart';
import 'package:wins_app/blocs/transfer_release/detail_item_detail/transfer_release_detail_item_detail_bloc.dart';
import 'package:wins_app/blocs/transfer_release/detail_item_detail/transfer_release_detail_item_detail_event.dart';
import 'package:wins_app/blocs/transfer_release/detail_item_detail/transfer_release_detail_item_detail_state.dart';
import 'package:wins_app/models/transfer_release_detail_response.dart';
import 'package:wins_app/widgets/label_field_widget.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class TransferReleaseDetailItemDetailPage extends StatefulWidget {
  TransferReleaseDetailItemDetailPage(this._data);
  final Item _data;
  @override
  _TransferReleaseDetailItemDetailPageState createState() =>
      _TransferReleaseDetailItemDetailPageState(_data);
}

class _TransferReleaseDetailItemDetailPageState
    extends State<TransferReleaseDetailItemDetailPage> {
  _TransferReleaseDetailItemDetailPageState(this._data);

  final Item _data;
  TransferReleaseDetailItemDetailBloc bloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _itemCodeController = TextEditingController();
  final _itemNameController = TextEditingController();
  final _uomController = TextEditingController();
  final _qtyController = TextEditingController();

  @override
  void dispose() {
    _qtyController?.dispose();

    bloc?.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // double value = 0;
    // if (_qtyController.text!=""){
    //   value = double.parse(_qtyController.text);
    // }
    // final money  = NumberFormat();

    // String newText = money.format(value);
    // _qtyController.text = newText;

    // _qtyController.afterChange = (String masked, double raw) {
    //   if (raw != _getState().data.qty) {
    //     bloc.emitEvent(TransferReleaseDetailItemDetailEventQty(
    //       qty: raw,
    //     ));
    //   }
    // };

    bloc = TransferReleaseDetailItemDetailBloc(this._data);
  }

  void _done() {
    if (_qtyController.text == "0" || _qtyController.text == "") {
      ValidateDialogWidget(
          context: context, message: "Qty harus lebih besar dari 0");
      return;
    }
    bloc.emitEvent(TransferReleaseDetailItemDetailEventQty(
      qty: double.parse(_qtyController.text.replaceAll(new RegExp(','), '')),
    ));
    Navigator.pop(context, _getState().data);
  }

  TransferReleaseDetailItemDetailState _getState() {
    return bloc.lastState ?? bloc.initialState;
  }

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<TransferReleaseDetailItemDetailState>(
        bloc: bloc,
        builder:
            (BuildContext context, TransferReleaseDetailItemDetailState state) {
          return SafeArea(
              child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text("Item Detail"),
              backgroundColor: Colors.blue[900],
              bottom: PreferredSize(
                  child: Container(
                    color: Colors.yellow[900],
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
                        label: Text("Submit"),
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
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [const Color(0xfff9fbe7), const Color(0xffd7ccc8)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
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
                _data.id == 0
                    ? TextFormField(
                        autofocus: true,
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
                        //onChanged: (text) {},
                        decoration: InputDecoration(
                            labelText: "Release Qty",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: new BorderRadius.circular(10.0))))
                    : LabelFieldWidget(
                        labelText: "Release Qty",
                        valueText:
                            "${NumberFormat("#,###.00").format(data.qty)}",
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
                )
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
