import 'package:wins_app/pages/payable_credit/payable_credit_list_page.dart';
import 'package:wins_app/pages/receipt_branch/receipt_branch_list_page.dart';
import 'package:wins_app/pages/receivable_credit/receivable_credit_list_page.dart';
import 'package:wins_app/pages/transfer_branch/transfer_branch_list_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wins_app/blocs/global_bloc.dart';
//import 'package:wins_app/pages/dashboard_menu.dart';
import 'package:wins_app/pages/delivery_order/delivery_order_list_page.dart';
import 'package:wins_app/pages/goods_issue/goods_issue_list_page.dart';
import 'package:wins_app/pages/goods_receipt/goods_receipt_list_page.dart';
import 'package:wins_app/pages/issue_production/issue_production_list_page.dart';
import 'package:wins_app/pages/purchase_returns/purchase_returns_list_page.dart';
import 'package:wins_app/pages/receipt_supplier/receipt_supplier_list_page.dart';
import 'package:wins_app/pages/request_issue/request_issue_list_page.dart';
import 'package:wins_app/pages/return_sales/return_sales_list_page.dart';
import 'package:wins_app/pages/inventory_transfer/inventory_transfer_list_page.dart';
//import 'package:wins_app/pages/option_card.dart';
import 'package:wins_app/pages/receipt_issue/receipt_issue_list_page.dart';
import 'package:wins_app/pages/receipt_order/receipt_order_list_page.dart';
import 'package:wins_app/pages/receipt_production/receipt_production_list_page.dart';
import 'package:wins_app/pages/transfer_production/transfer_production_list_page.dart';
import 'package:wins_app/widgets/set_colors.dart';

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
  final List<Map> subjectList = [
    //Active
    {
      "title": "Inventory Transfer",
      "subtitle": "List Inventory, Scan Item",
      "icon": "assets/images/transfer.png",
      "authDetail": "inventoryTransfer_Auth_Detail",
    },
    // Active
    {
      "title": "Transfer To Depo",
      "subtitle": "List Transfer, Scan Item",
      "icon": "assets/images/transfer_branch.png",
      "authDetail": "transferBranch_Auth_Detail",
    },

    // Active
    {
      "title": "Receipt From Depo",
      "subtitle": "List Receipt, Scan Item",
      "icon": "assets/images/receipt_branch.png",
      "authDetail": "receiptBranch_Auth_Detail",
    },

    //Wins - InActive
    // {
    //   "title": "Transfer For Production Order",
    //   "subtitle": "List Inventory, Scan Item",
    //   "icon": "assets/images/transfer_production.png",
    //   "authDetail": "transferProduction_Auth_Detail",
    // },
    //Wins - InActive
    // {
    //   "title": "Issue For Production",
    //   "subtitle": "List Issue, Scan Item",
    //   "icon": "assets/images/goods_issue.png",
    //   "authDetail": "goodsIssue_Auth_Detail",
    // },
    //Wins - InActive
    // {
    //   "title": "Receipt From Production",
    //   "subtitle": "List Receipt, Scan Receipt",
    //   "icon": "assets/images/goods_receipt.png",
    //   "authDetail": "goodsReceipt_Auth_Detail",
    // },

    // Active
    {
      "title": "Issue Change Product",
      "subtitle": "List Issue, Scan Item",
      "icon": "assets/images/request_issue.png",
      "authDetail": "requestIssue_Auth_Detail",
    },
    // Active
    {
      "title": "Receipt From Change Product",
      "subtitle": "List Receipt, Scan Receipt",
      "icon": "assets/images/receipt_issue.png",
      "authDetail": "receiptIssue_Auth_Detail",
    },
    // Active
    {
      "title": "Receipt From Purchase Order",
      "subtitle": "List Receipt, Scan Receipt",
      "icon": "assets/images/receipt_po.png",
      "authDetail": "receiptOrder_Auth_Detail",
    },
    // Active
    {
      "title": "Receipt Supplier Label",
      "subtitle": "List Receipt, Scan Receipt",
      "icon": "assets/images/receipt_supplier.png",
      "authDetail": "receiptSupplier_Auth_Detail",
    },
    // Active
    {
      "title": "Goods Purchase Returns",
      "subtitle": "List Returns, Scan Item",
      "icon": "assets/images/purchase_returns.png",
      "authDetail": "purchaseReturns_Auth_Detail",
    },

    // Active
    {
      "title": "A/P Credit Memo",
      "subtitle": "List Returns, Scan Item",
      "icon": "assets/images/purchase_credit.png",
      "authDetail": "payableCredit_Auth_Detail",
    },

    // Active
    {
      "title": "Delivery Order",
      "subtitle": "List Delivery, Scan Item",
      "icon": "assets/images/delivery.png",
      "authDetail": "deliveryOrder_Auth_Detail",
    },
    // Active
    {
      "title": "Return",
      "subtitle": "List Return, Scan Item",
      "icon": "assets/images/return.png",
      "authDetail": "returnSales_Auth_Detail",
    },

    // Active
    {
      "title": "A/R Credit Memo",
      "subtitle": "List Returns, Scan Item",
      "icon": "assets/images/receivable_credit.png",
      "authDetail": "receivableCredit_Auth_Detail",
    },

    // //InActive
    // {
    //   "title": "Issue For Production",
    //   "subtitle": "List Issue, Scan Item",
    //   "icon": "assets/images/receipt_supplier.png",
    //   "authDetail": "issueProduction_Auth_Detail",
    // },
    // //InActive
    // {
    //   "title": "Receipt From Production",
    //   "subtitle": "List Receipt, Scan Receipt",
    //   "icon": "assets/images/receipt.png",
    //   "authDetail": "receiptProduction_Auth_Detail",
    // },
  ];
  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    //final double widthScreen = mediaQueryData.size.width;
    //final double heightScreen = mediaQueryData.size.height;
    ///double sideLength = 50;

    return Padding(
      padding:
          const EdgeInsets.only(right: 2.0, left: 3.0, bottom: 10.0, top: 2.0),
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
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
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
                              //Wins - InActive - Production
                              // if (subjectList[index]["authDetail"] ==
                              //         "transferProduction_Auth_Detail" &&
                              //     globalBloc.loginResponse.data
                              //             .transferProduction_Auth_Detail ==
                              //         'Y') {
                              //   Navigator.push(context, MaterialPageRoute(
                              //       builder: (BuildContext context) {
                              //     return TransferProductionListPage();
                              //   }));
                              // } else if (subjectList[index]["authDetail"] ==
                              //         "goodsIssue_Auth_Detail" &&
                              //     globalBloc.loginResponse.data
                              //             .goodsIssue_Auth_Detail ==
                              //         'Y') {
                              //   Navigator.push(context, MaterialPageRoute(
                              //       builder: (BuildContext context) {
                              //     return GoodsIssueListPage();
                              //   }));
                              // }

                              //   else if (subjectList[index]["authDetail"] ==
                              //           "goodsReceipt_Auth_Detail" &&
                              //       globalBloc.loginResponse.data
                              //               .goodsReceipt_Auth_Detail ==
                              //           'Y') {
                              //     Navigator.push(context, MaterialPageRoute(
                              //         builder: (BuildContext context) {
                              //       return GoodsReceiptListPage();
                              //     }));
                              //   }

                              // Change Product
                              //else
                              if (subjectList[index]["authDetail"] ==
                                      "requestIssue_Auth_Detail" &&
                                  globalBloc.loginResponse.data
                                          .requestIssue_Auth_Detail ==
                                      'Y') {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return RequestIssueListPage();
                                }));
                              } else if (subjectList[index]["authDetail"] ==
                                      "receiptIssue_Auth_Detail" &&
                                  globalBloc.loginResponse.data
                                          .receiptIssue_Auth_Detail ==
                                      'Y') {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return ReceiptIssueListPage();
                                }));
                              }

                              //Transfer To Branch
                              else if (subjectList[index]["authDetail"] ==
                                      "transferBranch_Auth_Detail" &&
                                  globalBloc.loginResponse.data
                                          .transferBranch_Auth_Detail ==
                                      'Y') {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return TransferBranchListPage();
                                }));
                              }
                              //Receipt From Branch
                              else if (subjectList[index]["authDetail"] ==
                                      "receiptBranch_Auth_Detail" &&
                                  globalBloc.loginResponse.data
                                          .receiptBranch_Auth_Detail ==
                                      'Y') {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return ReceiptBranchListPage();
                                }));
                              }
                              // Transfer Item From To Warehouse
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
                              // A/R Sales
                              else if (subjectList[index]["authDetail"] ==
                                      "deliveryOrder_Auth_Detail" &&
                                  globalBloc.loginResponse.data
                                          .deliveryOrder_Auth_Detail ==
                                      'Y') {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return DeliveryOrderListPage();
                                }));
                              } else if (subjectList[index]["authDetail"] ==
                                      "returnSales_Auth_Detail" &&
                                  globalBloc.loginResponse.data
                                          .returnSales_Auth_Detail ==
                                      'Y') {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return ReturnSalesListPage();
                                }));
                              } else if (subjectList[index]["authDetail"] ==
                                      "receivableCredit_Auth_Detail" &&
                                  globalBloc.loginResponse.data
                                          .receivableCredit_Auth_Detail ==
                                      'Y') {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return ReceivableCreditListPage();
                                }));
                              }

                              //A/P Purchase
                              else if (subjectList[index]["authDetail"] ==
                                      "receiptOrder_Auth_Detail" &&
                                  globalBloc.loginResponse.data
                                          .receiptOrder_Auth_Detail ==
                                      'Y') {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return ReceiptOrderListPage();
                                }));
                              } else if (subjectList[index]["authDetail"] ==
                                      "receiptSupplier_Auth_Detail" &&
                                  globalBloc.loginResponse.data
                                          .receiptSupplier_Auth_Detail ==
                                      'Y') {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return ReceiptSupplierListPage();
                                }));
                              } else if (subjectList[index]["authDetail"] ==
                                      "purchaseReturns_Auth_Detail" &&
                                  globalBloc.loginResponse.data
                                          .purchaseReturns_Auth_Detail ==
                                      'Y') {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return PurchaseReturnsListPage();
                                }));
                              } else if (subjectList[index]["authDetail"] ==
                                      "payableCredit_Auth_Detail" &&
                                  globalBloc.loginResponse.data
                                          .payableCredit_Auth_Detail ==
                                      'Y') {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return PayableCreditListPage();
                                }));
                              }
                            },
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  height: 45,
                                  child: Image.asset(
                                    subjectList[index]["icon"],
                                    height: 40,
                                    width: 40,
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
                                              fontSize: 12,
                                              fontWeight: FontWeight.w900)),
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
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                );
              }, childCount: subjectList.length),
            ),
          ),
        ],
      ),
    );
  }
}
