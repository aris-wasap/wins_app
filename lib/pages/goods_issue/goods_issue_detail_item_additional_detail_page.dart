import 'package:barcode_scan/barcode_scan.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wins_app/bloc_widgets/bloc_state_builder.dart';
import 'package:wins_app/blocs/global_bloc.dart';
// import 'package:wins_app/blocs/goods_issue/detail/goods_issue_detail_event.dart';
import 'package:wins_app/blocs/goods_issue/detail_item_additional_detail/goods_issue_detail_item_additional_detail_bloc.dart';
import 'package:wins_app/blocs/goods_issue/detail_item_additional_detail/goods_issue_detail_item_additional_detail_event.dart';
import 'package:wins_app/blocs/goods_issue/detail_item_additional_detail/goods_issue_detail_item_additional_detail_state.dart';
import 'package:wins_app/models/goods_issue_detail_response.dart';
import 'package:wins_app/pages/cfl/cfl_batch_location_page.dart';
import 'package:wins_app/pages/cfl/cfl_binlocation_page.dart';
import 'package:wins_app/pages/cfl/cfl_item_page.dart';
import 'package:wins_app/pages/cfl/cfl_warehouse_page.dart';
import 'package:wins_app/pages/goods_issue/goods_issue_detail_scan_detail_page.dart';
import 'package:wins_app/widgets/label_field_widget.dart';
import 'package:intl/intl.dart';
import 'package:wins_app/widgets/set_colors.dart';
import 'package:wins_app/widgets/validate_dialog_widget.dart';
import 'package:wins_app/models/cfl_warehouse_response.dart' as cflWarehouse;
import 'package:wins_app/models/cfl_binlocation_response.dart'
    as cflBinLocation;
import 'package:wins_app/models/cfl_item_response.dart' as cflItem;
import 'package:wins_app/models/cfl_batch_location_response.dart'
    as cflBatchLocation;
import 'dart:math' as math;
import 'package:audioplayers/audio_cache.dart';

class GoodsIssueDetailItemAdditionalDetailPage extends StatefulWidget {
  GoodsIssueDetailItemAdditionalDetailPage(
      this._data, this._index, this._newData);
  final int _index;
  final Item _data;
  final Data _newData;
  @override
  _GoodsIssueDetailItemAdditionalDetailPageState createState() =>
      _GoodsIssueDetailItemAdditionalDetailPageState(_data, _index, _newData);
}

class _GoodsIssueDetailItemAdditionalDetailPageState
    extends State<GoodsIssueDetailItemAdditionalDetailPage> {
  _GoodsIssueDetailItemAdditionalDetailPageState(
      this._data, this._index, this._newData);
  final int _index;
  final Item _data;
  final Data _newData;
  GoodsIssueDetailItemAdditionalDetailBloc bloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _idController = TextEditingController();
  final _detIdController = TextEditingController();
  final _woIdController = TextEditingController();
  final _woLineNoController = TextEditingController();
  final _itemCodeController = TextEditingController();
  final _itemNameController = TextEditingController();
  final _uomController = TextEditingController();
  final _whsCodeController = TextEditingController();
  final _whsNameController = TextEditingController();
  final _binAbsController = TextEditingController();
  final _binCodeController = TextEditingController();
  final _toWhsCodeController = TextEditingController();
  final _toWhsNameController = TextEditingController();
  final _toBinAbsController = TextEditingController();
  final _toBinCodeController = TextEditingController();
  final _qtyWoController = TextEditingController();
  final _qtyController = TextEditingController();
  final _availableQtyController = TextEditingController();
  ScrollController _scrollController;
  FocusNode _focusNode;
  FocusNode _focusNodeWoQty;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode = FocusNode();
    _focusNodeWoQty = FocusNode();
    bloc = GoodsIssueDetailItemAdditionalDetailBloc(this._data);
  }

  @override
  void dispose() {
    _idController?.dispose();
    _detIdController?.dispose();
    _woIdController?.dispose();
    _woLineNoController?.dispose();
    _itemCodeController?.dispose();
    _itemNameController?.dispose();
    _uomController?.dispose();
    _whsCodeController?.dispose();
    _whsNameController?.dispose();
    _binAbsController?.dispose();
    _binCodeController?.dispose();
    _toWhsCodeController?.dispose();
    _toWhsNameController?.dispose();
    _toBinAbsController?.dispose();
    _toBinCodeController?.dispose();
    _qtyWoController?.dispose();
    _qtyController?.dispose();
    _availableQtyController?.dispose();
    _focusNode?.dispose();
    _focusNodeWoQty?.dispose();
    bloc?.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  GoodsIssueDetailItemAdditionalDetailState _getState() {
    return bloc.lastState ?? bloc.initialState;
  }

  void _done() {
    // if (_qtyController.text == "0" || _qtyController.text == "") {
    //   ValidateDialogWidget(
    //       context: context, message: "Qty harus lebih besar dari 0");
    //   return;
    // }
    // bloc.emitEvent(GoodsIssueDetailItemAdditionalDetailEventQty(
    //   qty: double.parse(_qtyController.text.replaceAll(new RegExp(','), '')),
    //   binAbs: int.parse(_binAbsController.text),
    //   binCode: _binCodeController.text,
    // ));

    Navigator.pop(context, _getState().data);
  }

  void _save() {
    if (_qtyController.text == "0" || _qtyController.text == "") {
      ValidateDialogWidget(
          context: context, message: "Issue Qty harus lebih besar dari 0");
      return;
    }
    // if (double.parse(_qtyController.text.replaceAll(new RegExp(','), '')) >
    //     double.parse(_qtyWoController.text.replaceAll(new RegExp(','), ''))) {
    //   ValidateDialogWidget(
    //       context: context,
    //       message: "Issue Qty tidak boleh melebihi Planned Qty");
    //   return;
    // }

    try {
      var newDetId = 0;
      if (int.parse(_detIdController.text) == 0) {
        newDetId = 0;
      } else {
        newDetId =
            int.parse(_detIdController.text); //_newData.items[_index].detId;
      }

      bloc.emitEvent(
        GoodsIssueDetailItemAdditionalDetailEventCreateAdditionalItemDetail(
          woId: _newData.woId,
          id: _newData.id,
          detId: newDetId,
          itemCode: _itemCodeController.text,
          plannedQty:
              double.parse(_qtyController.text.replaceAll(new RegExp(','), '')),
          whsCode: _whsCodeController.text,
          binAbs: int.parse(_binAbsController.text),
          binCode: _binCodeController.text,
        ),
      );
    } catch (ex) {
      ValidateDialogWidget(
          context: context, message: "Refresh : Unknown error $ex");
      return;
    }

    // Navigator.pop(context, _getState().newData);
  }

  Future _scanQR() async {
    if (["", null].contains(_itemCodeController.text)) {
      ValidateDialogWidget(
          context: context, message: "Item Code No harus di isi");
      return;
    }

    if (["", null].contains(_whsCodeController.text)) {
      ValidateDialogWidget(
          context: context, message: "Warehouse Code No harus di isi");
      return;
    }

    if (["", null].contains(_binCodeController.text)) {
      ValidateDialogWidget(
          context: context, message: "Bin Code No harus di isi");
      return;
    }

    if (_qtyWoController.text == "0" || _qtyWoController.text == "") {
      ValidateDialogWidget(
          context: context, message: "Planned Qty harus lebih besar dari 0");
      return;
    }

    // if (_qtyController.text == "0" || _qtyController.text == "") {
    //   ValidateDialogWidget(
    //       context: context, message: "Issue Qty harus lebih besar dari 0");
    //   return;
    // }

    var data = _getState().data;

    try {
      String qrResult = await BarcodeScanner.scan();
      for (var itemBatchs in _getState().data.batchs) {
        if (("${itemBatchs.batchNo}" == qrResult)) {
          ValidateDialogWidget(
              context: context, message: 'Batch Number sudah pernah di scan');
          return;
        }
      }

      bloc.emitEvent(
        GoodsIssueDetailItemAdditionalDetailEventScan(
          id: _data.id,
          detId: _data.detId,
          woId: int.parse(_woIdController.text),
          woLineNo: int.parse(_woLineNoController.text),
          qrResult: qrResult,
          data: data,
        ),
      );

      //_newData.items[_index] = _data;

    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        ValidateDialogWidget(
            context: context, message: "Scan : Camera permition was denied");
        return;
      } else {
        ValidateDialogWidget(
            context: context, message: "Scan : Unknown error $ex");
        return;
      }
    } on FormatException {
      // ValidateDialogWidget(
      //     context: context,
      //     message: "Scan : You press back button before scan");
      return;
    } catch (ex) {
      ValidateDialogWidget(
          context: context, message: "Scan : Unknown error $ex");
      return;
    }
  }

  void _showScanNewItemDetail(String qrCode) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var data = _getState().data;
      if (data != null) {
        // bloc.emitEvent(GoodsIssueDetailEventNormal());
        Future<ItemBatch> itemBatchs = Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                GoodsIssueDetailScanDetailPage(data.batchs[0]),
          ),
        );

        itemBatchs.then((ItemBatch itemBatchs) {
          if (itemBatchs != null) {
            // bloc.emitEvent(GoodsIssueDetailEventItemAdd(
            //   item: item,
            // ));
          }
        });
      }
    });
  }

  Future _refreshDetail() async {
    if (_qtyController.text == "0" || _qtyController.text == "") {
      ValidateDialogWidget(
          context: context, message: "Qty harus lebih besar dari 0");
      return;
    }
    if (double.parse(_qtyController.text.replaceAll(new RegExp(','), '')) >
        double.parse(_qtyWoController.text.replaceAll(new RegExp(','), ''))) {
      ValidateDialogWidget(
          context: context,
          message: "Issue Qty tidak boleh melebihi Planned Qty");
      return;
    }

    try {
      bloc.emitEvent(GoodsIssueDetailItemAdditionalDetailEventQty(
        qty: double.parse(_qtyController.text.replaceAll(new RegExp(','), '')),
        binAbs: int.parse(_binAbsController.text),
        binCode: _binCodeController.text,
      ));

      bloc.emitEvent(
        GoodsIssueDetailItemAdditionalDetailEventRefreshDetailAdditional(
          id: _data.id,
          detId: _data.detId,
          qtyItem:
              double.parse(_qtyController.text.replaceAll(new RegExp(','), '')),
          newDataItem: _data,
        ),
      );
    } catch (ex) {
      ValidateDialogWidget(
          context: context, message: "Refresh : Unknown error $ex");
      return;
    }
  }

  Future _setIssueQtyDetail() async {}

  Widget _showCircularProgress() {
    var state = bloc.lastState ?? bloc.initialState;
    if (state.isBusy) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  // Show Dialog Button
  showAlertDialogSave(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        Navigator.of(context).pop();
        // _refreshDetail();
        _save();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Perhatian !!!"),
      content: Text(
          "Apakah anda yakin simpan document? Jika menyimpan dokumen ini akan otomatis mengambil Batch Number secara FIFO"),
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

  @override
  Widget build(BuildContext context) {
    var items = _getState().data;
    // if (_newData.items[_index].batchs.length > _getState().data.batchs.length) {
    //   items = _newData.items[_index];
    // } else {
    //   items = _getState().data;
    // }
    return BlocEventStateBuilder<GoodsIssueDetailItemAdditionalDetailState>(
        bloc: bloc,
        builder: (BuildContext context,
            GoodsIssueDetailItemAdditionalDetailState state) {
          return WillPopScope(
            onWillPop: () async {
              if (_newData.sapGoodsIssueId == 0) {
                if (await confirm(context)) {
                  // items.id = _newData.id;
                  // Navigator.pop(context, items);
                  _done();
                  // _refreshDetail();
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
                  title: Text("Item Additional Detail"),
                  backgroundColor: bgBlue,
                  bottom: PreferredSize(
                      child: Container(
                        color: bgOrange,
                        height: 5.0,
                      ),
                      preferredSize: Size.fromHeight(5.0)),
                  actions: <Widget>[
                    _newData.sapGoodsIssueId == 0
                        ? Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  child: const Text('Save'),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.elliptical(15, 15)),
                                  ),
                                  onPressed: () {
                                    showAlertDialogSave(context);
                                  },
                                ),
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
                body: SingleChildScrollView(
                  child: _buildForm(),
                ),
                floatingActionButton:
                    // _newData.items[_index].valuationMethod !=
                    //         'FIFO' //_data.id != 0
                    //     ?
                    _newData.sapGoodsIssueId == 0
                        ? FloatingActionButton.extended(
                            icon: Icon(Icons.camera_alt),
                            backgroundColor: bgOrange,
                            label: Text("Scan"),
                            onPressed: () {
                              // do something here
                              _scanQR();
                              //_showScanNewItemDetail('');
                            },
                          )
                        : null,
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
              ),
            ),
          );
        });
  }

  Widget _buildForm() {
    var dataItem = _getState().data;
    if (dataItem != null) {
      _idController.text = dataItem.id.toString();
      _detIdController.text = dataItem.detId.toString();
      _woIdController.text = dataItem.woId.toString();
      _woLineNoController.text = dataItem.woLineNo.toString();
      _itemCodeController.text = dataItem.itemCode;
      _itemNameController.text = dataItem.itemName;
      _uomController.text = dataItem.uom;
      _whsCodeController.text = dataItem.whsCode;
      _whsNameController.text = dataItem.whsName;
      _binAbsController.text = dataItem.binAbs.toString();
      _binCodeController.text = dataItem.binCode;

      _toWhsCodeController.text = dataItem.toWhsCode;
      _toWhsNameController.text = dataItem.toWhsName;
      _toBinAbsController.text = dataItem.toBinAbs.toString();
      _toBinCodeController.text = dataItem.toBinCode;

      // _qtyWoController.text = data.woQty.toString();
      // _qtyController.text = NumberFormat("###,###.####")
      // .format(double.parse(dataItem.qty.toString()));

      // if (data != null) {
      //   if (data.batchs.length > 0) {
      //     double sumIssueQty = 0;

      //     for (var itemBatchs in data.batchs) {
      //       sumIssueQty += itemBatchs.quantity;
      //     }
      //     _data.qty = sumIssueQty;
      //     _qtyController.text = NumberFormat("###,###.####")
      //         .format(double.parse(data.qty.toString()));
      //     data.qty = double.parse(_qtyController.text);
      //   } else {
      //     _qtyController.text = "0";
      //   }
      // }

      if (dataItem.qty != 0) {
        if (_qtyController.text == "") {
          _qtyController.text = NumberFormat("###,###.####")
              .format(double.parse(dataItem.qty.toString()));
        } else {
          if (dataItem.qty ==
              double.parse(
                  _qtyController.text.replaceAll(new RegExp(','), ''))) {
            _qtyController.text = NumberFormat("###,###.####")
                .format(double.parse(dataItem.qty.toString()));
          }
        }
      } else {
        if (dataItem.batchs.length > 0) {
          double sumIssueQty = 0;

          for (var itemBatchs in dataItem.batchs) {
            sumIssueQty += itemBatchs.quantity;
          }
          _data.qty = sumIssueQty;
          _qtyController.text = NumberFormat("###,###.####")
              .format(double.parse(dataItem.qty.toString()));
          dataItem.qty = double.parse(_qtyController.text);
        } else {
          _qtyController.text = "0";
        }
      }

      if (dataItem.woQty != 0) {
        if (_qtyWoController.text == "") {
          _qtyWoController.text = NumberFormat("###,###.####")
              .format(double.parse(dataItem.woQty.toString()));
        } else {
          if (dataItem.woQty ==
              double.parse(
                  _qtyWoController.text.replaceAll(new RegExp(','), ''))) {
            _qtyWoController.text = NumberFormat("###,###.####")
                .format(double.parse(dataItem.woQty.toString()));
          } else {
            _qtyWoController.text = NumberFormat("###,###.####")
                .format(double.parse(dataItem.qty.toString()));
          }
        }
      }

      // if (_data.qty != 0) {
      //   if (_qtyController.text == "") {
      //     _qtyController.text = NumberFormat("###,###.##")
      //         .format(double.parse(data.qty.toString()));
      //   } else {
      //     if (_data.qty ==
      //         double.parse(_qtyController.text.replaceAll(new RegExp(','), ''))) {
      //       _qtyController.text = NumberFormat("###,###.##")
      //           .format(double.parse(data.qty.toString()));
      //     }
      //   }
      // }
    }

    //Additional Item
    if (_newData != null && dataItem == null) {
      _idController.text = _newData.id.toString();
      _detIdController.text = "0";
      _woIdController.text = _newData.woId.toString();
      _woLineNoController.text = "-1";
    }

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            // height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: bgGradientPageWhite,
            ),
            padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // dataItem == null
                //     ?
                FlatButton(
                  padding: EdgeInsets.only(top: 0),
                  onPressed: () {
                    if (dataItem == null) {
                      Future<cflItem.Data> chooseItem = Navigator.push(
                          context,
                          MaterialPageRoute<cflItem.Data>(
                              builder: (BuildContext context) =>
                                  CflItemPage()));

                      chooseItem.then((cflItem.Data getItem) {
                        if (getItem != null) {
                          _itemCodeController.text = getItem.itemCode;
                          _itemNameController.text = getItem.itemName;
                          _uomController.text = getItem.uom;
                        }
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 5, top: 5),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: (dataItem == null)
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
                                    // Text(_uomController.text),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        (dataItem == null)
                            ? Icon(
                                Icons.keyboard_arrow_right,
                              )
                            : Container(width: 0, height: 0),
                      ],
                    ),
                  ),
                ),
                // : TextFormField(
                //     controller: _itemCodeController,
                //     enabled: false,
                //     decoration: InputDecoration(
                //         labelText: "Item Code",
                //         contentPadding: new EdgeInsets.symmetric(
                //             vertical: 15.0, horizontal: 10.0),
                //         border: new OutlineInputBorder(
                //             borderRadius: new BorderRadius.circular(10.0))),
                //   ),

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
                // TextFormField(
                //   controller: _whsCodeController,
                //   enabled: false,
                //   decoration: InputDecoration(
                //       labelText: "From Warehouse Code",
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
                //       labelText: "From Warehouse Name",
                //       contentPadding: new EdgeInsets.symmetric(
                //           vertical: 15.0, horizontal: 10.0),
                //       border: new OutlineInputBorder(
                //           borderRadius: new BorderRadius.circular(10.0))),
                // ),
                FlatButton(
                  padding: EdgeInsets.only(top: 5),
                  onPressed: () {
                    if (dataItem == null) {
                      Future<cflWarehouse.Data> whs = Navigator.push(
                          context,
                          MaterialPageRoute<cflWarehouse.Data>(
                              builder: (BuildContext context) =>
                                  CflWarehousePage(globalBloc.branchId)));

                      whs.then((cflWarehouse.Data whs) {
                        setState(() {
                          if (whs != null) {
                            if (dataItem == null) {
                              _whsCodeController.text = whs.whsCode;
                              _whsNameController.text = whs.whsName;
                              // _fromAbsEntryController.text =
                              //     whs.absEntry.toString();
                              // _fromBinCodeController.text = whs.binCode;
                            } else {
                              // _getState().data.branchId = whs.branchId;
                              // _getState().data.fromBranchName = whs.branchName;
                              _getState().data.whsCode = whs.whsCode;
                              _getState().data.whsName = whs.whsName;
                              // _getState().data.fromAbsEntry = whs.absEntry;
                              // _getState().data.fromBinCode = whs.binCode;
                            }
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
                            color: (dataItem == null)
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
                        (dataItem == null)
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
                    if (dataItem == null) {
                      Future<cflBatchLocation.Data> bin = Navigator.push(
                          context,
                          MaterialPageRoute<cflBatchLocation.Data>(
                              builder: (BuildContext context) =>
                                  CflBatchLocationPage(_whsCodeController.text,
                                      "-", _itemCodeController.text)));

                      bin.then((cflBatchLocation.Data bin) {
                        setState(() {
                          if (bin != null) {
                            // _getState().data.binAbs = bin.absEntry;
                            // _getState().data.binCode = bin.binCode;
                            // _getState().data.availableQty =
                            // bin.availableQty;
                            _binAbsController.text = bin.absEntry.toString();
                            _binCodeController.text = bin.binCode;
                            _availableQtyController.text =
                                bin.availableQty.toString();
                            _uomController.text = bin.uom;
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
                            color:
                                (dataItem == null) ? bgBlue : Colors.grey[400]),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "From Bin Location",
                                style: TextStyle(color: bgBlue, fontSize: 12.0),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.only(left: 5),
                                title: Text(_binCodeController.text),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    _availableQtyController.text != ""
                                        ? Text("Stock Quantity : " +
                                            _availableQtyController.text +
                                            " " +
                                            _uomController.text)
                                        : Text(""),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        (dataItem == null)
                            ? Icon(
                                Icons.keyboard_arrow_right,
                              )
                            : Container(width: 0, height: 0),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                _newData.sapGoodsIssueId == 0
                    ? TextField(
                        autofocus: false,
                        enabled: false, //dataItem == null ? false :
                        textInputAction: TextInputAction.done,
                        controller: _qtyWoController,
                        focusNode: _focusNodeWoQty,
                        onEditingComplete: () {
                          setState(() {
                            String newValue = NumberFormat("###,###.####")
                                .format(double.parse(_qtyController.text
                                    .replaceAll(new RegExp(','), '')
                                    .replaceAll(new RegExp('-'), '')
                                    .replaceAll(new RegExp(' '), '')));
                            _qtyWoController.text = newValue;
                            _qtyWoController.selection =
                                TextSelection.collapsed(
                                    offset: newValue.length);
                          });
                          _focusNodeWoQty.unfocus();
                          // _refreshDetail();
                        },
                        inputFormatters: [
                          DecimalTextInputFormatter(decimalRange: 4)
                        ],
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          labelText: "Planned Qty",
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: new BorderRadius.circular(10.0)),
                        ))
                    : TextField(
                        controller: _qtyWoController,
                        enabled: false,
                        decoration: InputDecoration(
                            labelText: "Planned Qty",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0))),
                      ),
                Padding(padding: EdgeInsets.only(top: 10)),
                // Padding(padding: EdgeInsets.only(top: 10)),
                // TextField(
                //   controller: _qtyWoController,
                //   enabled: false,
                //   decoration: InputDecoration(
                //       labelText: "Planned Qty",
                //       contentPadding: new EdgeInsets.symmetric(
                //           vertical: 15.0, horizontal: 10.0),
                //       border: new OutlineInputBorder(
                //           borderRadius: new BorderRadius.circular(10.0))),
                // ),
                _newData.sapGoodsIssueId == 0
                    ? TextField(
                        autofocus: false,
                        textInputAction: TextInputAction.done,
                        controller: _qtyController,
                        focusNode: _focusNode,
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
                          // _setPlannedQtyDetail();
                          // _save();
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
                        decoration: InputDecoration(
                            labelText: "Issue Qty",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0))),
                      ),
                Padding(padding: EdgeInsets.only(top: 10)),
                // TextField(
                //   controller: _qtyController,
                //   enabled: false,
                //   decoration: InputDecoration(
                //       labelText: "Issue Qty",
                //       contentPadding: new EdgeInsets.symmetric(
                //           vertical: 15.0, horizontal: 10.0),
                //       border: new OutlineInputBorder(
                //           borderRadius: new BorderRadius.circular(10.0))),
                // ),

                // TextFormField(
                //   controller: _uomController,
                //   enabled: false,
                //   decoration: InputDecoration(
                //       labelText: "UoM",
                //       contentPadding: new EdgeInsets.symmetric(
                //           vertical: 15.0, horizontal: 10.0),
                //       border: new OutlineInputBorder(
                //           borderRadius: new BorderRadius.circular(10.0))),
                // ),
              ],
            ),
          ),
          _showCircularProgress(),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: dataItem == null
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
              child: (dataItem != null)
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
          ),
        ]);
  }

  void _showItemDetail(int itemIndex) {
    final itemBatchs = _getState().data.batchs;
    Future<ItemBatch> itemBatch = Navigator.push(
      context,
      MaterialPageRoute<ItemBatch>(
        builder: (BuildContext context) =>
            GoodsIssueDetailScanDetailPage(itemBatchs[itemIndex]),
      ),
    );

    itemBatch.then(
      (ItemBatch itemBatch) {
        if (itemBatch != null) {
          bloc.emitEvent(
            GoodsIssueDetailItemAdditionalDetailEventItemUpdate(
              itemBatch: itemBatch,
              itemIndex: itemIndex,
            ),
          );
        }
      },
    );
  }

  Widget _rowDetail(int index, Item newData) {
    return newData.batchs[index].batchNo != null
        ? Container(
            margin: new EdgeInsets.symmetric(horizontal: 0.0, vertical: 1.0),
            decoration: BoxDecoration(
                color: Colors.grey[400].withOpacity(0.5),
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.grey[500]),
                    left: BorderSide(width: 5, color: Colors.blue))),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: ListTile(
                title: Text("Batch No. : ${newData.batchs[index].batchNo}"),
                subtitle: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Text("Batch No. : ${_data.batchs[index].batchNo}"),
                    Text(
                        "Qty Batch : ${NumberFormat("#,###.##").format(newData.batchs[index].quantity)}"),
                  ],
                ),
                trailing: _newData.sapGoodsIssueId == 0
                    ? IconButton(
                        color: Colors.black,
                        icon: Icon(Icons.edit),
                        iconSize: 30.0,
                        onPressed: () {
                          _showItemDetail(index);
                        },
                      )
                    : null,
              ),
            ),
          )
        : null;
  }

  Widget _buildList() {
    var state = bloc.lastState ?? bloc.initialState;
    final data = state.data;
    if (data != null) {
      return ListView.builder(
        controller: _scrollController,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: data.batchs.length,
        itemBuilder: (contex, index) {
          if (data.batchs[index].batchNo != null &&
              _newData.sapGoodsIssueId == 0) {
            //return _rowDetail(index);
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                if (_getState().data.batchs[index].detDetId != 0) {
                  bloc.emitEvent(
                    GoodsIssueDetailItemAdditionalDetailEventRemoveContent(
                      id: _getState().data.id,
                      detId: _getState().data.detId,
                      detDetId: data.batchs[index].detDetId,
                    ),
                  );
                } else if (_getState().data.batchs[index].detDetId == 0) {
                  setState(() {
                    _getState().data.batchs.removeAt(index);
                  });
                  return null;
                }
              },
              background: Container(
                  color: Colors.red,
                  child: Align(
                      child: Text('Delete',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold)))),
              child: _rowDetail(index, data),
            );
          } else {
            return _rowDetail(index, data);
          }
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
