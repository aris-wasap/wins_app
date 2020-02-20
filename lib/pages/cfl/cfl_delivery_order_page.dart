import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ncf_app/bloc_widgets/bloc_state_builder.dart';
import 'package:ncf_app/blocs/cfl_delivery_order/cfl_delivery_order_bloc.dart';
import 'package:ncf_app/blocs/cfl_delivery_order/cfl_delivery_order_event.dart';
import 'package:ncf_app/blocs/cfl_delivery_order/cfl_delivery_order_state.dart';
import 'package:intl/intl.dart';
import 'package:ncf_app/widgets/set_colors.dart';

class CflDeliveryOrderPage extends StatefulWidget {
  @override
  _CflDeliveryOrderPageState createState() => _CflDeliveryOrderPageState();
}

class _CflDeliveryOrderPageState extends State<CflDeliveryOrderPage> {
  CflDeliveryOrderBloc bloc = CflDeliveryOrderBloc();

  ScrollController _scrollController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  static const offsetVisibleThreshold = 50;

  final TextEditingController _searchQueryController = TextEditingController();
  Timer _debounce;

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 2000), () {
      bloc.emitEvent(CflDeliveryOrderEvent(
        event: CflDeliveryOrderEventType.firstPage,
        searchQuery: _searchQueryController.text,
      ));
    });
  }

  void _onScroll() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      bloc.emitEvent(CflDeliveryOrderEvent(
        event: CflDeliveryOrderEventType.nextPage,
        searchQuery: _searchQueryController.text,
      ));
    }
  }

  @override
  void initState() {
    super.initState();

    bloc.emitEvent(CflDeliveryOrderEvent(
      event: CflDeliveryOrderEventType.firstPage,
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

  PreferredSizeWidget _appBar(CflDeliveryOrderState state) {
    if (state.isActiveSearch) {
      return AppBar(
        title: TextField(
          controller: _searchQueryController,
          decoration: InputDecoration(
            hintText: "Search Delivery Order",
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: bgBlue,
        bottom: PreferredSize(
          child: Container(
            color: bgOrange,
            height: 5.0,
          ),
          preferredSize: Size.fromHeight(5.0)
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _searchQueryController.text = "";
                bloc.emitEvent(CflDeliveryOrderEvent(
                  event: CflDeliveryOrderEventType.deactivedSearch,
                  searchQuery: _searchQueryController.text,
                ));
              }),
        ],
      );
    } else {
      return AppBar(
        title: Text("Choose Delivery Order"),
        backgroundColor: bgBlue,
        bottom: PreferredSize(
          child: Container(
            color: bgOrange,
            height: 5.0,
          ),
          preferredSize: Size.fromHeight(5.0)
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              bloc.emitEvent(CflDeliveryOrderEvent(
                event: CflDeliveryOrderEventType.activedSearch,
              ));
            },
          ),
        ],
      );
    }
  }

  //kalau langsung di inline gak mau karena functionnya harus future
  Future<void> _handleRefresh() async {
    bloc.emitEvent(CflDeliveryOrderEvent(
      event: CflDeliveryOrderEventType.refresh,
      searchQuery: _searchQueryController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<CflDeliveryOrderState>(
        bloc: bloc,
        builder: (BuildContext context, CflDeliveryOrderState state) {
          return SafeArea(
            child: Scaffold(
              key: _scaffoldKey,
              appBar: _appBar(state),
              body: RefreshIndicator(
                onRefresh: _handleRefresh,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: bgGradientPageWhite
                  ),
                  constraints: BoxConstraints.expand(),
                  child: buildList(state),
                ),
              ),
            ),
          );
        });
  }

  Widget buildList(CflDeliveryOrderState state) {
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
                    "No. ${data[index].seriesName} - ${data[index].transNo}  -  ${DateFormat('dd/MM/yyyy').format(data[index].transDate)} "),
                subtitle: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[ 
                    Text("${data[index].customerCode??''}"),
                    Text("${data[index].customerName??''}"),
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
