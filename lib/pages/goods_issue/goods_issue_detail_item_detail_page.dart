import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wins_app/bloc_widgets/bloc_state_builder.dart';
import 'package:wins_app/blocs/goods_issue/detail_item_detail/goods_issue_detail_item_detail_bloc.dart';
import 'package:wins_app/blocs/goods_issue/detail_item_detail/goods_issue_detail_item_detail_event.dart';
import 'package:wins_app/blocs/goods_issue/detail_item_detail/goods_issue_detail_item_detail_state.dart';
import 'package:wins_app/models/goods_issue_detail_response.dart';
import 'package:wins_app/pages/cfl/cfl_binlocation_page.dart';
import 'package:wins_app/widgets/label_field_widget.dart';
import 'package:intl/intl.dart';
import 'package:wins_app/widgets/set_colors.dart';
import 'package:wins_app/widgets/validate_dialog_widget.dart';
import 'package:wins_app/models/cfl_binlocation_response.dart'
    as cflBinLocation;

import 'dart:math' as math;

class GoodsIssueDetailItemDetailPage extends StatefulWidget {
  GoodsIssueDetailItemDetailPage(this._data);
  final Item _data;
  @override
  _GoodsIssueDetailItemDetailPageState createState() =>
      _GoodsIssueDetailItemDetailPageState(_data);
}

class _GoodsIssueDetailItemDetailPageState
    extends State<GoodsIssueDetailItemDetailPage> {
  _GoodsIssueDetailItemDetailPageState(this._data);

  final Item _data;
  GoodsIssueDetailItemDetailBloc bloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _itemCodeController = TextEditingController();
  final _itemNameController = TextEditingController();
  final _uomController = TextEditingController();
  final _whsCodeController = TextEditingController();
  final _whsNameController = TextEditingController();
  final _binAbsController = TextEditingController();
  final _binCodeController = TextEditingController();
  final _plannedQtyPoController = TextEditingController();
  final _availableQtyPoController = TextEditingController();
  final _openQtyPoController = TextEditingController();
  final _qtyPoController = TextEditingController();
  final _qtyController = TextEditingController();

  ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    bloc = GoodsIssueDetailItemDetailBloc(this._data);
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
    bloc.emitEvent(GoodsIssueDetailItemDetailEventQty(
      qty: double.parse(_qtyController.text.replaceAll(new RegExp(','), '')),
      binAbs: int.parse(_binAbsController.text),
      binCode: _binCodeController.text,
    ));
    Navigator.pop(context, _getState().data);
  }

  GoodsIssueDetailItemDetailState _getState() {
    return bloc.lastState ?? bloc.initialState;
  }

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<GoodsIssueDetailItemDetailState>(
        bloc: bloc,
        builder: (BuildContext context, GoodsIssueDetailItemDetailState state) {
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
              // note: fungsi SCAN
              floatingActionButton: _getState().data.id != 0
                  ? FloatingActionButton.extended(
                      backgroundColor: bgOrange,
                      icon: Icon(Icons.camera_alt),
                      label: Text("Scan"),
                      onPressed: () {},
                    )
                  : null,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            ),
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
    _qtyPoController.text = data.woQty.toString();
    _plannedQtyPoController.text = data.woQty.toString();
    _availableQtyPoController.text = data.woQty.toString();
    _openQtyPoController.text = data.woQty.toString();
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
                  controller: _whsCodeController,
                  enabled: false,
                  decoration: InputDecoration(
                      labelText: "To Warehouse Code",
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                TextFormField(
                  controller: _whsNameController,
                  enabled: false,
                  decoration: InputDecoration(
                      labelText: "To Warehouse Name",
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
                  controller: _qtyPoController,
                  enabled: false,
                  decoration: InputDecoration(
                      labelText: "Planned Qty",
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                _data.id == 0
                    ? TextField(
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
                    : Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: LabelFieldWidget(
                          labelText: "Issue Qty",
                          valueText:
                              "${NumberFormat("#,###.##").format(data.qty)}",
                        ),
                      ),
                Padding(padding: EdgeInsets.only(top: 15)),
                TextField(
                  controller: _availableQtyPoController,
                  enabled: false,
                  decoration: InputDecoration(
                      labelText: "Available Qty",
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                TextField(
                  controller: _plannedQtyPoController,
                  enabled: false,
                  decoration: InputDecoration(
                      labelText: "Planned Qty",
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                TextField(
                  controller: _openQtyPoController,
                  enabled: false,
                  decoration: InputDecoration(
                      labelText: "Open Qty",
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
                      labelText: "Qty",
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
          Container(
            padding: EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: data.id == 0
                      ? BorderSide(
                          color: Colors.blue,
                          width: 1.0,
                        )
                      : BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                ),
              ),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("List of Items"),
                  ],
                ),
              ),
            ),
          ),
          Container(
              //color: Colors.brown,
              child: (data != null)
                  ? _buildList()
                  : Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Text("Item Empty"),
                    )),
          Container(
            height: 5,
            color: Colors.grey,
          ),
          SizedBox(
            height: 65,
          )
        ]);
  }

  Widget _rowDetail(int index) {
    return Container(
      margin: new EdgeInsets.symmetric(horizontal: 0.0, vertical: 1.0),
      decoration: BoxDecoration(
          color: Colors.grey[400].withOpacity(0.5),
          border: Border(
              bottom: BorderSide(width: 1, color: Colors.grey[500]),
              left: BorderSide(width: 5, color: Colors.blue))),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: ListTile(
          title: Text("No. $index"),
          subtitle: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Batch No. :'),
              Text("Qty Batch :"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    var state = bloc.lastState ?? bloc.initialState;
    final data = state.data;
    if (data != null) {
      return ListView.builder(
        controller: _scrollController,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: 1,
        itemBuilder: (contex, index) {
          if (data != null) {
            return _rowDetail(index);
            // return Dismissible(
            //   // key: Key(data[index].hashCode.toString()),
            //   onDismissed: (direction) {
            //     // bloc.emitEvent(
            //     //     // GoodsIssueDetailEventItemRemove(itemIndex: index),
            //     //     );
            //   },
            //   background: Container(
            //       color: Colors.red,
            //       child: Align(
            //           child: Text('Delete',
            //               textAlign: TextAlign.right,
            //               style: TextStyle(
            //                   color: Colors.white,
            //                   fontSize: 24,
            //                   fontWeight: FontWeight.bold)))),
            //   child: _rowDetail(index),
            // );
          }
          //else {
          //   return _rowDetail(data, index);
          // }
        },
      );
    }
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
