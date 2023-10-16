import 'package:wins_app/pages/goods_issue/goods_issue_wo_list_page.dart';
import 'package:wins_app/pages/goods_issue_mixing/goods_issue_mixing_wo_list_page.dart';
import 'package:wins_app/pages/goods_receipt/goods_receipt_wo_list_page.dart';
import 'package:wins_app/pages/payable_credit/payable_credit_list_page.dart';
import 'package:wins_app/pages/receipt_branch/receipt_branch_list_page.dart';
import 'package:wins_app/pages/receivable_credit/receivable_credit_list_page.dart';
import 'package:wins_app/pages/transfer_branch/transfer_branch_list_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wins_app/blocs/global_bloc.dart';
//import 'package:wins_app/pages/dashboard_menu.dart';
import 'package:wins_app/pages/delivery_order/delivery_order_list_page.dart';
import 'package:wins_app/pages/purchase_returns/purchase_returns_list_page.dart';
import 'package:wins_app/pages/receipt_supplier/receipt_supplier_list_page.dart';
import 'package:wins_app/pages/request_issue/request_issue_list_page.dart';
import 'package:wins_app/pages/return_sales/return_sales_list_page.dart';
import 'package:wins_app/pages/inventory_transfer/inventory_transfer_list_page.dart';
//import 'package:wins_app/pages/option_card.dart';
import 'package:wins_app/pages/receipt_issue/receipt_issue_list_page.dart';
import 'package:wins_app/pages/receipt_order/receipt_order_list_page.dart';
import 'package:wins_app/pages/transfer_production/transfer_production_list_page.dart';
import 'package:wins_app/theme.dart';
import 'package:wins_app/widgets/set_colors.dart';

import '../list_menu.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    final menuBloc = MenuBloc();
    // var mediaQueryData = MediaQuery.of(context);
    //final double widthScreen = mediaQueryData.size.width;
    //final double heightScreen = mediaQueryData.size.height;

    menuBloc.fetchData();
    return StreamBuilder<Object>(
      stream: menuBloc.menuStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, List<Map<String, dynamic>>> menuList = snapshot.data;

          // Filter list menu sesuai dengan otorisasi user yang diberikan
          Map<String, List<Map<String, dynamic>>> filteredMenuList = {};

          for (String key in menuList.keys) {
            List<Map<String, dynamic>> filteredSubmenuList =
                menuList[key].where((item) => item["isAccess"] == "Y").toList();
            if (filteredSubmenuList.isNotEmpty) {
              filteredMenuList[key] = filteredSubmenuList;
            }
          }

          @override
          void initState() {
            super.initState();
            _tabController =
                TabController(length: filteredMenuList.length, vsync: this);
          }

          @override
          void dispose() {
            _tabController.dispose();
            super.dispose();
          }

          // return SliverMenu(filteredMenuList: filteredMenuList);
          return DefaultTabController(
            length: filteredMenuList.length,
            child: Scaffold(
              // appBar: AppBar(
              //   title: Text("Daftar Menu"),
              //   // bottom:
              // ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TabBar(
                    isScrollable: true,
                    controller: _tabController,
                    indicatorWeight: 4,
                    labelColor: dongker,
                    labelStyle: tabTitleTextStyle,
                    unselectedLabelColor: Colors.grey,
                    indicator: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: dongker,
                          width: 4.0,
                        ),
                      ),
                      color: Colors.blue[50], // Mengatur border radius
                    ),
                    indicatorColor: dongker,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: filteredMenuList.keys.map((String key) {
                      return Tab(
                        // text: key,
                        child: Column(
                          children: <Widget>[
                            Text(
                              "${key}",
                              style: TextStyle(color: Colors.blue[900]),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: filteredMenuList.keys.map((String key) {
                        return ListView.builder(
                          itemCount: filteredMenuList[key].length,
                          itemBuilder: (BuildContext context, int subIndex) {
                            Map<String, dynamic> item =
                                filteredMenuList[key][subIndex];
                            return ListTile(
                              leading: Image.asset(
                                item["icon"],
                                height: 40,
                                width: 40,
                              ),
                              title: Text(item["title"]),
                              subtitle: Text(item["subtitle"]),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class SliverMenu extends StatelessWidget {
  SliverMenu({
    Key key,
    @required this.filteredMenuList,
  }) : super(key: key);

  final Map<String, List<Map<String, dynamic>>> filteredMenuList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(right: 2.0, left: 3.0, bottom: 10.0, top: 2.0),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.all(10),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              delegate: SliverChildBuilderDelegate((context, index) {
                return Center(
                  child: Container(
                      decoration: BoxDecoration(
                          //image : DecorationImage(image: AssetImage("assets/images/15.jpg"), fit: BoxFit.fill),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(4, 4),
                                blurRadius: 2),
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(-4, -4),
                                blurRadius: 2),
                          ],
                          color: bgWhite,
                          borderRadius: BorderRadius.circular(10)),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Material(
                          child: InkWell(
                            onTap: () {},
                          ),
                        ),
                      )),
                );
              }, childCount: filteredMenuList.length),
            ),
          ),
        ],
      ),
    );
  }
}
