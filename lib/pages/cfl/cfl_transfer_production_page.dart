import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wins_app/bloc_widgets/bloc_state_builder.dart';
import 'package:wins_app/blocs/cfl_transfer_production/cfl_transfer_production_bloc.dart';
import 'package:wins_app/blocs/cfl_transfer_production/cfl_transfer_production_event.dart';
import 'package:wins_app/blocs/cfl_transfer_production/cfl_transfer_production_state.dart';
import 'package:intl/intl.dart';
import 'package:wins_app/widgets/set_colors.dart';

class CflTransferProductionPage extends StatefulWidget {
  CflTransferProductionPage(this.productionType);
  final String productionType;
  @override
  _CflTransferProductionPageState createState() =>
      _CflTransferProductionPageState(productionType);
}

class _CflTransferProductionPageState extends State<CflTransferProductionPage> {
  _CflTransferProductionPageState(this.productionType);
  CflTransferProductionBloc bloc = CflTransferProductionBloc();

  ScrollController _scrollController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final String productionType;

  static const offsetVisibleThreshold = 50;

  final TextEditingController _searchQueryController = TextEditingController();
  Timer _debounce;

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 2000), () {
      bloc.emitEvent(CflTransferProductionEvent(
        event: CflTransferProductionEventType.firstPage,
        searchQuery: _searchQueryController.text,
        productionType: productionType,
      ));
    });
  }

  void _onScroll() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      bloc.emitEvent(CflTransferProductionEvent(
        event: CflTransferProductionEventType.nextPage,
        searchQuery: _searchQueryController.text,
        productionType: productionType,
      ));
    }
  }

  @override
  void initState() {
    super.initState();

    bloc.emitEvent(CflTransferProductionEvent(
      event: CflTransferProductionEventType.firstPage,
      productionType: productionType,
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

  PreferredSizeWidget _appBar(CflTransferProductionState state) {
    if (state.isActiveSearch) {
      return AppBar(
        title: TextField(
          controller: _searchQueryController,
          decoration: InputDecoration(
              hintText: "Search Production Order",
              hintStyle: TextStyle(color: Colors.white)),
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
                bloc.emitEvent(CflTransferProductionEvent(
                  event: CflTransferProductionEventType.deactivedSearch,
                  searchQuery: _searchQueryController.text,
                  productionType: productionType,
                ));
              }),
        ],
      );
    } else {
      return AppBar(
        title: Text("Choose Production Order"),
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
              bloc.emitEvent(CflTransferProductionEvent(
                  event: CflTransferProductionEventType.activedSearch,
                  productionType: productionType));
            },
          ),
        ],
      );
    }
  }

  //kalau langsung di inline gak mau karena functionnya harus future
  Future<void> _handleRefresh() async {
    bloc.emitEvent(CflTransferProductionEvent(
      event: CflTransferProductionEventType.refresh,
      searchQuery: _searchQueryController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<CflTransferProductionState>(
        bloc: bloc,
        builder: (BuildContext context, CflTransferProductionState state) {
          return SafeArea(
            child: Scaffold(
              key: _scaffoldKey,
              appBar: _appBar(state),
              body: RefreshIndicator(
                onRefresh: _handleRefresh,
                child: Container(
                  constraints: BoxConstraints.expand(),
                  child: buildList(state),
                ),
              ),
            ),
          );
        });
  }

  Widget buildList(CflTransferProductionState state) {
    final data = state.data;
    final isBusy = state.isBusy;
    final isFailure = state.isFailure;

    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => Divider(),
      controller: _scrollController,
      itemCount: data.length + 1,
      itemBuilder: (contex, index) {
        if (index < data.length) {
          return Card(
            child: (Container(
              decoration: BoxDecoration(
                gradient:
                    index % 2 == 0 ? bgGradientPageWhite : bgGradientPageBlue,
              ),
              //margin: const EdgeInsets.only(top: 8),
              // decoration:
              //     BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: ListTile(
                  title: Text(
                      "No. ${data[index].transNo}  -  ${DateFormat('dd/MM/yyyy').format(data[index].transDate)} "),
                  subtitle: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("${data[index].productCode ?? ''}"),
                      Text("${data[index].productName ?? ''}"),
                      Text(
                          "Planned Qty : ${data[index].plannedQty} ${data[index].uom}"),
                      Text("Status : ${data[index].status}"),
                    ],
                  ),
                  leading: Icon(Icons.keyboard_arrow_left),
                  onTap: () {
                    Navigator.pop(context, data[index]);
                  },
                ),
              ),
            )),
          );
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
