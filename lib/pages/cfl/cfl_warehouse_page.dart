import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wins_app/bloc_widgets/bloc_state_builder.dart';
import 'package:wins_app/blocs/cfl_warehouse/cfl_warehouse_bloc.dart';
import 'package:wins_app/blocs/cfl_warehouse/cfl_warehouse_event.dart';
import 'package:wins_app/blocs/cfl_warehouse/cfl_warehouse_state.dart';
import 'package:intl/intl.dart';
import 'package:wins_app/models/cfl_warehouse_response.dart';
import 'package:wins_app/widgets/set_colors.dart';

class CflWarehousePage extends StatefulWidget {
  CflWarehousePage(this.branchId);
  final int branchId;
  @override
  _CflWarehousePageState createState() => _CflWarehousePageState(branchId);
}

class _CflWarehousePageState extends State<CflWarehousePage> {
  _CflWarehousePageState(this.branchId);
  CflWarehouseBloc bloc = CflWarehouseBloc();

  ScrollController _scrollController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  static const offsetVisibleThreshold = 50;
  final int branchId;
  final TextEditingController _searchQueryController = TextEditingController();
  Timer _debounce;

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 2000), () {
      bloc.emitEvent(CflWarehouseEvent(
        event: CflWarehouseEventType.firstPage,
        searchQuery: _searchQueryController.text,
        branchId: branchId,
      ));
    });
  }

  void _onScroll() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      bloc.emitEvent(CflWarehouseEvent(
        event: CflWarehouseEventType.nextPage,
        searchQuery: _searchQueryController.text,
        branchId: branchId,
      ));
    }
  }

  @override
  void initState() {
    super.initState();

    bloc.emitEvent(CflWarehouseEvent(
      event: CflWarehouseEventType.firstPage,
      branchId: branchId,
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

  PreferredSizeWidget _appBar(CflWarehouseState state) {
    if (state.isActiveSearch) {
      return AppBar(
        title: TextField(
          style: TextStyle(
            color: Colors.white,
          ),
          cursorColor: bgWhite,
          autofocus: true,
          controller: _searchQueryController,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
            ),
            hintText: "Search Warehouse",
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: bgOrange,
        bottom: PreferredSize(
            child: state.isBusy
                ? Shimmer.fromColors(
                    baseColor: bgOrange,
                    highlightColor: bgWhite,
                    child: Container(
                      color: bgWhite,
                      height: 5.0,
                    ),
                  )
                : Container(
                    color: bgOrange,
                    height: 5.0,
                  ),
            preferredSize: Size.fromHeight(5.0)),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _searchQueryController.text = "";
                bloc.emitEvent(CflWarehouseEvent(
                  event: CflWarehouseEventType.deactivedSearch,
                  searchQuery: _searchQueryController.text,
                  branchId: branchId,
                ));
              }),
        ],
      );
    } else {
      return AppBar(
        title: Text("Choose Warehouse"),
        backgroundColor: bgBlue,
        bottom: PreferredSize(
            child: state.isBusy
                ? Shimmer.fromColors(
                    baseColor: bgBlue,
                    highlightColor: bgOrange,
                    child: Container(
                      color: bgBlue,
                      height: 5.0,
                    ),
                  )
                : Container(
                    color: bgOrange,
                    height: 5.0,
                  ),
            preferredSize: Size.fromHeight(5.0)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              bloc.emitEvent(CflWarehouseEvent(
                event: CflWarehouseEventType.activedSearch,
                branchId: branchId,
              ));
            },
          ),
        ],
      );
    }
  }

  //kalau langsung di inline gak mau karena functionnya harus future
  Future<void> _handleRefresh() async {
    bloc.emitEvent(CflWarehouseEvent(
      event: CflWarehouseEventType.refresh,
      searchQuery: _searchQueryController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<CflWarehouseState>(
        bloc: bloc,
        builder: (BuildContext context, CflWarehouseState state) {
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

  Widget buildList(CflWarehouseState state) {
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
                title: Text("${data[index].whsCode} "),
                leading: Icon(Icons.keyboard_arrow_left),
                onTap: () {
                  Navigator.pop(context, data[index]);
                },
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("${data[index].whsName}"),
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
