import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wins_app/bloc_widgets/bloc_state_builder.dart';
import 'package:wins_app/blocs/cfl_batch_location/cfl_batch_location_bloc.dart';
import 'package:wins_app/blocs/cfl_batch_location/cfl_batch_location_event.dart';
import 'package:wins_app/blocs/cfl_batch_location/cfl_batch_location_state.dart';
import 'package:intl/intl.dart';
import 'package:wins_app/models/cfl_batch_location_response.dart';
import 'package:wins_app/widgets/set_colors.dart';

class CflBatchLocationPage extends StatefulWidget {
  CflBatchLocationPage(this.whsCode, this.bacthNo, this.itemCode);
  final String whsCode;
  final String bacthNo;
  final String itemCode;
  @override
  _CflBatchLocationPageState createState() =>
      _CflBatchLocationPageState(whsCode, bacthNo, itemCode);
}

class _CflBatchLocationPageState extends State<CflBatchLocationPage> {
  _CflBatchLocationPageState(this.whsCode, this.batchNo, this.itemCode);
  CflBatchLocationBloc bloc = CflBatchLocationBloc();

  ScrollController _scrollController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  static const offsetVisibleThreshold = 50;
  final String whsCode;
  final String batchNo;
  final String itemCode;
  final TextEditingController _searchQueryController = TextEditingController();
  Timer _debounce;

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 2000), () {
      bloc.emitEvent(CflBatchLocationEvent(
          event: CflBatchLocationEventType.firstPage,
          searchQuery: _searchQueryController.text,
          whsCode: whsCode,
          batchNo: batchNo,
          itemCode: itemCode));
    });
  }

  void _onScroll() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      bloc.emitEvent(CflBatchLocationEvent(
          event: CflBatchLocationEventType.nextPage,
          searchQuery: _searchQueryController.text,
          whsCode: whsCode,
          batchNo: batchNo,
          itemCode: itemCode));
    }
  }

  @override
  void initState() {
    super.initState();

    bloc.emitEvent(CflBatchLocationEvent(
        event: CflBatchLocationEventType.firstPage,
        whsCode: whsCode,
        batchNo: batchNo,
        itemCode: itemCode));

    _scrollController = ScrollController()..addListener(_onScroll);

    _searchQueryController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchQueryController?.removeListener(_onSearchChanged);
    _searchQueryController?.dispose();
    _scrollController?.dispose();
    bloc?.dispose();
    super.dispose();
  }

  PreferredSizeWidget _appBar(CflBatchLocationState state) {
    if (state.isActiveSearch) {
      return AppBar(
        title: TextField(
          autofocus: true,
          controller: _searchQueryController,
          decoration: InputDecoration(
            hintText: "Search Batch Location",
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: bgOrange,
        bottom: PreferredSize(
            child: Container(
              color: bgOrange,
              height: 5.0,
            ),
            preferredSize: Size.fromHeight(5.0)),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _searchQueryController.text = "";
                bloc.emitEvent(CflBatchLocationEvent(
                    event: CflBatchLocationEventType.deactivedSearch,
                    searchQuery: _searchQueryController.text,
                    whsCode: whsCode,
                    batchNo: batchNo,
                    itemCode: itemCode));
              }),
        ],
      );
    } else {
      return AppBar(
        title: Text("Choose Batch Location"),
        backgroundColor: bgBlue,
        bottom: PreferredSize(
            child: Container(
              color: bgOrange,
              height: 5.0,
            ),
            preferredSize: Size.fromHeight(5.0)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              bloc.emitEvent(CflBatchLocationEvent(
                  event: CflBatchLocationEventType.activedSearch,
                  whsCode: whsCode,
                  batchNo: batchNo,
                  itemCode: itemCode));
            },
          ),
        ],
      );
    }
  }

  //kalau langsung di inline gak mau karena functionnya harus future
  Future<void> _handleRefresh() async {
    bloc.emitEvent(CflBatchLocationEvent(
      event: CflBatchLocationEventType.refresh,
      searchQuery: _searchQueryController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<CflBatchLocationState>(
        bloc: bloc,
        builder: (BuildContext context, CflBatchLocationState state) {
          return SafeArea(
            child: Scaffold(
              key: _scaffoldKey,
              appBar: _appBar(state),
              body: RefreshIndicator(
                onRefresh: _handleRefresh,
                child: Container(
                  decoration: BoxDecoration(gradient: bgGradientPageWhite),
                  constraints: BoxConstraints.expand(),
                  child: buildList(state),
                ),
              ),
            ),
          );
        });
  }

  Widget buildList(CflBatchLocationState state) {
    final data = state.data;
    final isBusy = state.isBusy;
    final isFailure = state.isFailure;

    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => Divider(),
      controller: _scrollController,
      itemCount: data.length + 1,
      itemBuilder: (contex, index) {
        if (index < data.length) {
          return (Container(
            decoration: BoxDecoration(
              gradient: index % 2 == 0 ? bgGradientPage : bgGradientPageBlue,
            ),
            margin: const EdgeInsets.all(0),
            // decoration:
            //     BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text("Batch Number : ${data[index].batchNumber}"),
                leading: Icon(Icons.keyboard_arrow_left),
                onTap: () {
                  Navigator.pop(context, data[index]);
                },
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Warehouse : ${data[index].whsCode}"),
                    Text("Bin Location : ${data[index].binCode}"),
                    Text("Stock Qty : ${data[index].availableQty}"),
                    Text("Uom : ${data[index].uom}"),
                  ],
                ),
              ),
            ),
          ));
        }

        if (isFailure) {
          return ListTile(
            title: Text(
              'Error while loading data...',
              style: Theme.of(context).textTheme.body1.copyWith(fontSize: 16.0),
            ),
            isThreeLine: false,
            leading: CircleAvatar(
              child: Text(':('),
              foregroundColor: Colors.white,
              backgroundColor: Colors.redAccent,
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Opacity(
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
              ),
              opacity: isBusy ? 1 : 0,
            ),
          ),
        );
      },
    );
  }
}
