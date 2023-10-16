import 'dart:ui';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:wins_app/bloc_widgets/bloc_state_builder.dart';
import 'package:wins_app/blocs/global_bloc.dart';
import 'package:wins_app/blocs/item/detail/item_detail_bloc.dart';
import 'package:wins_app/blocs/item/detail/item_detail_event.dart';
import 'package:wins_app/blocs/item/detail/item_detail_state.dart';
import 'package:wins_app/models/item_detail_scan_response.dart';
import 'package:wins_app/models/item_detail_scan_serial_batch_number_response.dart';
import 'package:wins_app/pages/cfl/cfl_item_page.dart';
import 'package:wins_app/pages/cfl/cfl_warehouse_page.dart';
import 'package:wins_app/widgets/set_colors.dart';
import 'package:wins_app/widgets/validate_dialog_widget.dart';
import 'package:intl/intl.dart';
import 'package:wins_app/pages/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:wins_app/models/cfl_warehouse_response.dart' as cflWarehouse;
import 'package:wins_app/models/cfl_item_response.dart' as cflItem;
import 'package:wins_app/models/cfl_item_response.dart' as cflItemSnB;

class CheckDataPage extends StatefulWidget {
  @override
  _CheckDataPageState createState() => _CheckDataPageState();
}

class _CheckDataPageState extends State<CheckDataPage>
    with SingleTickerProviderStateMixin {
  ItemDetailBloc bloc = ItemDetailBloc();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController;
  TabController _tabController;

  final _itemCodeController = TextEditingController();
  final _itemNameController = TextEditingController();
  final _batchController = TextEditingController();
  final _lengthController = TextEditingController();
  final _length2Controller = TextEditingController();
  final _widthController = TextEditingController();
  final _weightController = TextEditingController();
  final _typeController = TextEditingController();
  final _uomController = TextEditingController();
  final _stockController = TextEditingController();

//SnB
  final _itemCodeSnBController = TextEditingController();
  final _itemNameSnBController = TextEditingController();
  final _serialBatchNumberController = TextEditingController();
  final _lengthSnBController = TextEditingController();
  final _length2SnBController = TextEditingController();
  final _widthSnBController = TextEditingController();
  final _weightSnBController = TextEditingController();
  final _typeSnBController = TextEditingController();
  final _uomSnBController = TextEditingController();
  final _stockSnBController = TextEditingController();
  final _whsCodeSnBController = TextEditingController();
  final _whsNameSnBController = TextEditingController();
  final _player = AudioCache();

  DateTime transDate; // = DateTime.now();

  @override
  void initState() {
    super.initState();

    // Tabs
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabIndex);
  }

  void _handleTabIndex() {
    setState(() {});
  }

  @override
  void dispose() {
    _itemCodeController?.dispose();
    _itemNameController?.dispose();
    _batchController?.dispose();
    _lengthController?.dispose();
    _length2Controller?.dispose();
    _widthController?.dispose();
    _weightController?.dispose();
    _typeController?.dispose();
    _uomController?.dispose();
    _stockController?.dispose();

    _itemCodeSnBController?.dispose();
    _itemNameSnBController?.dispose();
    _serialBatchNumberController?.dispose();
    _lengthSnBController?.dispose();
    _length2SnBController?.dispose();
    _widthSnBController?.dispose();
    _weightSnBController?.dispose();
    _typeSnBController?.dispose();
    _uomSnBController?.dispose();
    _stockSnBController?.dispose();
    _whsCodeSnBController?.dispose();
    _whsNameSnBController?.dispose();

    bloc?.dispose();

    // tabs
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();

    super.dispose();
  }

  void _errorMessage() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String errorMessage = (bloc.lastState ?? bloc.initialState).errorMessage;
      if ((errorMessage != null) && (errorMessage != "")) {
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error : '),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text("${errorMessage}"),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    bloc.emitEvent(ItemDetailEventNormal());
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  void _successMessage() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String successMessage =
          (bloc.lastState ?? bloc.initialState).succesMessage;
      if ((successMessage != null) && (successMessage != "")) {
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success : '),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text("${successMessage}"),
                  ],
                ),
              ),
            );
          },
        );
      }
    });
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: Text("Check Data"),
      backgroundColor: Colors.blue[900],
      bottom: PreferredSize(
          child: Container(
            color: Colors.yellow[900],
            height: 5.0,
          ),
          preferredSize: Size.fromHeight(5.0)),
    );
  }

  ItemDetailState _getState() {
    return bloc.lastState ?? bloc.initialState;
  }

  BuildContext _context;

  Future _scanQR() async {
    var data = _getState().data;

    try {
      String qrResult = await BarcodeScanner.scan();

      bloc.emitEvent(ItemDetailEventScan(
        itemCode: _itemCodeController.text,
        qrResult: qrResult,
        data: data,
      ));

      _player.play(
        'sounds/store-scanner-beep-sound-effect.mp3',
        volume: 10.0,
      );
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
      ValidateDialogWidget(
          context: context,
          message: "Scan : You press back button before scan");
      return;
    } catch (ex) {
      ValidateDialogWidget(
          context: context, message: "Scan : Unknown error $ex");
      return;
    }
  }

  Future _scanSnB() async {
    var dataSnB = _getState().dataSnB;

    // if (["", null].contains(_whsCodeSnBController.text)) {
    //   ValidateDialogWidget(
    //       context: context, message: "Silahkan pilih Warehouse");
    //   return;
    // }

    try {
      String qrResult = await BarcodeScanner.scan();

      bloc.emitEvent(ItemSnBDetailEventScan(
        whsCode: _whsCodeSnBController.text,
        itemCode: _itemCodeSnBController.text,
        qrResult: qrResult,
        dataSnB: dataSnB,
      ));

      _player.play(
        'sounds/store-scanner-beep-sound-effect.mp3',
        volume: 10.0,
      );
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
      ValidateDialogWidget(
          context: context,
          message: "Scan : You press back button before scan");
      return;
    } catch (ex) {
      ValidateDialogWidget(
          context: context, message: "Scan : Unknown error $ex");
      return;
    }
  }

  Future _deleteData() async {
    var data = _getState().data;
    _itemCodeController.clear();
    _itemNameController.clear();
    _batchController.clear();
    _lengthController.clear();
    _length2Controller.clear();
    _widthController.clear();
    _weightController.clear();
    _stockController.clear();
    _typeController.clear();
    _uomController.clear();

    try {
      bloc.emitEvent(
        ItemDetailEventClear(data: data),
      );
    } catch (ex) {
      ValidateDialogWidget(
          context: context, message: "Delete : Unknown error $ex");
      return;
    }
  }

  Future _deleteDataSnB() async {
    var dataSnB = _getState().dataSnB;

    _itemCodeSnBController.clear();
    _itemNameSnBController.clear();
    _whsCodeSnBController.clear();
    _whsNameSnBController.clear();
    _serialBatchNumberController.clear();
    _lengthSnBController.clear();
    _length2SnBController.clear();
    _widthSnBController.clear();
    _weightSnBController.clear();
    _stockSnBController.clear();
    _typeSnBController.clear();
    _uomSnBController.clear();

    try {
      bloc.emitEvent(
        ItemDetailEventClearSnB(dataSnB: dataSnB),
      );
    } catch (ex) {
      ValidateDialogWidget(
          context: context, message: "Delete : Unknown error $ex");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return BlocEventStateBuilder<ItemDetailState>(
        bloc: bloc,
        builder: (BuildContext context, ItemDetailState state) {
          return SafeArea(
            child: Scaffold(
              key: _scaffoldKey,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: Container(
                  color: bgBlue,
                  child: TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(
                        text: "Item Code",
                      ),
                      Tab(
                        text: "SN / Batch Number",
                      ),
                    ],
                  ),
                ),
              ),
              body: TabBarView(
                controller: _tabController,
                children: [
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/579.jpg"),
                            fit: BoxFit.cover,
                            repeat: ImageRepeat.noRepeat),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                        child: Container(
                          decoration: new BoxDecoration(
                              color: Colors.white.withOpacity(0.8)),
                          child: Stack(children: <Widget>[
                            SingleChildScrollView(
                              padding: EdgeInsets.all(0.0),
                              child: _buildForm(),
                            ),
                            _showCircularProgress(),
                          ]),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/579.jpg"),
                            fit: BoxFit.cover,
                            repeat: ImageRepeat.noRepeat),
                      ),
                      child: Container(
                        decoration: new BoxDecoration(
                            color: Colors.white.withOpacity(0.8)),
                        child: Stack(children: <Widget>[
                          SingleChildScrollView(
                            padding: EdgeInsets.all(0.0),
                            child: _buildFormSnB(),
                          ),
                          _showCircularProgress(),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
              floatingActionButton: _bottomButtons(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              // floatingActionButton: FloatingActionButton.extended(
              //   icon: Icon(Icons.camera_alt),
              //   backgroundColor: Colors.orange[700],
              //   label: Text("Scan"),
              //   onPressed: () {
              //     _scanQR();
              //   },
              // ),
              // floatingActionButtonLocation:
              //     FloatingActionButtonLocation.endFloat,
            ),
          );
        });
  }

  Widget _bottomButtons() {
    return _tabController.index == 0
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                ),
                child: GestureDetector(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Container(
                        color: Colors.green,
                        width: 100,
                        height: 45,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cached,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Clear",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )),
                  onTapDown: (TapUpDetails) {
                    _deleteData();
                  },
                ),
              ),
              GestureDetector(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Container(
                      color: bgOrange,
                      width: 100,
                      height: 45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Scan",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
                onTapDown: (TapUpDetails) {
                  _scanQR();
                },
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                ),
                child: GestureDetector(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Container(
                        color: Colors.green,
                        width: 100,
                        height: 45,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cached,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Clear",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )),
                  onTapDown: (TapUpDetails) {
                    _deleteDataSnB();
                  },
                ),
              ),
              GestureDetector(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Container(
                      color: bgOrange,
                      width: 100,
                      height: 45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Scan",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
                onTapDown: (TapUpDetails) {
                  _scanSnB();
                },
              ),
            ],
          );
  }

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

  Widget _buildForm() {
    _errorMessage();
    _successMessage();
    var data = _getState().data;
    _stockController.text = "";
    if (data != null && _tabController.index == 0) {
      _itemCodeController.text = data.itemCode;
      _itemNameController.text = data.itemName;
      _batchController.text = data.distNumber;
      _lengthController.text = data.length == null
          ? null
          : NumberFormat("#,###.##").format(data.length).toString();

      _length2Controller.text = data.length2 == null
          ? null
          : NumberFormat("#,###.##").format(data.length2).toString();

      _widthController.text = data.width == null
          ? null
          : NumberFormat("#,###.##").format(data.width).toString();

      _weightController.text = data.weight == null
          ? null
          : NumberFormat("#,###.##").format(data.weight).toString();

      _stockController.text = data.totalStock == null
          ? null
          : NumberFormat("#,###.##").format(data.totalStock).toString();

      _typeController.text = data.itemType;
      _uomController.text = data.uom;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Container(
                    color: Colors.transparent,
                    height: 30,
                    child: Text(
                      "Stock Item Master Data",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                    ),
                    FlatButton(
                      padding: EdgeInsets.only(top: 0),
                      onPressed: () {
                        // if (data == null) {
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

                            data.itemCode = getItem.itemCode;
                            data.itemName = getItem.itemName;
                            data.uom = getItem.uom;
                            data.distNumber = "";
                            data.width = 0.0;
                            data.length = 0.0;
                            data.length2 = 0.0;
                            data.weight = 0.0;
                            data.itemType = "";
                            data.totalStock = 0.0;
                            data.details.clear();
                          }
                        });
                        // }
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 5, top: 5),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: (data == null)
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
                                    "Item Code",
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 12.0),
                                  ),
                                  ListTile(
                                    contentPadding: EdgeInsets.only(left: 5),
                                    title: Text(_itemCodeController.text),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(_itemNameController.text),
                                        // Text(_uomController.text),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // TextFormField(
                    //     controller: _itemCodeController,
                    //     enabled: false,
                    //     decoration: InputDecoration(
                    //       hintText: "Item code",
                    //       labelText: "Item code",
                    //       contentPadding: new EdgeInsets.symmetric(
                    //           vertical: 15.0, horizontal: 10.0),
                    //       border: new OutlineInputBorder(
                    //           borderRadius: new BorderRadius.circular(10.0)),
                    //     )),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                    ),
                    // TextFormField(
                    //     controller: _itemNameController,
                    //     enabled: false,
                    //     decoration: InputDecoration(
                    //         hintText: "Item name",
                    //         labelText: "Item name",
                    //         contentPadding: new EdgeInsets.symmetric(
                    //             vertical: 15.0, horizontal: 10.0),
                    //         border: new OutlineInputBorder(
                    //             borderRadius:
                    //                 new BorderRadius.circular(10.0)))),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                    ),
                    TextFormField(
                        controller: _batchController,
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: "SN / Batch No.",
                            labelText: "SN / Batch No.",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: new OutlineInputBorder(
                                borderRadius:
                                    new BorderRadius.circular(10.0)))),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                    ),
                    TextFormField(
                        controller: _widthController,
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: "Width",
                            labelText: "Width",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: new OutlineInputBorder(
                                borderRadius:
                                    new BorderRadius.circular(10.0)))),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                    ),
                    TextFormField(
                        controller: _lengthController,
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: "Length",
                            labelText: "Length",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: new OutlineInputBorder(
                                borderRadius:
                                    new BorderRadius.circular(10.0)))),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                    ),
                    TextFormField(
                        controller: _length2Controller,
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: "Length Label",
                            labelText: "Length Label",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: new OutlineInputBorder(
                                borderRadius:
                                    new BorderRadius.circular(10.0)))),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                    ),
                    TextFormField(
                        controller: _weightController,
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: "Weight",
                            labelText: "Weight",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: new OutlineInputBorder(
                                borderRadius:
                                    new BorderRadius.circular(10.0)))),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                    ),
                    TextFormField(
                        controller: _typeController,
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: "Type",
                            labelText: "Type",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: new OutlineInputBorder(
                                borderRadius:
                                    new BorderRadius.circular(10.0)))),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                    ),
                    TextFormField(
                        controller: _stockController,
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: "Stock",
                            labelText: "Stock",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: new OutlineInputBorder(
                                borderRadius:
                                    new BorderRadius.circular(10.0)))),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                    ),
                    TextFormField(
                        controller: _uomController,
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: "Uom",
                            labelText: "Uom",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: new OutlineInputBorder(
                                borderRadius:
                                    new BorderRadius.circular(10.0)))),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.blue,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Break Stock"),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                  //color: Colors.brown,
                  child: ((data != null) ? data.details.length : 0) > 0 &&
                          _tabController.index == 0
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
                height: 60,
              ),
            ]),
      ),
    );
  }

  Widget _buildFormSnB() {
    _errorMessage();
    _successMessage();
    var dataSnB = _getState().dataSnB;
    _stockSnBController.text = "";
    if (dataSnB != null && _tabController.index == 1) {
      _itemCodeSnBController.text = dataSnB.itemCode;
      _itemNameSnBController.text = dataSnB.itemName;
      _serialBatchNumberController.text = dataSnB.distNumber;
      _lengthSnBController.text = dataSnB.length == null
          ? null
          : NumberFormat("#,###.##").format(dataSnB.length).toString();

      _length2SnBController.text = dataSnB.length2 == null
          ? null
          : NumberFormat("#,###.##").format(dataSnB.length2).toString();

      _widthSnBController.text = dataSnB.width == null
          ? null
          : NumberFormat("#,###.##").format(dataSnB.width).toString();

      _weightSnBController.text = dataSnB.weight == null
          ? null
          : NumberFormat("#,###.##").format(dataSnB.weight).toString();

      _stockSnBController.text = dataSnB.totalStock == null
          ? null
          : NumberFormat("#,###.##").format(dataSnB.totalStock).toString();

      _typeSnBController.text = dataSnB.itemType;
      _uomSnBController.text = dataSnB.uom;
      _whsCodeSnBController.text = dataSnB.whsCode;
      _whsNameSnBController.text = dataSnB.whsName;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Container(
                    color: Colors.transparent,
                    height: 30,
                    child: Text(
                      "Stock SN / Batch Number",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FlatButton(
                      padding: EdgeInsets.only(top: 5),
                      onPressed: () {
                        Future<cflWarehouse.Data> whs = Navigator.push(
                            context,
                            MaterialPageRoute<cflWarehouse.Data>(
                                builder: (BuildContext context) =>
                                    CflWarehousePage(globalBloc.branchId)));

                        whs.then((cflWarehouse.Data whs) {
                          setState(() {
                            if (whs != null) {
                              _whsCodeSnBController.text = whs.whsCode;
                              _whsNameSnBController.text = whs.whsName;
                              dataSnB.whsCode = whs.whsCode;
                              dataSnB.whsName = whs.whsName;
                              dataSnB.itemCode = "";
                              dataSnB.itemName = "";
                              dataSnB.uom = "";
                              dataSnB.distNumber = "";
                              dataSnB.width = 0.0;
                              dataSnB.length = 0.0;
                              dataSnB.length2 = 0.0;
                              dataSnB.weight = 0.0;
                              dataSnB.itemType = "";
                              dataSnB.totalStock = 0.0;
                              dataSnB.details.clear();
                            }
                          });
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 5, top: 5),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Warehouse",
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 12.0),
                                  ),
                                  ListTile(
                                    contentPadding: EdgeInsets.only(left: 5),
                                    title: Text(_whsCodeSnBController.text),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(_whsNameSnBController.text),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                    ),
                    FlatButton(
                      padding: EdgeInsets.only(top: 0),
                      onPressed: () {
                        // if (dataSnB == null) {
                        Future<cflItemSnB.Data> chooseItem = Navigator.push(
                            context,
                            MaterialPageRoute<cflItemSnB.Data>(
                                builder: (BuildContext context) =>
                                    CflItemPage()));

                        chooseItem.then((cflItemSnB.Data getItem) {
                          if (getItem != null) {
                            _itemCodeSnBController.text = getItem.itemCode;
                            _itemNameSnBController.text = getItem.itemName;
                            _uomSnBController.text = getItem.uom;
                            dataSnB.itemCode = getItem.itemCode;
                            dataSnB.itemName = getItem.itemName;
                            dataSnB.uom = getItem.uom;
                            dataSnB.distNumber = "";
                            dataSnB.width = 0.0;
                            dataSnB.length = 0.0;
                            dataSnB.length2 = 0.0;
                            dataSnB.weight = 0.0;
                            dataSnB.itemType = "";
                            dataSnB.totalStock = 0.0;
                            dataSnB.details.clear();
                          }
                        });
                        // }
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 5, top: 5),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: (dataSnB == null)
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
                                    "Item Code",
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 12.0),
                                  ),
                                  ListTile(
                                    contentPadding: EdgeInsets.only(left: 5),
                                    title: Text(_itemCodeSnBController.text),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(_itemNameSnBController.text),
                                        // Text(_uomController.text),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                            )
                          ],
                        ),
                      ),
                    ),
                    // TextFormField(
                    //     controller: _itemCodeSnBController,
                    //     enabled: false,
                    //     decoration: InputDecoration(
                    //       hintText: "Item code",
                    //       labelText: "Item code",
                    //       contentPadding: new EdgeInsets.symmetric(
                    //           vertical: 15.0, horizontal: 10.0),
                    //       border: new OutlineInputBorder(
                    //           borderRadius: new BorderRadius.circular(10.0)),
                    //     )),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                    ),
                    TextFormField(
                        controller: _itemNameSnBController,
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: "Item name",
                            labelText: "Item name",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: new OutlineInputBorder(
                                borderRadius:
                                    new BorderRadius.circular(10.0)))),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                    ),
                    TextFormField(
                        controller: _serialBatchNumberController,
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: "SN / Batch No.",
                            labelText: "SN / Batch No.",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: new OutlineInputBorder(
                                borderRadius:
                                    new BorderRadius.circular(10.0)))),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                    ),
                    TextFormField(
                        controller: _widthSnBController,
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: "Width",
                            labelText: "Width",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: new OutlineInputBorder(
                                borderRadius:
                                    new BorderRadius.circular(10.0)))),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                    ),
                    TextFormField(
                        controller: _lengthSnBController,
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: "Length",
                            labelText: "Length",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: new OutlineInputBorder(
                                borderRadius:
                                    new BorderRadius.circular(10.0)))),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                    ),
                    TextFormField(
                        controller: _length2SnBController,
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: "Length Label",
                            labelText: "Length Label",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: new OutlineInputBorder(
                                borderRadius:
                                    new BorderRadius.circular(10.0)))),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                    ),
                    TextFormField(
                        controller: _weightSnBController,
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: "Weight",
                            labelText: "Weight",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: new OutlineInputBorder(
                                borderRadius:
                                    new BorderRadius.circular(10.0)))),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                    ),
                    TextFormField(
                        controller: _typeSnBController,
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: "Type",
                            labelText: "Type",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: new OutlineInputBorder(
                                borderRadius:
                                    new BorderRadius.circular(10.0)))),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                    ),
                    TextFormField(
                        controller: _stockSnBController,
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: "Stock",
                            labelText: "Stock",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: new OutlineInputBorder(
                                borderRadius:
                                    new BorderRadius.circular(10.0)))),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                    ),
                    TextFormField(
                        controller: _uomSnBController,
                        enabled: false,
                        decoration: InputDecoration(
                            hintText: "Uom",
                            labelText: "Uom",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: new OutlineInputBorder(
                                borderRadius:
                                    new BorderRadius.circular(10.0)))),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.blue,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Break Stock"),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                  //color: Colors.brown,
                  child: ((dataSnB != null) ? dataSnB.details.length : 0) > 0 &&
                          _tabController.index == 1
                      ? _buildListSnB()
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
                height: 60,
              )
            ]),
      ),
    );
  }

  Widget _rowDetail(List<Item> data, int index) {
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
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${data[index].itemCode}" + " (" "${data[index].itemName}" ")",
                style: TextStyle(color: bgBlue),
              ),
              Text(
                "${data[index].whsName}" + " (" "${data[index].whsCode}" ")",
                style: TextStyle(color: bgOrange),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                  "Qty : ${NumberFormat("#,###.##").format(data[index].stock)} " +
                      "${data[index].uom}"),
              Text(
                  "Manufacture Date : ${data[index].mnfDate}".substring(0, 29)),
              Text("Receive Date : ${data[index].inDate}".substring(0, 25)),
              Text("Expired Date : ${data[index].expDate}".substring(0, 25)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _rowDetailSnB(List<ItemSnB> data, int index) {
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
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${data[index].itemCode}" + " (" "${data[index].itemName}" ")",
                style: TextStyle(color: bgBlue),
              ),
              Text(
                "${data[index].whsName}" + " (" "${data[index].whsCode}" ")",
                style: TextStyle(color: bgOrange),
              ),
              Text("Bin Code : " + "${data[index].binCode}"),
            ],
          ), //${data[index].binAbs}
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                  "Qty : ${NumberFormat("#,###.##").format(data[index].stock)} " +
                      "${data[index].uom}"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    var state = bloc.lastState ?? bloc.initialState;
    final data = state.data.details;

    return ListView.builder(
      controller: _scrollController,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (contex, index) {
        return Container(
          child: _rowDetail(data, index),
        );
      },
    );
  }

  Widget _buildListSnB() {
    var state = bloc.lastState ?? bloc.initialState;
    final data = state.dataSnB.details;

    return ListView.builder(
      controller: _scrollController,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (contex, index) {
        return Container(
          child: _rowDetailSnB(data, index),
        );
      },
    );
  }
}
