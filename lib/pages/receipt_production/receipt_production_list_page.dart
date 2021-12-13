import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wins_app/bloc_widgets/bloc_state_builder.dart';
import 'package:wins_app/blocs/global_bloc.dart';
import 'package:wins_app/blocs/receipt_production/list/receipt_production_list_bloc.dart';
import 'package:wins_app/blocs/receipt_production/list/receipt_production_list_event.dart';
import 'package:wins_app/blocs/receipt_production/list/receipt_production_list_state.dart';
import 'package:wins_app/pages/receipt_production/receipt_production_detail_page.dart';
import 'package:intl/intl.dart';
import 'package:wins_app/widgets/set_colors.dart';

class ReceiptProductionListPage extends StatefulWidget {
  @override
  _ReceiptProductionListPageState createState() =>
      _ReceiptProductionListPageState();
}

class _ReceiptProductionListPageState extends State<ReceiptProductionListPage> {
  ReceiptProductionListBloc bloc = ReceiptProductionListBloc();
  ScrollController _scrollController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  static const offsetVisibleThreshold = 50;

  final TextEditingController _searchQueryController = TextEditingController();
  Timer _debounce;

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 2000), () {
      var state = bloc.lastState ?? bloc.initialState;
      bloc.emitEvent(ReceiptProductionListEvent(
        event: ReceiptProductionListEventType.firstPage,
        searchQuery: _searchQueryController.text,
      ));
    });
  }

  void _onScroll() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      bloc.emitEvent(ReceiptProductionListEvent(
        event: ReceiptProductionListEventType.nextPage,
        searchQuery: _searchQueryController.text,
      ));
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.emitEvent(ReceiptProductionListEvent(
        event: ReceiptProductionListEventType.firstPage,
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
              hintText: "Search Receipt Production",
              hintStyle: TextStyle(color: Colors.white)),
        ),
        backgroundColor: Colors.orange[500],
        bottom: PreferredSize(
            child: Container(
              color: Colors.orange[500],
              height: 5.0,
            ),
            preferredSize: Size.fromHeight(5.0)),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _searchQueryController.text = "";
                bloc.emitEvent(ReceiptProductionListEvent(
                  event: ReceiptProductionListEventType.deactivedSearch,
                  searchQuery: _searchQueryController.text,
                ));
              }),
        ],
      );
    } else {
      return AppBar(
        title: Text("List Receipt"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: bgGradientAppBar,
          ),
        ),
        //backgroundColor: appBarBgColors,
        bottom: PreferredSize(
            child: Container(
              color: bgBlue,
              height: 5.0,
            ),
            preferredSize: Size.fromHeight(5.0)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              bloc.emitEvent(ReceiptProductionListEvent(
                event: ReceiptProductionListEventType.activedSearch,
              ));
            },
          ),
          (globalBloc.loginResponse.data.receiptProduction_Auth_Add == 'Y')
              ? IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return ReceiptProductionDetailPage(0);
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
    bloc.emitEvent(ReceiptProductionListEvent(
      event: ReceiptProductionListEventType.refresh,
      searchQuery: _searchQueryController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<ReceiptProductionListState>(
        bloc: bloc,
        builder: (BuildContext context, ReceiptProductionListState state) {
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

    return Container(
      color: Colors.blue[100],
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
        child: Card(
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) => Divider(),
            controller: _scrollController,
            itemCount: data.length + 1,
            itemBuilder: (contex, index) {
              if (index < data.length) {
                return (Container(
                  decoration: BoxDecoration(
                    gradient:
                        index % 2 == 0 ? bgGradientPage : bgGradientPageBlue,
                  ),
                  margin: const EdgeInsets.all(3),
                  // decoration:
                  //     BoxDecoration(border: Border(bottom: BorderSide(width: 0.5))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                          "No. ${data[index].seriesName} - ${data[index].transNo}  -  ${DateFormat('dd/MM/yyyy').format(data[index].transDate)}"), //"No. ${data[index].transNo} (${data[index].id.toString()}) ")
                      subtitle: Column(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //Text(data[index].customerName),
                          Text(
                              "${data[index].status} - ${data[index].createdUser}"),
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
                                ReceiptProductionDetailPage(data[index].id),
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
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(fontSize: 16.0),
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
          ),
        ),
      ),
    );
  }
}
