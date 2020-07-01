import 'dart:async';

import 'package:flutter/material.dart';
import 'package:admart_app/bloc_widgets/bloc_state_builder.dart';
import 'package:admart_app/blocs/cfl_item_batch/cfl_item_batch_bloc.dart';
import 'package:admart_app/blocs/cfl_item_batch/cfl_item_batch_event.dart';
import 'package:admart_app/blocs/cfl_item_batch/cfl_item_batch_state.dart';
import 'package:intl/intl.dart';
import 'package:admart_app/models/cfl_item_batch_response.dart';
import 'package:admart_app/widgets/set_colors.dart';

class CflItemBatchPage extends StatefulWidget {
  CflItemBatchPage(this.whsCode, this.bacthNo, this.id);
  final String whsCode;
  final String bacthNo;
  final int id;
  @override
  _CflItemBatchPageState createState() =>
      _CflItemBatchPageState(whsCode, bacthNo, id);
}

class _CflItemBatchPageState extends State<CflItemBatchPage> {
  _CflItemBatchPageState(this.whsCode, this.batchNo, this.id);
  CflItemBatchBloc bloc = CflItemBatchBloc();

  ScrollController _scrollController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  static const offsetVisibleThreshold = 50;
  final String whsCode;
  final String batchNo;
  final int id;
  final TextEditingController _searchQueryController = TextEditingController();
  Timer _debounce;

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 2000), () {
      bloc.emitEvent(CflItemBatchEvent(
        event: CflItemBatchEventType.firstPage,
        searchQuery: _searchQueryController.text,
        whsCode: whsCode,
        batchNo: batchNo,
        id:id
      ));
    });
  }

  void _onScroll() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      bloc.emitEvent(CflItemBatchEvent(
        event: CflItemBatchEventType.nextPage,
        searchQuery: _searchQueryController.text,
        whsCode: whsCode,
        batchNo: batchNo,
        id:id
      ));
    }
  }

  @override
  void initState() {
    super.initState();

    bloc.emitEvent(CflItemBatchEvent(
      event: CflItemBatchEventType.firstPage,
      whsCode: whsCode,
      batchNo: batchNo,
      id:id
    ));

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

  PreferredSizeWidget _appBar(CflItemBatchState state) {
    if (state.isActiveSearch) {
      return AppBar(
        title: TextField(
          controller: _searchQueryController,
          decoration: InputDecoration(
            hintText: "Search Item",
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: bgBlue,
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
                bloc.emitEvent(CflItemBatchEvent(
                  event: CflItemBatchEventType.deactivedSearch,
                  searchQuery: _searchQueryController.text,
                  whsCode: whsCode,
                  batchNo: batchNo,
                  id:id
                ));
              }),
        ],
      );
    } else {
      return AppBar(
        title: Text("Choose Item"),
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
              bloc.emitEvent(CflItemBatchEvent(
                event: CflItemBatchEventType.activedSearch,
                whsCode: whsCode,
                batchNo: batchNo,
                id:id
              ));
            },
          ),
        ],
      );
    }
  }

  //kalau langsung di inline gak mau karena functionnya harus future
  Future<void> _handleRefresh() async {
    bloc.emitEvent(CflItemBatchEvent(
      event: CflItemBatchEventType.refresh,
      searchQuery: _searchQueryController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<CflItemBatchState>(
        bloc: bloc,
        builder: (BuildContext context, CflItemBatchState state) {
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

  Widget buildList(CflItemBatchState state) {
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
                title: Text(
                    "${data[index].itemCode} - ${data[index].itemName}"),
                leading: Icon(Icons.keyboard_arrow_left),
                onTap: () {
                  Navigator.pop(context, data[index]);
                },
                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Batch Number : ${data[index].batchNumber}"),
                                    Text("Stock Qty : ${data[index].availableQty}"),
                                    Text("Planned Qty : ${data[index].plannedQty}"),
                                    Text("Issued Qty : ${data[index].issueQty}"),
                                    Text("Open Qty : ${data[index].openQty}"),
                                    Text("Warehouse : ${data[index].whsCode}"),
                                    Text("Bin Location : ${data[index].binCode}"),
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
