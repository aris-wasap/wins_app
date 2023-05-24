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
                            onTap: () {
                              // //Wins - InActive - Production
                              // if (filteredMenuList[index]["authDetail"] ==
                              //         "transferProduction_Auth_Detail" &&
                              //     globalBloc.loginResponse.data
                              //             .transferProduction_Auth_Detail ==
                              //         'Y') {
                              //   Navigator.push(context, MaterialPageRoute(
                              //       builder: (BuildContext context) {
                              //     return TransferProductionListPage();
                              //   }));
                              // } else if (filteredMenuList[index]
                              //             ["authDetail"] ==
                              //         "goodsIssue_Auth_Detail" &&
                              //     globalBloc.loginResponse.data
                              //             .goodsIssue_Auth_Detail ==
                              //         'Y') {
                              //   Navigator.push(context, MaterialPageRoute(
                              //       builder: (BuildContext context) {
                              //     return GoodsIssueWOListPage();
                              //   }));
                              // } else if (filteredMenuList[index]
                              //             ["authDetail"] ==
                              //         "goodsIssueMixing_Auth_Detail" &&
                              //     globalBloc.loginResponse.data
                              //             .goodsIssue_Auth_Detail ==
                              //         'Y') {
                              //   Navigator.push(context, MaterialPageRoute(
                              //       builder: (BuildContext context) {
                              //     return GoodsIssueMixingWOListPage();
                              //   }));
                              // } else if (filteredMenuList[index]
                              //             ["authDetail"] ==
                              //         "goodsReceipt_Auth_Detail" &&
                              //     globalBloc.loginResponse.data
                              //             .goodsReceipt_Auth_Detail ==
                              //         'Y') {
                              //   Navigator.push(context, MaterialPageRoute(
                              //       builder: (BuildContext context) {
                              //     return GoodsReceiptWOListPage();
                              //   }));
                              // }

                              // // Change Product
                              // //else
                              // if (filteredMenuList[index]["authDetail"] ==
                              //         "requestIssue_Auth_Detail" &&
                              //     globalBloc.loginResponse.data
                              //             .requestIssue_Auth_Detail ==
                              //         'Y') {
                              //   Navigator.push(context, MaterialPageRoute(
                              //       builder: (BuildContext context) {
                              //     return RequestIssueListPage();
                              //   }));
                              // } else if (filteredMenuList[index]
                              //             ["authDetail"] ==
                              //         "receiptIssue_Auth_Detail" &&
                              //     globalBloc.loginResponse.data
                              //             .receiptIssue_Auth_Detail ==
                              //         'Y') {
                              //   Navigator.push(context, MaterialPageRoute(
                              //       builder: (BuildContext context) {
                              //     return ReceiptIssueListPage();
                              //   }));
                              // }

                              // //Transfer To Branch
                              // else if (filteredMenuList[index]
                              //             ["authDetail"] ==
                              //         "transferBranch_Auth_Detail" &&
                              //     globalBloc.loginResponse.data
                              //             .transferBranch_Auth_Detail ==
                              //         'Y') {
                              //   Navigator.push(context, MaterialPageRoute(
                              //       builder: (BuildContext context) {
                              //     return TransferBranchListPage();
                              //   }));
                              // }
                              // //Receipt From Branch
                              // else if (filteredMenuList[index]
                              //             ["authDetail"] ==
                              //         "receiptBranch_Auth_Detail" &&
                              //     globalBloc.loginResponse.data
                              //             .receiptBranch_Auth_Detail ==
                              //         'Y') {
                              //   Navigator.push(context, MaterialPageRoute(
                              //       builder: (BuildContext context) {
                              //     return ReceiptBranchListPage();
                              //   }));
                              // }
                              // // Transfer Item From To Warehouse
                              // else if (filteredMenuList[index]
                              //             ["authDetail"] ==
                              //         "inventoryTransfer_Auth_Detail" &&
                              //     globalBloc.loginResponse.data
                              //             .inventoryTransfer_Auth_Detail ==
                              //         'Y') {
                              //   Navigator.push(context, MaterialPageRoute(
                              //       builder: (BuildContext context) {
                              //     return InventoryTransferListPage();
                              //   }));
                              // }
                              // // A/R Sales
                              // else if (filteredMenuList[index]
                              //             ["authDetail"] ==
                              //         "deliveryOrder_Auth_Detail" &&
                              //     globalBloc.loginResponse.data
                              //             .deliveryOrder_Auth_Detail ==
                              //         'Y') {
                              //   Navigator.push(context, MaterialPageRoute(
                              //       builder: (BuildContext context) {
                              //     return DeliveryOrderListPage();
                              //   }));
                              // } else if (filteredMenuList[index]
                              //             ["authDetail"] ==
                              //         "returnSales_Auth_Detail" &&
                              //     globalBloc.loginResponse.data
                              //             .returnSales_Auth_Detail ==
                              //         'Y') {
                              //   Navigator.push(context, MaterialPageRoute(
                              //       builder: (BuildContext context) {
                              //     return ReturnSalesListPage();
                              //   }));
                              // } else if (filteredMenuList[index]
                              //             ["authDetail"] ==
                              //         "receivableCredit_Auth_Detail" &&
                              //     globalBloc.loginResponse.data
                              //             .receivableCredit_Auth_Detail ==
                              //         'Y') {
                              //   Navigator.push(context, MaterialPageRoute(
                              //       builder: (BuildContext context) {
                              //     return ReceivableCreditListPage();
                              //   }));
                              // }

                              // //A/P Purchase
                              // else if (filteredMenuList[index]
                              //             ["authDetail"] ==
                              //         "receiptOrder_Auth_Detail" &&
                              //     globalBloc.loginResponse.data
                              //             .receiptOrder_Auth_Detail ==
                              //         'Y') {
                              //   Navigator.push(context, MaterialPageRoute(
                              //       builder: (BuildContext context) {
                              //     return ReceiptOrderListPage();
                              //   }));
                              // } else if (filteredMenuList[index]
                              //             ["authDetail"] ==
                              //         "receiptSupplier_Auth_Detail" &&
                              //     globalBloc.loginResponse.data
                              //             .receiptSupplier_Auth_Detail ==
                              //         'Y') {
                              //   Navigator.push(context, MaterialPageRoute(
                              //       builder: (BuildContext context) {
                              //     return ReceiptSupplierListPage();
                              //   }));
                              // } else if (filteredMenuList[index]
                              //             ["authDetail"] ==
                              //         "purchaseReturns_Auth_Detail" &&
                              //     globalBloc.loginResponse.data
                              //             .purchaseReturns_Auth_Detail ==
                              //         'Y') {
                              //   Navigator.push(context, MaterialPageRoute(
                              //       builder: (BuildContext context) {
                              //     return PurchaseReturnsListPage();
                              //   }));
                              // } else if (filteredMenuList[index]
                              //             ["authDetail"] ==
                              //         "payableCredit_Auth_Detail" &&
                              //     globalBloc.loginResponse.data
                              //             .payableCredit_Auth_Detail ==
                              //         'Y') {
                              //   Navigator.push(context, MaterialPageRoute(
                              //       builder: (BuildContext context) {
                              //     return PayableCreditListPage();
                              //   }));
                              // }
                            },
                            // child: Column(
                            //   children: <Widget>[
                            //     SizedBox(
                            //       height: 5.0,
                            //     ),
                            //     Container(
                            //       height: 45,
                            //       child: Image.asset(
                            //         filteredMenuList[index]["icon"],
                            //         height: 30,
                            //         width: 30,
                            //       ),
                            //     ),
                            //     Container(
                            //       height: 35,
                            //       child: ListTile(
                            //         title: Text(
                            //           //data.title,
                            //           filteredMenuList[index]["title"],
                            //           textAlign: TextAlign.center,
                            //           style: GoogleFonts.openSans(
                            //               textStyle: TextStyle(
                            //                   color: Colors.black,
                            //                   fontSize: 10,
                            //                   fontWeight:
                            //                       FontWeight.w900)),
                            //         ),
                            //       ),
                            //     ),
                            //     // Container(
                            //     //   height: 30,
                            //     //   //color: Colors.white10,
                            //     //   child: ListTile(
                            //     //     title: Text(
                            //     //       filteredMenuList[index]["subtitle"],
                            //     //       textAlign: TextAlign.center,
                            //     //       style: GoogleFonts.openSans(
                            //     //           textStyle: TextStyle(
                            //     //               color: Colors.black87,
                            //     //               fontSize: 8,
                            //     //               fontWeight:
                            //     //                   FontWeight.w400)),
                            //     //     ),
                            //     //   ),
                            //     // )
                            //   ],
                            // ),
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
