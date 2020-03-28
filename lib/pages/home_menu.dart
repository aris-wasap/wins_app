import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ncf_app/blocs/global_bloc.dart';
import 'package:ncf_app/pages/dashboard_menu.dart';
import 'package:ncf_app/pages/delivery_order/delivery_order_list_page.dart';
import 'package:ncf_app/pages/return_sales/return_sales_list_page.dart';
import 'package:ncf_app/pages/inventory_transfer/inventory_transfer_list_page.dart';
import 'package:ncf_app/pages/option_card.dart';
import 'package:ncf_app/pages/receipt_issue/receipt_issue_list_page.dart';
import 'package:ncf_app/pages/receipt_order/receipt_order_list_page.dart';
import 'package:ncf_app/pages/receipt_production/receipt_production_list_page.dart';
import 'package:ncf_app/widgets/set_colors.dart';

class HomeMenuPage extends StatefulWidget {
  @override
  _HomeMenuPageState createState() => _HomeMenuPageState();
}

class Items {
  String title;
  String subtitle;
  String icon;
  String authDetail;
  Items({this.title, this.subtitle, this.icon, this.authDetail});
}

class _HomeMenuPageState extends State<HomeMenuPage> {
  Items item1 = new Items(
    title: "Receipt From Production",
    subtitle: "List Receipt, Scan Receipt",
    icon: "assets/images/receipt.png",
    authDetail: "receiptProduction_Auth_Detail",
  );

  Items item2 = new Items(
    title: "Receipt From Issue",
    subtitle: "List Receipt, Scan Receipt",
    icon: "assets/images/receipt_issue.png",
    authDetail: "receiptIssue_Auth_Detail",
  );

  Items item3 = new Items(
    title: "Receipt From QR Label",
    subtitle: "List Receipt, Scan Receipt",
    icon: "assets/images/receipt_po.png",
    authDetail: "receiptOrder_Auth_Detail",
  );

  Items item4 = new Items(
    title: "Inventory Transfer",
    subtitle: "List Inventory, Scan Item",
    icon: "assets/images/transfer.png",
    authDetail: "inventoryTransfer_Auth_Detail",
  );

  Items item5 = new Items(
    title: "Delivery Order",
    subtitle: "List Delivery, Scan Item",
    icon: "assets/images/delivery.png",
    authDetail: "deliveryOrder_Auth_Detail",
  );

  Items item6 = new Items(
    title: "Return",
    subtitle: "List Return, Scan Item",
    icon: "assets/images/return.png",
    authDetail: "returnSales_Auth_Detail",
  );

  Items item7 = new Items(
    title: "Receipt Supplier Barcode",
    subtitle: "List Receipt, Scan Receipt",
    icon: "assets/images/receipt_po.png",
    authDetail: "receiptOrder_Auth_Detail",
  );

  Widget dashboardMenuSliverGrid(BuildContext context) {
    List<Items> myList = [item1, item3, item7, item2, item4, item5, item6];
    return Flexible(
      child: SliverGrid.count(
          crossAxisCount: 2,
          children: myList.map((data) {
            return Container(
              //height: 100,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black26, offset: Offset(4, 4), blurRadius: 2),
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(-4, -4),
                    blurRadius: 2),
              ], color: bgWhite, borderRadius: BorderRadius.circular(10)),
              child: Material(
                  color: bgWhite,
                  borderRadius: BorderRadius.circular(10.0),
                  child: InkWell(
                    onTap: () {
                      //1
                      if (data.authDetail == "receiptProduction_Auth_Detail" &&
                          globalBloc.loginResponse.data
                                  .receiptProduction_Auth_Detail ==
                              'Y') {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return ReceiptProductionListPage();
                        }));
                      }
                      //2
                      else if (data.authDetail == "receiptIssue_Auth_Detail" &&
                          globalBloc.loginResponse.data
                                  .receiptIssue_Auth_Detail ==
                              'Y') {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return ReceiptIssueListPage();
                        }));
                      }
                      //3
                      else if (data.authDetail == "receiptOrder_Auth_Detail" &&
                          globalBloc.loginResponse.data
                                  .receiptOrder_Auth_Detail ==
                              'Y') {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return ReceiptOrderListPage();
                        }));
                      }
                      //4
                      else if (data.authDetail ==
                              "inventoryTransfer_Auth_Detail" &&
                          globalBloc.loginResponse.data
                                  .inventoryTransfer_Auth_Detail ==
                              'Y') {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return InventoryTransferListPage();
                        }));
                      }
                      //5
                      else if (data.authDetail == "deliveryOrder_Auth_Detail" &&
                          globalBloc.loginResponse.data
                                  .deliveryOrder_Auth_Detail ==
                              'Y') {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return DeliveryOrderListPage();
                        }));
                      }
                      //6
                      else if (data.authDetail == "returnSales_Auth_Detail" &&
                          globalBloc
                                  .loginResponse.data.returnSales_Auth_Detail ==
                              'Y') {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return ReturnSalesListPage();
                        }));
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          data.icon,
                          height: 45,
                          width: 45,
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          data.title,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          data.subtitle,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  )),
            );
          }).toList()),
    );
  }

  Widget dashboardMenu(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    final double widthScreen = mediaQueryData.size.width;
    final double heightScreen = mediaQueryData.size.height;
    List<Items> myList = [item1, item3, item7, item2, item4, item5, item6];
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(
              top: 5,
              left: 20,
              right: 20,
              bottom: 5), //only(left: 15, right: 15),
          crossAxisCount: 2,
          crossAxisSpacing: 25,
          mainAxisSpacing: 25,
          children: myList.map((data) {
            return Container(
              //height: 100,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black26, offset: Offset(4, 4), blurRadius: 2),
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(-4, -4),
                    blurRadius: 2),
              ], color: bgWhite, borderRadius: BorderRadius.circular(10)),
              child: Material(
                  color: bgWhite,
                  borderRadius: BorderRadius.circular(10.0),
                  child: InkWell(
                    onTap: () {
                      //1
                      if (data.authDetail == "receiptProduction_Auth_Detail" &&
                          globalBloc.loginResponse.data
                                  .receiptProduction_Auth_Detail ==
                              'Y') {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return ReceiptProductionListPage();
                        }));
                      }
                      //2
                      else if (data.authDetail == "receiptIssue_Auth_Detail" &&
                          globalBloc.loginResponse.data
                                  .receiptIssue_Auth_Detail ==
                              'Y') {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return ReceiptIssueListPage();
                        }));
                      }
                      //3
                      else if (data.authDetail == "receiptOrder_Auth_Detail" &&
                          globalBloc.loginResponse.data
                                  .receiptOrder_Auth_Detail ==
                              'Y') {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return ReceiptOrderListPage();
                        }));
                      }
                      //4
                      else if (data.authDetail ==
                              "inventoryTransfer_Auth_Detail" &&
                          globalBloc.loginResponse.data
                                  .inventoryTransfer_Auth_Detail ==
                              'Y') {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return InventoryTransferListPage();
                        }));
                      }
                      //5
                      else if (data.authDetail == "deliveryOrder_Auth_Detail" &&
                          globalBloc.loginResponse.data
                                  .deliveryOrder_Auth_Detail ==
                              'Y') {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return DeliveryOrderListPage();
                        }));
                      }
                      //6
                      else if (data.authDetail == "returnSales_Auth_Detail" &&
                          globalBloc
                                  .loginResponse.data.returnSales_Auth_Detail ==
                              'Y') {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return ReturnSalesListPage();
                        }));
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          data.icon,
                          height: 45,
                          width: 45,
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          data.title,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                        ),
                        // SizedBox(
                        //   height: 8,
                        // ),
                        // Text(
                        //   data.subtitle,
                        //   textAlign: TextAlign.center,
                        //   style: GoogleFonts.openSans(
                        //       textStyle: TextStyle(
                        //           color: Colors.white38,
                        //           fontSize: 10,
                        //           fontWeight: FontWeight.w600)),
                        // ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          data.subtitle,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  )),
            );
          }).toList()),
    );
  }

  Widget buildOptions() {
    return Container(
      height: 100,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        children: <Widget>[
          GridTile(
            child: OptionCard(
                'Receipt From Production', 'assets/images/receipt.png', () {
              if (globalBloc.loginResponse.data.receiptProduction_Auth_Detail ==
                  'Y') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return ReceiptProductionListPage();
                }));
              }
            }),
          ),
          GridTile(
            child: OptionCard(
                'Receipt From Issue', 'assets/images/receipt_issue.png', () {
              if (globalBloc.loginResponse.data.receiptIssue_Auth_Detail ==
                  'Y') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return ReceiptIssueListPage();
                }));
              }
            }),
          ),
          GridTile(
            child: OptionCard(
                'Receipt From Purchase Order', 'assets/images/receipt_po.png',
                () {
              if (globalBloc.loginResponse.data.receiptOrder_Auth_Detail ==
                  'Y') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return ReceiptOrderListPage();
                }));
              }
            }),
          ),
          GridTile(
            child: OptionCard(
                'Inventory Transfer', 'assets/images/transfer.png', () {
              if (globalBloc.loginResponse.data.inventoryTransfer_Auth_Detail ==
                  'Y') {
                // Navigator.push(context, MaterialPageRoute(
                //     builder: (BuildContext context) {
                //   return InventoryTransferListPage();
                // }));
              }
            }),
          ),
          GridTile(
            child: OptionCard('Delivery', 'assets/images/delivery.png', () {
              if (globalBloc.loginResponse.data.deliveryOrder_Auth_Detail ==
                  'Y') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return DeliveryOrderListPage();
                }));
              }
            }),
          ),
          GridTile(
            child: OptionCard('Return', 'assets/images/return.png', () {
              if (globalBloc.loginResponse.data.returnSales_Auth_Detail ==
                  'Y') {
                // Navigator.push(context, MaterialPageRoute(
                //     builder: (BuildContext context) {
                //   return ReturnSalesListPage();
                // }));
              }
            }),
          ),
        ],
      ),
    );
  }

  final List<Map> subjectList = [
    {
      "title": "Receipt From Production",
      "subtitle": "List Receipt, Scan Receipt",
      "icon": "assets/images/receipt.png",
      "authDetail": "receiptProduction_Auth_Detail",
    },
    {
      "title": "Receipt From Issue",
      "subtitle": "List Receipt, Scan Receipt",
      "icon": "assets/images/receipt_issue.png",
      "authDetail": "receiptIssue_Auth_Detail",
    },
    {
      "title": "Receipt From QR Label",
      "subtitle": "List Receipt, Scan Receipt",
      "icon": "assets/images/receipt_po.png",
      "authDetail": "receiptOrder_Auth_Detail",
    },
    {
      "title": "Receipt Supplier Barcode",
      "subtitle": "List Receipt, Scan Receipt",
      "icon": "assets/images/receipt_po.png",
      "authDetail": "receiptOrder_Auth_Detail",
    },
    {
      "title": "Inventory Transfer",
      "subtitle": "List Inventory, Scan Item",
      "icon": "assets/images/transfer.png",
      "authDetail": "inventoryTransfer_Auth_Detail",
    },
    {
      "title": "Delivery Order",
      "subtitle": "List Delivery, Scan Item",
      "icon": "assets/images/delivery.png",
      "authDetail": "deliveryOrder_Auth_Detail",
    },
    {
      "title": "Return",
      "subtitle": "List Return, Scan Item",
      "icon": "assets/images/return.png",
      "authDetail": "returnSales_Auth_Detail",
    }
  ];
  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    final double widthScreen = mediaQueryData.size.width;
    final double heightScreen = mediaQueryData.size.height;
    double sideLength = 50;
    return Padding(
      padding:
          const EdgeInsets.only(right: 2.0, left: 2.0, bottom: 10.0, top: 2.0),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: Colors.black26, offset: Offset(4, 4), blurRadius: 2),
          BoxShadow(
              color: Colors.black12, offset: Offset(-4, -4), blurRadius: 2),
        ], color: bgWhite, borderRadius: BorderRadius.circular(10)),
        child: Card(
          color: Colors.blue[100],
          child: CustomScrollView(
            slivers: <Widget>[
              SliverPadding(
                padding: EdgeInsets.all(10),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Center(
                      child: Container(
                          decoration: BoxDecoration(
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
                                  //1
                                  if (subjectList[index]["authDetail"] ==
                                          "receiptProduction_Auth_Detail" &&
                                      globalBloc.loginResponse.data
                                              .receiptProduction_Auth_Detail ==
                                          'Y') {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return ReceiptProductionListPage();
                                    }));
                                  }
                                  //2
                                  else if (subjectList[index]["authDetail"] ==
                                          "receiptIssue_Auth_Detail" &&
                                      globalBloc.loginResponse.data
                                              .receiptIssue_Auth_Detail ==
                                          'Y') {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return ReceiptIssueListPage();
                                    }));
                                  }
                                  //3
                                  else if (subjectList[index]["authDetail"] ==
                                          "receiptOrder_Auth_Detail" &&
                                      globalBloc.loginResponse.data
                                              .receiptOrder_Auth_Detail ==
                                          'Y') {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return ReceiptOrderListPage();
                                    }));
                                  }
                                  //4
                                  else if (subjectList[index]["authDetail"] ==
                                          "inventoryTransfer_Auth_Detail" &&
                                      globalBloc.loginResponse.data
                                              .inventoryTransfer_Auth_Detail ==
                                          'Y') {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return InventoryTransferListPage();
                                    }));
                                  }
                                  //5
                                  else if (subjectList[index]["authDetail"] ==
                                          "deliveryOrder_Auth_Detail" &&
                                      globalBloc.loginResponse.data
                                              .deliveryOrder_Auth_Detail ==
                                          'Y') {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return DeliveryOrderListPage();
                                    }));
                                  }
                                  //6 data.authDetail
                                  else if (subjectList[index]["authDetail"] ==
                                          "returnSales_Auth_Detail" &&
                                      globalBloc.loginResponse.data
                                              .returnSales_Auth_Detail ==
                                          'Y') {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return ReturnSalesListPage();
                                    }));
                                  }
                                },
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 52,
                                      child: Image.asset(
                                        subjectList[index]["icon"],
                                        height: 45,
                                        width: 45,
                                      ),
                                    ),
                                    Container(
                                      height: 35,
                                      child: ListTile(
                                        title: Text(
                                          //data.title,
                                          subjectList[index]["title"],
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.openSans(
                                              textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      //color: Colors.white10,
                                      child: ListTile(
                                        title: Text(
                                          subjectList[index]["subtitle"],
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.openSans(
                                              textStyle: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )

                          // decoration: BoxDecoration(boxShadow: [
                          //   BoxShadow(
                          //       color: Colors.black26,
                          //       offset: Offset(4, 4),
                          //       blurRadius: 2),
                          //   BoxShadow(
                          //       color: Colors.black12,
                          //       offset: Offset(-4, -4),
                          //       blurRadius: 2),
                          // ], color: bgWhite, borderRadius: BorderRadius.circular(10)),
                          // child: Material(
                          //     color: bgWhite,
                          //     borderRadius: BorderRadius.circular(10.0),
                          //     child: InkWell(
                          //       onTap: () {
                          //         //1
                          //         if (subjectList[index]["authDetail"] ==
                          //                 "receiptProduction_Auth_Detail" &&
                          //             globalBloc.loginResponse.data
                          //                     .receiptProduction_Auth_Detail ==
                          //                 'Y') {
                          //           Navigator.push(context, MaterialPageRoute(
                          //               builder: (BuildContext context) {
                          //             return ReceiptProductionListPage();
                          //           }));
                          //         }
                          //         //2
                          //         else if (subjectList[index]["authDetail"] ==
                          //                 "receiptIssue_Auth_Detail" &&
                          //             globalBloc.loginResponse.data
                          //                     .receiptIssue_Auth_Detail ==
                          //                 'Y') {
                          //           Navigator.push(context, MaterialPageRoute(
                          //               builder: (BuildContext context) {
                          //             return ReceiptIssueListPage();
                          //           }));
                          //         }
                          //         //3
                          //         else if (subjectList[index]["authDetail"] ==
                          //                 "receiptOrder_Auth_Detail" &&
                          //             globalBloc.loginResponse.data
                          //                     .receiptOrder_Auth_Detail ==
                          //                 'Y') {
                          //           Navigator.push(context, MaterialPageRoute(
                          //               builder: (BuildContext context) {
                          //             return ReceiptOrderListPage();
                          //           }));
                          //         }
                          //         //4
                          //         else if (subjectList[index]["authDetail"] ==
                          //                 "inventoryTransfer_Auth_Detail" &&
                          //             globalBloc.loginResponse.data
                          //                     .inventoryTransfer_Auth_Detail ==
                          //                 'Y') {
                          //           Navigator.push(context, MaterialPageRoute(
                          //               builder: (BuildContext context) {
                          //             return InventoryTransferListPage();
                          //           }));
                          //         }
                          //         //5
                          //         else if (subjectList[index]["authDetail"] ==
                          //                 "deliveryOrder_Auth_Detail" &&
                          //             globalBloc.loginResponse.data
                          //                     .deliveryOrder_Auth_Detail ==
                          //                 'Y') {
                          //           Navigator.push(context, MaterialPageRoute(
                          //               builder: (BuildContext context) {
                          //             return DeliveryOrderListPage();
                          //           }));
                          //         }
                          //         //6 data.authDetail
                          //         else if (subjectList[index]["authDetail"] ==
                          //                 "returnSales_Auth_Detail" &&
                          //             globalBloc.loginResponse.data
                          //                     .returnSales_Auth_Detail ==
                          //                 'Y') {
                          //           Navigator.push(context, MaterialPageRoute(
                          //               builder: (BuildContext context) {
                          //             return ReturnSalesListPage();
                          //           }));
                          //         }
                          //       },
                          //       child: Column(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: <Widget>[
                          //           Image.asset(
                          //             //data.icon,
                          //             subjectList[index]["icon"],
                          //             height: 30,
                          //             width: 45,
                          //           ),
                          //           SizedBox(
                          //             height: 14,
                          //           ),
                          //           Text(
                          //             //data.title,
                          //             subjectList[index]["title"],
                          //             textAlign: TextAlign.center,
                          //             style: GoogleFonts.openSans(
                          //                 textStyle: TextStyle(
                          //                     color: Colors.black,
                          //                     fontSize: 16,
                          //                     fontWeight: FontWeight.w600)),
                          //           ),

                          //           SizedBox(
                          //             height: 14,
                          //           ),
                          //           Text(
                          //             //data.subtitle,
                          //             subjectList[index]["subtitle"],
                          //             textAlign: TextAlign.center,
                          //             style: GoogleFonts.openSans(
                          //                 textStyle: TextStyle(
                          //                     color: Colors.black87,
                          //                     fontSize: 11,
                          //                     fontWeight: FontWeight.w600)),
                          //           ),
                          //         ],
                          //       ),
                          //     )),
                          ),
                    );
                  }, childCount: subjectList.length),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // return  Column(
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   mainAxisSize: MainAxisSize.min,
    //   children: <Widget>[
    //     dashboardMenu(context),
    //     //SizedBox(height: 5,),
    //     //SizedBox(height: 2,),
    //     ////GridDashboard(),
    //     //  Flexible(
    //     //   flex: 4,
    //     //   child: Padding(
    //     //     padding: EdgeInsets.all(0.0),

    //     //     child: Container(
    //     //     margin: EdgeInsets.all(0.0),
    //     //     height: heightScreen,
    //     //     decoration: BoxDecoration(
    //     //       gradient: LinearGradient(
    //     //         colors: [
    //     //           const Color(0xFFFD0E1F9),
    //     //           const Color(0xFFFD0E1F9),
    //     //           ],
    //     //         begin: Alignment.topCenter,
    //     //         end: Alignment.bottomCenter,
    //     //       )
    //     //     ),
    //     //     child: GridView.count(
    //     //         crossAxisCount: 1,
    //     //         children: <Widget>[
    //     //           buildOptions(),
    //     //         ],
    //     //     ),

    //     //   )
    //     //   ),
    //     // )
    //   ],

    // );
  }
}
