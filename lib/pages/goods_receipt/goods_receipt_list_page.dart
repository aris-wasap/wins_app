import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wins_app/bloc_widgets/bloc_state_builder.dart';
import 'package:wins_app/blocs/global_bloc.dart';
import 'package:wins_app/blocs/goods_receipt/list/goods_receipt_list_bloc.dart';
import 'package:wins_app/blocs/goods_receipt/list/goods_receipt_list_event.dart';
import 'package:wins_app/blocs/goods_receipt/list/goods_receipt_list_state.dart';
import 'package:wins_app/pages/goods_receipt/goods_receipt_detail_page.dart';
import 'package:intl/intl.dart';
import 'package:wins_app/widgets/set_colors.dart';

class GoodsReceiptListPage extends StatefulWidget {
  GoodsReceiptListPage(this._id);
  final int _id;
  @override
  _GoodsReceiptListPageState createState() => _GoodsReceiptListPageState(_id);
}

class _GoodsReceiptListPageState extends State<GoodsReceiptListPage> {
  _GoodsReceiptListPageState(this._id);

  GoodsReceiptListBloc bloc = GoodsReceiptListBloc();
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
      bloc.emitEvent(GoodsReceiptListEvent(
        event: GoodsReceiptListEventType.firstPage,
        searchQuery: _searchQueryController.text,
        woId: _id,
      ));
    });
  }

  void _onScroll() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      bloc.emitEvent(GoodsReceiptListEvent(
        event: GoodsReceiptListEventType.nextPage,
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
      bloc.emitEvent(GoodsReceiptListEvent(
        event: GoodsReceiptListEventType.firstPage,
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
                bloc.emitEvent(GoodsReceiptListEvent(
                  event: GoodsReceiptListEventType.deactivedSearch,
                  searchQuery: _searchQueryController.text,
                ));
              }),
        ],
      );
    } else {
      return AppBar(
        title: Text("List Receipt Production"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: bgGradientAppBar,
          ),
        ),
        //ackgroundColor: Colors.blue[500],
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
              bloc.emitEvent(GoodsReceiptListEvent(
                event: GoodsReceiptListEventType.activedSearch,
              ));
            },
          ),
          (globalBloc.loginResponse.data.goodsReceipt_Auth_Add == 'Y')
              ? IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return GoodsReceiptDetailPage(0);
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
    bloc.emitEvent(GoodsReceiptListEvent(
      event: GoodsReceiptListEventType.refresh,
      searchQuery: _searchQueryController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<GoodsReceiptListState>(
        bloc: bloc,
        builder: (BuildContext context, GoodsReceiptListState state) {
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
                    "Scan No. : ${data[index].transNo} - ${DateFormat('dd/MM/yyyy').format(data[index].transDate)}"),
                subtitle: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Text(
                    //     "Goods Receipt No. : ${data[index].sapGoodsReceiptNo}"),
                    Text("Production No. : ${data[index].woNo}"),
                    Text(
                        "Product : ${data[index].productCode} - ${data[index].productName}"),
                    Text("Depo : ${data[index].branchName}"),
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
                //   ),
                // ),

                trailing: Icon(Icons.keyboard_arrow_right),
                //color: Colors.white, size: 30.0),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          GoodsReceiptDetailPage(data[index].id),
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
