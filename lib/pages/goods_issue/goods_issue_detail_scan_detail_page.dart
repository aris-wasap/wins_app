import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wins_app/bloc_widgets/bloc_state_builder.dart';
import 'package:wins_app/blocs/goods_issue/detail_item_detail_batch/goods_issue_detail_item_detail_batch_bloc.dart';
import 'package:wins_app/blocs/goods_issue/detail_item_detail_batch/goods_issue_detail_item_detail_batch_event.dart';
import 'package:wins_app/blocs/goods_issue/detail_item_detail_batch/goods_issue_detail_item_detail_batch_state.dart';
import 'package:wins_app/models/goods_issue_detail_response.dart';
import 'package:wins_app/pages/cfl/cfl_binlocation_page.dart';
import 'package:wins_app/pages/goods_issue/goods_issue_detail_item_detail_page.dart';
import 'package:wins_app/widgets/label_field_widget.dart';
import 'package:intl/intl.dart';
import 'package:wins_app/widgets/set_colors.dart';
import 'package:wins_app/widgets/validate_dialog_widget.dart';
import 'package:wins_app/models/cfl_binlocation_response.dart'
    as cflBinLocation;

import 'dart:math' as math;

class GoodsIssueDetailScanDetailPage extends StatefulWidget {
  GoodsIssueDetailScanDetailPage(this._data);
  final ItemBatch _data;
  @override
  _GoodsIssueDetailScanDetailPageState createState() =>
      _GoodsIssueDetailScanDetailPageState(_data);
}

class _GoodsIssueDetailScanDetailPageState
    extends State<GoodsIssueDetailScanDetailPage> {
  _GoodsIssueDetailScanDetailPageState(this._data);

  final ItemBatch _data;
  GoodsIssueDetailItemDetailBatchBloc bloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _itemCodeController = TextEditingController();
  final _itemNameController = TextEditingController();
  final _uomController = TextEditingController();
  final _whsCodeController = TextEditingController();
  final _whsNameController = TextEditingController();
  final _binAbsController = TextEditingController();
  final _binCodeController = TextEditingController();
  final _qtyController = TextEditingController();
  final _qtyPoController = TextEditingController();
  final _batchNoController = TextEditingController();
  FocusNode _focusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode = FocusNode();
    bloc = GoodsIssueDetailItemDetailBatchBloc(this._data);
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

  // void _done() {
  //   if (_qtyController.text == "0" || _qtyController.text == "") {
  //     ValidateDialogWidget(
  //         context: context, message: "Qty harus lebih besar dari 0");
  //     return;
  //   }
  //   bloc.emitEvent(GoodsIssueDetailItemDetailBatchEventQty(
  //     qty: double.parse(_qtyController.text.replaceAll(new RegExp(','), '')),
  //     binAbs: int.parse(_binAbsController.text),
  //     binCode: _binCodeController.text,
  //   ));
  //   // Navigator.pop(context, _getState().data);
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute<Item>(
  //       builder: (BuildContext context) =>
  //           GoodsIssueDetailItemDetailBatchPage(_getState().data),
  //     ),
  //   );
  // }

  void _done() {
    if (_qtyController.text == "0" || _qtyController.text == "") {
      ValidateDialogWidget(
          context: context, message: "Qty harus lebih besar dari 0");
      return;
    }
    bloc.emitEvent(GoodsIssueDetailItemDetailBatchEventQty(
      qty: double.parse(_qtyController.text.replaceAll(new RegExp(','), '')),
    ));
    Navigator.pop(context, _getState().data);
  }

  GoodsIssueDetailItemDetailBatchState _getState() {
    return bloc.lastState ?? bloc.initialState;
  }

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<GoodsIssueDetailItemDetailBatchState>(
        bloc: bloc,
        builder:
            (BuildContext context, GoodsIssueDetailItemDetailBatchState state) {
          return WillPopScope(
            onWillPop: () async {
              if (_data.detId > 0) {
                if (await confirm(context)) {
                  // items.id = _newData.id;
                  // Navigator.pop(context, items);
                  _done();
                } else {
                  return;
                }
              } else {
                Navigator.pop(context);
              }
            },
            child: SafeArea(
                child: Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                title: Text("Batch Number Detail"),
                backgroundColor: bgBlue,
                bottom: PreferredSize(
                    child: Container(
                      color: bgOrange,
                      height: 5.0,
                    ),
                    preferredSize: Size.fromHeight(5.0)),
                actions: <Widget>[
                  _data.detDetId != 0
                      ? FlatButton(
                          onPressed: () {
                            _done();
                          },
                          textColor: Colors.white,
                          child: Row(
                              // children: <Widget>[Text("Update")],
                              ),
                        )
                      : Container(),
                ],
              ),
              body: SingleChildScrollView(
                child: _buildForm(),
              ),
            )),
          );
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
    _qtyPoController.text = data.quantity.toString();
    _batchNoController.text = data.batchNo;

    if (_data.quantity != 0) {
      if (_qtyController.text == "") {
        _qtyController.text = NumberFormat("###,###.##")
            .format(double.parse(data.quantity.toString()));
      } else {
        if (_data.quantity ==
            double.parse(_qtyController.text.replaceAll(new RegExp(','), ''))) {
          _qtyController.text = NumberFormat("###,###.##")
              .format(double.parse(data.quantity.toString()));
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
                  controller: _batchNoController,
                  enabled: false,
                  decoration: InputDecoration(
                      labelText: "Batch Number",
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
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
                // Padding(padding: EdgeInsets.only(top: 10)),
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
                // Padding(padding: EdgeInsets.only(top: 10)),
                // TextFormField(
                //   controller: _whsNameController,
                //   enabled: false,
                //   decoration: InputDecoration(
                //       labelText: "To Warehouse Name",
                //       contentPadding: new EdgeInsets.symmetric(
                //           vertical: 15.0, horizontal: 10.0),
                //       border: new OutlineInputBorder(
                //           borderRadius: new BorderRadius.circular(10.0))),
                // ),
                // Padding(padding: EdgeInsets.only(top: 10)),
                // FlatButton(
                //   padding: EdgeInsets.only(top: 5),
                //   onPressed: () {
                //     if (data.id == 0) {
                //       setState(() {
                //         Future<cflBinLocation.Data> bin = Navigator.push(
                //             context,
                //             MaterialPageRoute<cflBinLocation.Data>(
                //                 builder: (BuildContext context) =>
                //                     CflBinLocationPage(
                //                         _whsCodeController.text)));

                //         bin.then((cflBinLocation.Data bin) {
                //           if (bin != null) {
                //             // _binAbsController.text = bin.absEntry.toString();
                //             // _binCodeController.text =  bin.binCode;
                //             _getState().data.binAbs = bin.absEntry;
                //             _getState().data.binCode = bin.binCode;
                //           }
                //         });
                //       });
                //     }
                //   },
                //   child: Container(
                //     padding: EdgeInsets.only(left: 5, top: 5),
                //     alignment: Alignment.centerLeft,
                //     decoration: BoxDecoration(
                //         border: Border.all(
                //             color: (data.id == 0)
                //                 ? Colors.blue
                //                 : Colors.grey[400]),
                //         borderRadius: BorderRadius.all(Radius.circular(10))),
                //     child: Row(
                //       children: <Widget>[
                //         Expanded(
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: <Widget>[
                //               Text(
                //                 "To Bin Location",
                //                 style: TextStyle(
                //                     color: Colors.blue, fontSize: 12.0),
                //               ),
                //               ListTile(
                //                 contentPadding: EdgeInsets.only(left: 5),
                //                 title: Text(_binCodeController.text),
                //               )
                //             ],
                //           ),
                //         ),
                //         (data.id == 0)
                //             ? Icon(
                //                 Icons.keyboard_arrow_right,
                //               )
                //             : Container(width: 0, height: 0),
                //       ],
                //     ),
                //   ),
                // ),
                // Padding(padding: EdgeInsets.only(top: 10)),
                _data.detId > 0
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
                          labelText: "Issue Qty",
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
                            labelText: "Issue Qty",
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
