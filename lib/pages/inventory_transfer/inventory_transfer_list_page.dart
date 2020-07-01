import 'dart:async';

import 'package:flutter/material.dart';
import 'package:admart_app/bloc_widgets/bloc_state_builder.dart';
import 'package:admart_app/blocs/global_bloc.dart';
import 'package:admart_app/blocs/inventory_transfer/list/inventory_transfer_list_bloc.dart';
import 'package:admart_app/blocs/inventory_transfer/list/inventory_transfer_list_event.dart';
import 'package:admart_app/blocs/inventory_transfer/list/inventory_transfer_list_state.dart';
//import 'package:admart_app/pages/inventory_transfer/inventory_transfer_detail_page.dart';
import 'package:intl/intl.dart';
import 'package:admart_app/pages/inventory_transfer/inventory_transfer_detail_page.dart';
import 'package:admart_app/widgets/set_colors.dart';

class InventoryTransferListPage extends StatefulWidget {
  @override
  _InventoryTransferListPageState createState() =>
      _InventoryTransferListPageState();
}

class _InventoryTransferListPageState
    extends State<InventoryTransferListPage> {
  InventoryTransferListBloc bloc = InventoryTransferListBloc();
  ScrollController _scrollController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  static const offsetVisibleThreshold = 50;

  final TextEditingController _searchQueryController = TextEditingController();
  Timer _debounce;

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 2000), () {
      var state = bloc.lastState ?? bloc.initialState;
      bloc.emitEvent(InventoryTransferListEvent(
        event: InventoryTransferListEventType.firstPage,
        searchQuery: _searchQueryController.text,
      ));
    });
  }

  void _onScroll() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      bloc.emitEvent(InventoryTransferListEvent(
        event: InventoryTransferListEventType.nextPage,
        searchQuery: _searchQueryController.text,
      ));
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.emitEvent(InventoryTransferListEvent(
        event: InventoryTransferListEventType.firstPage,
      ));
    });

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

  PreferredSizeWidget _appBar() {
    var state = bloc.lastState ?? bloc.initialState;
    if (state.isActiveSearch) {
      return AppBar(
        title: TextField(
          controller: _searchQueryController,
          decoration: InputDecoration(
            hintText: "Search Inventory Transfer",
            hintStyle: TextStyle(color: Colors.white)
          ),
        ),
        backgroundColor: bgOrange,
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
                bloc.emitEvent(InventoryTransferListEvent(
                  event: InventoryTransferListEventType.deactivedSearch,
                  searchQuery: _searchQueryController.text,
                ));
              }),
        ],
      );
    } else {
      return AppBar(
        title: Text("Inventory Transfer"),
        //backgroundColor: bgBlue,
        flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: bgGradientAppBar,
              ),
            ),
        bottom: PreferredSize(
          child: Container(
            color: bgBlue,
            height: 5.0,
          ),
          preferredSize: Size.fromHeight(5.0)
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              bloc.emitEvent(InventoryTransferListEvent(
                event: InventoryTransferListEventType.activedSearch,
              ));
            },
          ),
          (globalBloc.loginResponse.data.inventoryTransfer_Auth_Add == 'Y')
              ? IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return InventoryTransferDetailPage(0);
                    }));
                  },
                )
              : Container(),
        ],
      );
    }
  }

  //kalau langsung di inline gak mau karena functionnya harus future
  Future<void> _handleRefresh() async {
    bloc.emitEvent(InventoryTransferListEvent(
      event: InventoryTransferListEventType.refresh,
      searchQuery: _searchQueryController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<InventoryTransferListState>(
        bloc: bloc,
        builder: (BuildContext context, InventoryTransferListState state) {
          return SafeArea(
            child: Scaffold(
              key: _scaffoldKey,
              appBar: _appBar(),
              body: RefreshIndicator(
                onRefresh: _handleRefresh,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: bgGradientPageWhite,
                  ),
                  constraints: BoxConstraints.expand(),
                  child: _buildList(),
                ),
              ),
            ),
          );
        });
  }

  Widget _buildList() {
    var state = bloc.lastState ?? bloc.initialState;

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
            margin: const EdgeInsets.all(3),
            // decoration:
            //     BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                    "No.  ${data[index].seriesName} - ${data[index].transNo}  -  ${DateFormat('dd/MM/yyyy').format(data[index].transDate)}"), //"No. ${data[index].transNo} (${data[index].id.toString()}) ")
                subtitle: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        "Warehouse : ${data[index].fromWhsCode} to ${data[index].toWhsCode}"),
                    Text("User : ${data[index].createdUser}"),
                  ],
                ),
                leading: ClipOval(
                  child: Image.network(
                    globalBloc.getUrl() +
                        "api/UserApi/GetImage?id=${data[index].userId}",
                    width: 50.0,
                    height: 50.0,
                  ),
                ),

                trailing: Icon(Icons.keyboard_arrow_right),
                //color: Colors.white, size: 30.0),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          InventoryTransferDetailPage(data[index].id),
                    ),
                  );
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
