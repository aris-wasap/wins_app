import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wins_app/bloc_widgets/bloc_state_builder.dart';
import 'package:wins_app/blocs/cfl_receipt_production_label/cfl_receipt_production_label_bloc.dart';
import 'package:wins_app/blocs/cfl_receipt_production_label/cfl_receipt_production_label_event.dart';
import 'package:wins_app/blocs/cfl_receipt_production_label/cfl_receipt_production_label_state.dart';
import 'package:intl/intl.dart';
import 'package:wins_app/widgets/set_colors.dart';

class CflReceiptProductionLabelPage extends StatefulWidget {
  @override
  _CflReceiptProductionLabelPageState createState() =>
      _CflReceiptProductionLabelPageState();
}

class _CflReceiptProductionLabelPageState
    extends State<CflReceiptProductionLabelPage> {
  CflReceiptProductionLabelBloc bloc = CflReceiptProductionLabelBloc();

  ScrollController _scrollController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  static const offsetVisibleThreshold = 50;

  final TextEditingController _searchQueryController = TextEditingController();
  Timer _debounce;

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 2000), () {
      bloc.emitEvent(CflReceiptProductionLabelEvent(
        event: CflReceiptProductionLabelEventType.firstPage,
        searchQuery: _searchQueryController.text,
      ));
    });
  }

  void _onScroll() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      bloc.emitEvent(CflReceiptProductionLabelEvent(
        event: CflReceiptProductionLabelEventType.nextPage,
        searchQuery: _searchQueryController.text,
      ));
    }
  }

  @override
  void initState() {
    super.initState();

    bloc.emitEvent(CflReceiptProductionLabelEvent(
      event: CflReceiptProductionLabelEventType.firstPage,
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

  PreferredSizeWidget _appBar(CflReceiptProductionLabelState state) {
    if (state.isActiveSearch) {
      return AppBar(
        title: TextField(
          controller: _searchQueryController,
          decoration: InputDecoration(
            hintText: "Search Purchase Order",
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
                bloc.emitEvent(CflReceiptProductionLabelEvent(
                  event: CflReceiptProductionLabelEventType.deactivedSearch,
                  searchQuery: _searchQueryController.text,
                ));
              }),
        ],
      );
    } else {
      return AppBar(
        title: Text("Choose Receipt Production Label"),
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
              bloc.emitEvent(CflReceiptProductionLabelEvent(
                event: CflReceiptProductionLabelEventType.activedSearch,
              ));
            },
          ),
        ],
      );
    }
  }

  //kalau langsung di inline gak mau karena functionnya harus future
  Future<void> _handleRefresh() async {
    bloc.emitEvent(CflReceiptProductionLabelEvent(
      event: CflReceiptProductionLabelEventType.refresh,
      searchQuery: _searchQueryController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<CflReceiptProductionLabelState>(
        bloc: bloc,
        builder: (BuildContext context, CflReceiptProductionLabelState state) {
          return SafeArea(
            child: Scaffold(
              key: _scaffoldKey,
              appBar: _appBar(state),
              body: RefreshIndicator(
                onRefresh: _handleRefresh,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: bgGradientPageWhite,
                  ),
                  constraints: BoxConstraints.expand(),
                  child: buildList(state),
                ),
              ),
            ),
          );
        });
  }

  Widget buildList(CflReceiptProductionLabelState state) {
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
                    "Goods Issue No.  ${data[index].docNum ?? ''}  -  ${DateFormat('dd/MM/yyyy').format(data[index].transDate)} "),
                subtitle: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Label No. : ${data[index].transNo ?? ''}"),
                    // Text("Issue No. : ${data[index].docNum ?? ''}"),
                    Text("WO No. : ${data[index].woNo ?? ''}"),
                    Text("Product Code : ${data[index].productCode ?? ''}"),
                    Text("Product Name : ${data[index].productName ?? ''}"),
                    // Text("Status : ${data[index].status ?? ''}"),
                    // Text("Branch : ${data[index].branchName ?? ''}"),
                  ],
                ),
                leading: Icon(Icons.keyboard_arrow_left),
                onTap: () {
                  Navigator.pop(context, data[index]);
                },
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
