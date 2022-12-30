import 'dart:async';

import 'package:wins_app/blocs/global_bloc.dart';

// class MenuList {
//   static List<Map<String, dynamic>> menuList = [
//     //Active
//     {
//       "title": "Inventory Transfer",
//       "subtitle": "List Inventory, Scan Item",
//       "icon": "assets/images/transfer.png",
//       "authDetail": "inventoryTransfer_Auth_Detail",
//       "isAccess": globalBloc.loginResponse.data.inventoryTransfer_Auth_Detail,
//     },
//     // Active
//     {
//       "title": "Transfer To Depo",
//       "subtitle": "List Transfer, Scan Item",
//       "icon": "assets/images/transfer_branch.png",
//       "authDetail": "transferBranch_Auth_Detail",
//       "isAccess": globalBloc.loginResponse.data.transferBranch_Auth_Detail,
//     },

//     // Active
//     {
//       "title": "Receipt From Depo",
//       "subtitle": "List Receipt, Scan Item",
//       "icon": "assets/images/receipt_branch.png",
//       "authDetail": "receiptBranch_Auth_Detail",
//       "isAccess": globalBloc.loginResponse.data.receiptBranch_Auth_Detail,
//     },

//     //Wins - InActive
//     {
//       "title": "Transfer For Production Order",
//       "subtitle": "List Inventory, Scan Item",
//       "icon": "assets/images/transfer_production.png",
//       "authDetail": "transferProduction_Auth_Detail",
//       "isAccess": globalBloc.loginResponse.data.transferProduction_Auth_Detail,
//     },
//     //Wins - InActive
//     {
//       "title": "Issue For Production",
//       "subtitle": "List Issue, Scan Item",
//       "icon": "assets/images/goods_issue.png",
//       "authDetail": "goodsIssue_Auth_Detail",
//       "isAccess": globalBloc.loginResponse.data.goodsIssue_Auth_Detail,
//     },
//     //Wins - Active
//     {
//       "title": "Mixing",
//       "subtitle": "List Issue, Scan Item",
//       "icon": "assets/images/goods_issue.png",
//       "authDetail": "goodsIssueMixing_Auth_Detail",
//       "isAccess": globalBloc.loginResponse.data.goodsIssue_Auth_Detail,
//     },
//     //Wins - InActive
//     {
//       "title": "Receipt From Production",
//       "subtitle": "List Receipt, Scan Receipt",
//       "icon": "assets/images/goods_receipt.png",
//       "authDetail": "goodsReceipt_Auth_Detail",
//       "isAccess": globalBloc.loginResponse.data.goodsReceipt_Auth_Detail,
//     },

//     // Active
//     {
//       "title": "Issue Change Product",
//       "subtitle": "List Issue, Scan Item",
//       "icon": "assets/images/request_issue.png",
//       "authDetail": "requestIssue_Auth_Detail",
//       "isAccess": globalBloc.loginResponse.data.requestIssue_Auth_Detail,
//     },
//     // Active
//     {
//       "title": "Receipt From Change Product",
//       "subtitle": "List Receipt, Scan Receipt",
//       "icon": "assets/images/receipt_issue.png",
//       "authDetail": "receiptIssue_Auth_Detail",
//       "isAccess": globalBloc.loginResponse.data.receiptIssue_Auth_Detail,
//     },
//     // Active
//     {
//       "title": "Receipt From Purchase Order",
//       "subtitle": "List Receipt, Scan Receipt",
//       "icon": "assets/images/receipt_po.png",
//       "authDetail": "receiptOrder_Auth_Detail",
//       "isAccess": globalBloc.loginResponse.data.receiptOrder_Auth_Detail,
//     },
//     // Active
//     {
//       "title": "Receipt Supplier Label",
//       "subtitle": "List Receipt, Scan Receipt",
//       "icon": "assets/images/receipt_supplier.png",
//       "authDetail": "receiptSupplier_Auth_Detail",
//       "isAccess": globalBloc.loginResponse.data.receiptSupplier_Auth_Detail,
//     },
//     // Active
//     {
//       "title": "Goods Purchase Returns",
//       "subtitle": "List Returns, Scan Item",
//       "icon": "assets/images/purchase_returns.png",
//       "authDetail": "purchaseReturns_Auth_Detail",
//       "isAccess": globalBloc.loginResponse.data.transferProduction_Auth_Detail,
//     },

//     // Active
//     {
//       "title": "A/P Credit Memo",
//       "subtitle": "List Returns, Scan Item",
//       "icon": "assets/images/purchase_credit.png",
//       "authDetail": "payableCredit_Auth_Detail",
//       "isAccess": globalBloc.loginResponse.data.payableCredit_Auth_Detail,
//     },

//     // Active
//     {
//       "title": "Delivery Order",
//       "subtitle": "List Delivery, Scan Item",
//       "icon": "assets/images/delivery.png",
//       "authDetail": "deliveryOrder_Auth_Detail",
//       "isAccess": globalBloc.loginResponse.data.deliveryOrder_Auth_Detail,
//     },
//     // Active
//     {
//       "title": "Return",
//       "subtitle": "List Return, Scan Item",
//       "icon": "assets/images/return.png",
//       "authDetail": "returnSales_Auth_Detail",
//       "isAccess": globalBloc.loginResponse.data.returnSales_Auth_Detail,
//     },

//     // Active
//     {
//       "title": "A/R Credit Memo",
//       "subtitle": "List Returns, Scan Item",
//       "icon": "assets/images/receivable_credit.png",
//       "authDetail": "receivableCredit_Auth_Detail",
//       "isAccess": globalBloc.loginResponse.data.receivableCredit_Auth_Detail,
//     },

//     // //InActive
//     // {
//     //   "title": "Issue For Production",
//     //   "subtitle": "List Issue, Scan Item",
//     //   "icon": "assets/images/receipt_supplier.png",
//     //   "authDetail": "issueProduction_Auth_Detail",
//     // },
//     // //InActive
//     // {
//     //   "title": "Receipt From Production",
//     //   "subtitle": "List Receipt, Scan Receipt",
//     //   "icon": "assets/images/receipt.png",
//     //   "authDetail": "receiptProduction_Auth_Detail",
//     // },
//   ];

//   // static List<Map<String, dynamic>> filteredData =
//   //     menuList.where((item) => item['isAccess'] == "Y").toList();
// }

class MenuBloc {
  final _menuController = StreamController<List<Map<String, dynamic>>>();

  Stream<List<Map<String, dynamic>>> get menuStream => _menuController.stream;

  void fetchData() {
    List<Map<String, dynamic>> menuList = [
      //Active
      {
        "title": "Inventory Transfer",
        "subtitle": "List Inventory, Scan Item",
        "icon": "assets/images/transfer.png",
        "authDetail": "inventoryTransfer_Auth_Detail",
        "isAccess": globalBloc.loginResponse.data.inventoryTransfer_Auth_Detail,
      },
      // Active
      {
        "title": "Transfer To Depo",
        "subtitle": "List Transfer, Scan Item",
        "icon": "assets/images/transfer_branch.png",
        "authDetail": "transferBranch_Auth_Detail",
        "isAccess": globalBloc.loginResponse.data.transferBranch_Auth_Detail,
      },

      // Active
      {
        "title": "Receipt From Depo",
        "subtitle": "List Receipt, Scan Item",
        "icon": "assets/images/receipt_branch.png",
        "authDetail": "receiptBranch_Auth_Detail",
        "isAccess": globalBloc.loginResponse.data.receiptBranch_Auth_Detail,
      },

      //Wins - InActive
      {
        "title": "Transfer For Production Order",
        "subtitle": "List Inventory, Scan Item",
        "icon": "assets/images/transfer_production.png",
        "authDetail": "transferProduction_Auth_Detail",
        "isAccess":
            globalBloc.loginResponse.data.transferProduction_Auth_Detail,
      },
      //Wins - InActive
      {
        "title": "Issue For Production",
        "subtitle": "List Issue, Scan Item",
        "icon": "assets/images/goods_issue.png",
        "authDetail": "goodsIssue_Auth_Detail",
        "isAccess": globalBloc.loginResponse.data.goodsIssue_Auth_Detail,
      },
      //Wins - Active
      {
        "title": "Mixing",
        "subtitle": "List Issue, Scan Item",
        "icon": "assets/images/goods_issue.png",
        "authDetail": "goodsIssueMixing_Auth_Detail",
        "isAccess": globalBloc.loginResponse.data.goodsIssue_Auth_Detail,
      },
      //Wins - InActive
      {
        "title": "Receipt From Production",
        "subtitle": "List Receipt, Scan Receipt",
        "icon": "assets/images/goods_receipt.png",
        "authDetail": "goodsReceipt_Auth_Detail",
        "isAccess": globalBloc.loginResponse.data.goodsReceipt_Auth_Detail,
      },

      // Active
      {
        "title": "Issue Change Product",
        "subtitle": "List Issue, Scan Item",
        "icon": "assets/images/request_issue.png",
        "authDetail": "requestIssue_Auth_Detail",
        "isAccess": globalBloc.loginResponse.data.requestIssue_Auth_Detail,
      },
      // Active
      {
        "title": "Receipt From Change Product",
        "subtitle": "List Receipt, Scan Receipt",
        "icon": "assets/images/receipt_issue.png",
        "authDetail": "receiptIssue_Auth_Detail",
        "isAccess": globalBloc.loginResponse.data.receiptIssue_Auth_Detail,
      },
      // Active
      {
        "title": "Receipt From Purchase Order",
        "subtitle": "List Receipt, Scan Receipt",
        "icon": "assets/images/receipt_po.png",
        "authDetail": "receiptOrder_Auth_Detail",
        "isAccess": globalBloc.loginResponse.data.receiptOrder_Auth_Detail,
      },
      // Active
      {
        "title": "Receipt Supplier Label",
        "subtitle": "List Receipt, Scan Receipt",
        "icon": "assets/images/receipt_supplier.png",
        "authDetail": "receiptSupplier_Auth_Detail",
        "isAccess": globalBloc.loginResponse.data.receiptSupplier_Auth_Detail,
      },
      // Active
      {
        "title": "Goods Purchase Returns",
        "subtitle": "List Returns, Scan Item",
        "icon": "assets/images/purchase_returns.png",
        "authDetail": "purchaseReturns_Auth_Detail",
        "isAccess":
            globalBloc.loginResponse.data.transferProduction_Auth_Detail,
      },

      // Active
      {
        "title": "A/P Credit Memo",
        "subtitle": "List Returns, Scan Item",
        "icon": "assets/images/purchase_credit.png",
        "authDetail": "payableCredit_Auth_Detail",
        "isAccess": globalBloc.loginResponse.data.payableCredit_Auth_Detail,
      },

      // Active
      {
        "title": "Delivery Order",
        "subtitle": "List Delivery, Scan Item",
        "icon": "assets/images/delivery.png",
        "authDetail": "deliveryOrder_Auth_Detail",
        "isAccess": globalBloc.loginResponse.data.deliveryOrder_Auth_Detail,
      },
      // Active
      {
        "title": "Return",
        "subtitle": "List Return, Scan Item",
        "icon": "assets/images/return.png",
        "authDetail": "returnSales_Auth_Detail",
        "isAccess": globalBloc.loginResponse.data.returnSales_Auth_Detail,
      },

      // Active
      {
        "title": "A/R Credit Memo",
        "subtitle": "List Returns, Scan Item",
        "icon": "assets/images/receivable_credit.png",
        "authDetail": "receivableCredit_Auth_Detail",
        "isAccess": globalBloc.loginResponse.data.receivableCredit_Auth_Detail,
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

    List<Map<String, dynamic>> filteredData =
        menuList.where((item) => item['isAccess'] == "Y").toList();
    _menuController.sink.add(filteredData);
  }

  void dispose() {
    _menuController.close();
  }
}
