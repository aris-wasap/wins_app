import 'package:flutter/material.dart';
import 'package:admart_app/bloc_widgets/bloc_state_builder.dart';
import 'package:admart_app/blocs/item/detail/item_detail_bloc.dart';
import 'package:admart_app/blocs/item/detail/item_detail_event.dart';
import 'package:admart_app/blocs/item/detail/item_detail_state.dart';
import 'package:admart_app/models/item_detail_scan_response.dart';
import 'package:admart_app/widgets/validate_dialog_widget.dart';
import 'package:intl/intl.dart';
import 'package:admart_app/pages/barcode_scan.dart';
import 'package:flutter/services.dart';

class CheckDataPage extends StatefulWidget {
  @override
  _CheckDataPageState createState() => _CheckDataPageState();
}

class _CheckDataPageState extends State<CheckDataPage> {
  ItemDetailBloc bloc = ItemDetailBloc();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController;

  final _itemCodeController = TextEditingController();
  final _itemNameController = TextEditingController();
  final _batchController = TextEditingController();
  final _stockController = TextEditingController();

  DateTime transDate; // = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _itemCodeController?.dispose();
    _itemNameController?.dispose();
    _batchController?.dispose();
    _stockController?.dispose();

    bloc?.dispose();

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

      bloc.emitEvent(ItemDetailEventScan(qrResult: qrResult, data: data));
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        ValidateDialogWidget(
            context: context, massage: "Scan : Camera permition was denied");
        return;
      } else {
        ValidateDialogWidget(
            context: context, massage: "Scan : Unknown error $ex");
        return;
      }
    } on FormatException {
      ValidateDialogWidget(
          context: context,
          massage: "Scan : You press back button before scan");
      return;
    } catch (ex) {
      ValidateDialogWidget(
          context: context, massage: "Scan : Unknown error $ex");
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
              //appBar: _appBar(),
              //backgroundColor: Colors.blue[100],
              body: Container(
                // constraints: BoxConstraints.expand(),
                height: MediaQuery.of(context).size.height,
                // decoration: BoxDecoration(
                //    image : DecorationImage(image: AssetImage("assets/images/579.jpg"), fit: BoxFit.cover, repeat: ImageRepeat.noRepeat),
                // //     gradient: LinearGradient(
                // //   colors: [
                // //     Colors.blue[100],
                // //     Colors.blue[100],
                // //   ],
                // //   begin: Alignment.topCenter,
                // //   end: Alignment.bottomCenter,
                // // )
                // ),
                child: Stack(children: <Widget>[
                  SingleChildScrollView(
                    padding: EdgeInsets.all(0.0),
                    child: _buildForm(),
                  ),
                  _showCircularProgress(),
                ]),
              ),
              floatingActionButton: FloatingActionButton.extended(
                icon: Icon(Icons.camera_alt),
                backgroundColor: Colors.orange[700],
                label: Text("Scan"),
                onPressed: () {
                  _scanQR();
                },
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat ,
            ),
          );
        });
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
    if (data.itemCode != null) {
      _itemCodeController.text = data.itemCode;
      _itemNameController.text = data.itemName;
      _batchController.text = data.distNumber;
      _stockController.text = data.totalStock.toString();
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      color: Colors.transparent,
                      height: 50,
                      child: Text("Stock Item Master Data", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.white,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                      ),
                      TextFormField(
                          controller: _itemCodeController,
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: "Item code",
                            labelText: "Item code",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0)),
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                      ),
                      TextFormField(
                          controller: _itemNameController,
                          enabled: false,
                          decoration: InputDecoration(
                              hintText: "Item name",
                              labelText: "Item name",
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(10.0)))),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                      ),
                      TextFormField(
                          controller: _batchController,
                          enabled: false,
                          decoration: InputDecoration(
                              hintText: "Batch No.",
                              labelText: "Batch No.",
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(10.0)))),
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
                                  borderRadius: new BorderRadius.circular(10.0))))
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
                    child: ((data.details != null) ? data.details.length : 0) > 0
                        ? _buildList()
                        : Container(
                            padding: EdgeInsets.all(10.0),
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Text("Item Empty"),
                          )),
                Container(
                  height: 5,
                  color: Colors.grey,
                )
              ]),
        ),
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
          title:
              Text("${data[index].whsName}" + "(" "${data[index].whsCode}" ")"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                  "Qty : ${NumberFormat("#,###.00").format(data[index].stock)}"),
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
}
