import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wins_app/bloc_widgets/bloc_state_builder.dart';
import 'package:wins_app/blocs/global_bloc.dart';
import 'package:wins_app/blocs/goods_issue_mixing/list/goods_issue_mixing_list_bloc.dart';
import 'package:wins_app/blocs/goods_issue_mixing/list/goods_issue_mixing_list_event.dart';
import 'package:wins_app/blocs/goods_issue_mixing/list/goods_issue_mixing_list_state.dart';
import 'package:wins_app/pages/goods_issue_mixing/goods_issue_mixing_detail_page.dart';
import 'package:intl/intl.dart';
import 'package:wins_app/widgets/set_colors.dart';

class GoodsIssueMixingListPage extends StatefulWidget {
  GoodsIssueMixingListPage(this._id);
  final int _id;
  @override
  _GoodsIssueMixingListPageState createState() =>
      _GoodsIssueMixingListPageState(_id);
}

class _GoodsIssueMixingListPageState extends State<GoodsIssueMixingListPage> {
  _GoodsIssueMixingListPageState(this._id);

  GoodsIssueMixingListBloc bloc = GoodsIssueMixingListBloc();
  ScrollController _scrollController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final int _id;
  static const offsetVisibleThreshold = 50;

  final TextEditingController _searchQueryController = TextEditingController();
  Timer _debounce;

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 2000), () {
      var state = bloc.lastState ?? bloc.initialState;
      bloc.emitEvent(GoodsIssueMixingListEvent(
        event: GoodsIssueMixingListEventType.firstPage,
        searchQuery: _searchQueryController.text,
        woId: _id,
      ));
    });
  }

  void _onScroll() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      bloc.emitEvent(GoodsIssueMixingListEvent(
        event: GoodsIssueMixingListEventType.nextPage,
        searchQuery: _searchQueryController.text,
        woId: _id,
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    print("nilai id: $_id");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.emitEvent(GoodsIssueMixingListEvent(
        event: GoodsIssueMixingListEventType.firstPage,
        searchQuery: _searchQueryController.text,
        woId: _id,
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
          autofocus: true,
          controller: _searchQueryController,
          decoration: InputDecoration(
              hintText: "Search Receipt",
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
                bloc.emitEvent(GoodsIssueMixingListEvent(
                  event: GoodsIssueMixingListEventType.deactivedSearch,
                  searchQuery: _searchQueryController.text,
                ));
              }),
        ],
      );
    } else {
      return AppBar(
        title: Text("List Mixing"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: bgGradientAppBar,
          ),
        ),
        //ackgroundColor: Colors.blue[500],
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
              bloc.emitEvent(GoodsIssueMixingListEvent(
                event: GoodsIssueMixingListEventType.activedSearch,
              ));
            },
          ),
          (globalBloc.loginResponse.data.goodsIssueMixing_Auth_Add == 'Y')
              ? IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return GoodsIssueMixingDetailPage(0);
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
    bloc.emitEvent(GoodsIssueMixingListEvent(
      event: GoodsIssueMixingListEventType.refresh,
      searchQuery: _searchQueryController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<GoodsIssueMixingListState>(
        bloc: bloc,
        builder: (BuildContext context, GoodsIssueMixingListState state) {
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
        // int rowIndex = data.length - index;
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
                title: data[index].recordNo > 0
                    ? Text("No. ${data[index].recordNo}")
                    : Text(
                        ""), //"No. ${data[index].transNo} (${data[index].id.toString()}) ")
                subtitle: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Text("Scan No. : ${data[index].transNo}"),
                    Text(
                        "Issue Date : ${DateFormat('dd/MM/yyyy').format(data[index].transDate)}"),
                    Text("Production No. : ${data[index].woNo}"),
                    Text("Product : ${data[index].productCode}"),
                    Text("Product Name : ${data[index].productName}"),
                    Text("User : ${data[index].createdUser}"),
                    Text("Status : ${data[index].status}"),
                  ],
                ),
                // leading: ClipOval(
                //   child: Image.network(
                //     globalBloc.getUrl() +
                //         "api/UserApi/GetImage?id=${data[index].userId}",
                //     width: 50.0,
                //     height: 50.0,
                //   ),
                // ),

                trailing: Icon(Icons.keyboard_arrow_right),
                //color: Colors.white, size: 30.0),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          GoodsIssueMixingDetailPage(data[index].id),
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
