import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wins_app/bloc_widgets/bloc_state_builder.dart';
import 'package:wins_app/blocs/global_bloc.dart';
import 'package:wins_app/blocs/transfer_production/list/transfer_production_list_bloc.dart';
import 'package:wins_app/blocs/transfer_production/list/transfer_production_list_event.dart';
import 'package:wins_app/blocs/transfer_production/list/transfer_production_list_state.dart';
import 'package:wins_app/pages/transfer_production/transfer_production_detail_page.dart';
import 'package:intl/intl.dart';
import 'package:wins_app/widgets/set_colors.dart';

class TransferProductionListPage extends StatefulWidget {
  @override
  _TransferProductionListPageState createState() =>
      _TransferProductionListPageState();
}

class _TransferProductionListPageState
    extends State<TransferProductionListPage> {
  TransferProductionListBloc bloc = TransferProductionListBloc();
  ScrollController _scrollController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  static const offsetVisibleThreshold = 50;

  final TextEditingController _searchQueryController = TextEditingController();
  Timer _debounce;

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 2000), () {
      var state = bloc.lastState ?? bloc.initialState;
      bloc.emitEvent(TransferProductionListEvent(
        event: TransferProductionListEventType.firstPage,
        searchQuery: _searchQueryController.text,
      ));
    });
  }

  void _onScroll() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      bloc.emitEvent(TransferProductionListEvent(
        event: TransferProductionListEventType.nextPage,
        searchQuery: _searchQueryController.text,
      ));
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.emitEvent(TransferProductionListEvent(
        event: TransferProductionListEventType.firstPage,
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
              hintText: "Search Transfer Production",
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
                bloc.emitEvent(TransferProductionListEvent(
                  event: TransferProductionListEventType.deactivedSearch,
                  searchQuery: _searchQueryController.text,
                ));
              }),
        ],
      );
    } else {
      return AppBar(
        title: Text("List Transfer Production"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: bgGradientAppBar,
          ),
        ),
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
                    color: bgBlue,
                    height: 5.0,
                  ),
            preferredSize: Size.fromHeight(5.0)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              bloc.emitEvent(TransferProductionListEvent(
                event: TransferProductionListEventType.activedSearch,
              ));
            },
          ),
          (globalBloc.loginResponse.data.transferProduction_Auth_Add == 'Y')
              ? IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return TransferProductionDetailPage(0);
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
    bloc.emitEvent(TransferProductionListEvent(
      event: TransferProductionListEventType.refresh,
      searchQuery: _searchQueryController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<TransferProductionListState>(
        bloc: bloc,
        builder: (BuildContext context, TransferProductionListState state) {
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                    "Scan No. ${data[index].transNo}  -  ${DateFormat('dd/MM/yyyy').format(data[index].transDate)}"), //"No. ${data[index].transNo} (${data[index].id.toString()}) ")
                subtitle: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Production No. : ${data[index].woNo}"),
                    Text(
                        "Transfer Production No. : ${data[index].sapTransferProductionNo}"),
                    Text(
                        "Warehouse : ${data[index].fromWhsCode} to ${data[index].toWhsCode}"),
                    //Text("Depo : ${data[index].branchName}"),
                    Text("Status : ${data[index].status}"),
                    Text("User : ${data[index].createdUser}"),
                  ],
                ),
                // leading: ClipOval(
                //   child: Image.network(
                //     globalBloc.getUrl() +
                //         "api/UserApi/GetImage?id=${data[index].userId}",
                //     width: 50.0,
                //     height: 50.0,
                //   ),b
                // ),

                trailing: Icon(Icons.keyboard_arrow_right),
                //color: Colors.white, size: 30.0),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          TransferProductionDetailPage(data[index].id),
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
