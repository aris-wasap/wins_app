import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wins_app/bloc_widgets/bloc_state_builder.dart';
import 'package:wins_app/blocs/cfl_binlocation/cfl_binlocation_bloc.dart';
import 'package:wins_app/blocs/cfl_binlocation/cfl_binlocation_event.dart';
import 'package:wins_app/blocs/cfl_binlocation/cfl_binlocation_state.dart';
import 'package:intl/intl.dart';
import 'package:wins_app/models/cfl_binlocation_response.dart';
import 'package:wins_app/widgets/set_colors.dart';

class CflBinLocationPage extends StatefulWidget {
  CflBinLocationPage(this.whsCode);
  final String whsCode;
  @override
  _CflBinLocationPageState createState() => _CflBinLocationPageState(whsCode);
}

class _CflBinLocationPageState extends State<CflBinLocationPage> {
  _CflBinLocationPageState(this.whsCode);
  CflBinLocationBloc bloc = CflBinLocationBloc();

  ScrollController _scrollController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  static const offsetVisibleThreshold = 50;
  final String whsCode;
  final TextEditingController _searchQueryController = TextEditingController();
  Timer _debounce;

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 2000), () {
      bloc.emitEvent(CflBinLocationEvent(
        event: CflBinLocationEventType.firstPage,
        searchQuery: _searchQueryController.text,
        whsCode: whsCode,
      ));
    });
  }

  void _onScroll() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      bloc.emitEvent(CflBinLocationEvent(
        event: CflBinLocationEventType.nextPage,
        searchQuery: _searchQueryController.text,
        whsCode: whsCode,
      ));
    }
  }

  @override
  void initState() {
    super.initState();

    bloc.emitEvent(CflBinLocationEvent(
      event: CflBinLocationEventType.firstPage,
      whsCode: whsCode,
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

  PreferredSizeWidget _appBar(CflBinLocationState state) {
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
            hintText: "Search Bin Location",
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: bgBlue,
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
                bloc.emitEvent(CflBinLocationEvent(
                  event: CflBinLocationEventType.deactivedSearch,
                  searchQuery: _searchQueryController.text,
                  whsCode: whsCode,
                ));
              }),
        ],
      );
    } else {
      return AppBar(
        title: Text("Choose Bin Location"),
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
              bloc.emitEvent(CflBinLocationEvent(
                event: CflBinLocationEventType.activedSearch,
                whsCode: whsCode,
              ));
            },
          ),
        ],
      );
    }
  }

  //kalau langsung di inline gak mau karena functionnya harus future
  Future<void> _handleRefresh() async {
    bloc.emitEvent(CflBinLocationEvent(
      event: CflBinLocationEventType.refresh,
      searchQuery: _searchQueryController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<CflBinLocationState>(
        bloc: bloc,
        builder: (BuildContext context, CflBinLocationState state) {
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

  Widget buildList(CflBinLocationState state) {
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
                title: Text("Bin Location ${data[index].binCode} "),
                leading: Icon(Icons.keyboard_arrow_left),
                onTap: () {
                  Navigator.pop(context, data[index]);
                },
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Warehouse. ${data[index].whsCode}"),
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
