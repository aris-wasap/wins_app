import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'login_response.g.dart';

LoginResponse loginResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return LoginResponse.fromJson(jsonData);
}

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Data data;

  LoginResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return _$LoginResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'UserId')
  int userId;

  @JsonKey(name: 'RoleName')
  String roleName;

  @JsonKey(name: 'IsAdmin')
  String isAdmin;

  @JsonKey(name: 'BranchId')
  int branchId;

  @JsonKey(name: 'BranchName')
  String branchName;

  @JsonKey(name: 'DatabaseName')
  String databaseName;

  @JsonKey(name: 'TransferRelease_Auth_Detail')
  String transferRelease_Auth_Detail;

  @JsonKey(name: 'TransferRelease_Auth_Add')
  String transferRelease_Auth_Add;

  @JsonKey(name: 'TransferRelease_WhsCodeFrom')
  String transferRelease_WhsCodeFrom;

  @JsonKey(name: 'TransferRelease_WhsNameFrom')
  String transferRelease_WhsNameFrom;

  @JsonKey(name: 'TransferRelease_WhsCodeTo')
  String transferRelease_WhsCodeTo;

  @JsonKey(name: 'TransferRelease_WhsNameTo')
  String transferRelease_WhsNameTo;

  @JsonKey(name: 'TransferReject_Auth_Detail')
  String transferReject_Auth_Detail;

  @JsonKey(name: 'TransferReject_Auth_Add')
  String transferReject_Auth_Add;

  @JsonKey(name: 'TransferReject_WhsCodeFrom')
  String transferReject_WhsCodeFrom;

  @JsonKey(name: 'TransferReject_WhsNameFrom')
  String transferReject_WhsNameFrom;

  @JsonKey(name: 'TransferReject_WhsCodeTo')
  String transferReject_WhsCodeTo;

  @JsonKey(name: 'TransferReject_WhsNameTo')
  String transferReject_WhsNameTo;

  @JsonKey(name: 'TransferProduction_Auth_Detail')
  String transferProduction_Auth_Detail;

  @JsonKey(name: 'TransferProduction_Auth_Add')
  String transferProduction_Auth_Add;

  @JsonKey(name: 'TransferProduction_WhsCodeFrom')
  String transferProduction_WhsCodeFrom;

  @JsonKey(name: 'TransferProduction_WhsNameFrom')
  String transferProduction_WhsNameFrom;

  @JsonKey(name: 'TransferProduction_WhsCodeTo')
  String transferProduction_WhsCodeTo;

  @JsonKey(name: 'TransferProduction_WhsNameTo')
  String transferProduction_WhsNameTo;

  @JsonKey(name: 'TransferRequest_Auth_Detail')
  String transferRequest_Auth_Detail;

  @JsonKey(name: 'TransferRequest_Auth_Add')
  String transferRequest_Auth_Add;

  @JsonKey(name: 'TransferRequest_WhsCodeFrom')
  String transferRequest_WhsCodeFrom;

  @JsonKey(name: 'TransferRequest_WhsNameFrom')
  String transferRequest_WhsNameFrom;

  @JsonKey(name: 'TransferRequest_WhsCodeTo')
  String transferRequest_WhsCodeTo;

  @JsonKey(name: 'TransferRequest_WhsNameTo')
  String transferRequest_WhsNameTo;

  @JsonKey(name: 'DeliveryOrder_Auth_Detail')
  String deliveryOrder_Auth_Detail;

  @JsonKey(name: 'DeliveryOrder_Auth_Add')
  String deliveryOrder_Auth_Add;

  @JsonKey(name: 'DeliveryOrder_WhsCode')
  String deliveryOrder_WhsCode;

  @JsonKey(name: 'DeliveryOrder_WhsName')
  String deliveryOrder_WhsName;

  @JsonKey(name: 'IssueProduction_Auth_Detail')
  String issueProduction_Auth_Detail;

  @JsonKey(name: 'IssueProduction_Auth_Add')
  String issueProduction_Auth_Add;

  @JsonKey(name: 'IssueProduction_WhsCode')
  String issueProduction_WhsCode;

  @JsonKey(name: 'IssueProduction_WhsName')
  String issueProduction_WhsName;

  @JsonKey(name: 'ReceiptProduction_Auth_Detail')
  String receiptProduction_Auth_Detail;

  @JsonKey(name: 'ReceiptProduction_Auth_Add')
  String receiptProduction_Auth_Add;

  @JsonKey(name: 'ReceiptProduction_WhsCode')
  String receiptProduction_WhsCode;

  @JsonKey(name: 'ReceiptProduction_WhsName')
  String receiptProduction_WhsName;

  @JsonKey(name: 'GoodsIssue_Auth_Detail')
  String goodsIssue_Auth_Detail;

  @JsonKey(name: 'GoodsIssue_Auth_Add')
  String goodsIssue_Auth_Add;

  @JsonKey(name: 'GoodsIssueMixing_Auth_Detail')
  String goodsIssueMixing_Auth_Detail;

  @JsonKey(name: 'GoodsIssueMixing_Auth_Add')
  String goodsIssueMixing_Auth_Add;

  @JsonKey(name: 'GoodsIssue_WhsCode')
  String goodsIssue_WhsCode;

  @JsonKey(name: 'GoodsIssue_WhsName')
  String goodsIssue_WhsName;

  @JsonKey(name: 'GoodsReceipt_Auth_Detail')
  String goodsReceipt_Auth_Detail;

  @JsonKey(name: 'GoodsReceipt_Auth_Add')
  String goodsReceipt_Auth_Add;

  @JsonKey(name: 'GoodsReceipt_WhsCode')
  String goodsReceipt_WhsCode;

  @JsonKey(name: 'GoodsReceipt_WhsName')
  String goodsReceipt_WhsName;

  @JsonKey(name: 'TransferBranch_Auth_Detail')
  String transferBranch_Auth_Detail;

  @JsonKey(name: 'TransferBranch_Auth_Add')
  String transferBranch_Auth_Add;

  @JsonKey(name: 'TransferBranch_WhsCode')
  String transferBranch_WhsCode;

  @JsonKey(name: 'TransferBranch_WhsName')
  String transferBranch_WhsName;

  @JsonKey(name: 'ReceiptBranch_Auth_Detail')
  String receiptBranch_Auth_Detail;

  @JsonKey(name: 'ReceiptBranch_Auth_Add')
  String receiptBranch_Auth_Add;

  @JsonKey(name: 'ReceiptBranch_WhsCode')
  String receiptBranch_WhsCode;

  @JsonKey(name: 'ReceiptBranch_WhsName')
  String receiptBranch_WhsName;

  @JsonKey(name: 'RequestIssue_Auth_Detail')
  String requestIssue_Auth_Detail;

  @JsonKey(name: 'RequestIssue_Auth_Add')
  String requestIssue_Auth_Add;

  @JsonKey(name: 'RequestIssue_WhsCode')
  String requestIssue_WhsCode;

  @JsonKey(name: 'RequestIssue_WhsName')
  String requestIssue_WhsName;

  @JsonKey(name: 'ReceiptIssue_Auth_Detail')
  String receiptIssue_Auth_Detail;

  @JsonKey(name: 'ReceiptIssue_Auth_Add')
  String receiptIssue_Auth_Add;

  @JsonKey(name: 'ReceiptIssue_WhsCode')
  String receiptIssue_WhsCode;

  @JsonKey(name: 'ReceiptIssue_WhsName')
  String receiptIssue_WhsName;

  @JsonKey(name: 'ReceiptOrder_Auth_Detail')
  String receiptOrder_Auth_Detail;

  @JsonKey(name: 'ReceiptOrder_Auth_Add')
  String receiptOrder_Auth_Add;

  @JsonKey(name: 'ReceiptOrder_WhsCode')
  String receiptOrder_WhsCode;

  @JsonKey(name: 'ReceiptOrder_WhsName')
  String receiptOrder_WhsName;

  @JsonKey(name: 'ReceiptSupplier_Auth_Detail')
  String receiptSupplier_Auth_Detail;

  @JsonKey(name: 'ReceiptSupplier_Auth_Add')
  String receiptSupplier_Auth_Add;

  @JsonKey(name: 'ReceiptSupplier_WhsCode')
  String receiptSupplier_WhsCode;

  @JsonKey(name: 'ReceiptSupplier_WhsName')
  String receiptSupplier_WhsName;

  @JsonKey(name: 'PurchaseReturns_Auth_Detail')
  String purchaseReturns_Auth_Detail;

  @JsonKey(name: 'PurchaseReturns_Auth_Add')
  String purchaseReturns_Auth_Add;

  @JsonKey(name: 'PurchaseReturns_WhsCode')
  String purchaseReturns_WhsCode;

  @JsonKey(name: 'PurchaseReturns_WhsName')
  String purchaseReturns_WhsName;

  @JsonKey(name: 'PayableCredit_Auth_Detail')
  String payableCredit_Auth_Detail;

  @JsonKey(name: 'PayableCredit_Auth_Add')
  String payableCredit_Auth_Add;

  @JsonKey(name: 'PayableCredit_WhsCode')
  String payableCredit_WhsCode;

  @JsonKey(name: 'PayableCredit_WhsName')
  String payableCredit_WhsName;

  @JsonKey(name: 'ReturnSales_Auth_Detail')
  String returnSales_Auth_Detail;

  @JsonKey(name: 'ReturnSales_Auth_Add')
  String returnSales_Auth_Add;

  @JsonKey(name: 'ReturnSales_WhsCode')
  String returnSales_WhsCode;

  @JsonKey(name: 'ReturnSales_WhsName')
  String returnSales_WhsName;

  @JsonKey(name: 'ReceivableCredit_Auth_Detail')
  String receivableCredit_Auth_Detail;

  @JsonKey(name: 'ReceivableCredit_Auth_Add')
  String receivableCredit_Auth_Add;

  @JsonKey(name: 'ReceivableCredit_WhsCode')
  String receivableCredit_WhsCode;

  @JsonKey(name: 'ReceivableCredit_WhsName')
  String receivableCredit_WhsName;

  @JsonKey(name: 'InventoryTransfer_Auth_Detail')
  String inventoryTransfer_Auth_Detail;

  @JsonKey(name: 'InventoryTransfer_Auth_Add')
  String inventoryTransfer_Auth_Add;

  @JsonKey(name: 'InventoryTransfer_WhsCodeFrom')
  String inventoryTransfer_WhsCodeFrom;

  @JsonKey(name: 'InventoryTransfer_WhsNameFrom')
  String inventoryTransfer_WhsNameFrom;

  @JsonKey(name: 'InventoryTransfer_WhsCodeTo')
  String inventoryTransfer_WhsCodeTo;

  @JsonKey(name: 'InventoryTransfer_WhsNameTo')
  String inventoryTransfer_WhsNameTo;

  Data({
    this.userId,
    this.roleName,
    this.isAdmin,
    this.branchId,
    this.branchName,
    this.transferRelease_Auth_Detail,
    this.transferRelease_Auth_Add,
    this.transferRelease_WhsCodeFrom,
    this.transferRelease_WhsNameFrom,
    this.transferRelease_WhsCodeTo,
    this.transferRelease_WhsNameTo,
    this.transferReject_Auth_Detail,
    this.transferReject_Auth_Add,
    this.transferReject_WhsCodeFrom,
    this.transferReject_WhsNameFrom,
    this.transferReject_WhsCodeTo,
    this.transferReject_WhsNameTo,
    this.transferProduction_Auth_Detail,
    this.transferProduction_Auth_Add,
    this.transferProduction_WhsCodeFrom,
    this.transferProduction_WhsNameFrom,
    this.transferProduction_WhsCodeTo,
    this.transferProduction_WhsNameTo,
    this.transferRequest_Auth_Detail,
    this.transferRequest_Auth_Add,
    this.transferRequest_WhsCodeFrom,
    this.transferRequest_WhsNameFrom,
    this.transferRequest_WhsCodeTo,
    this.transferRequest_WhsNameTo,
    this.deliveryOrder_Auth_Detail,
    this.deliveryOrder_Auth_Add,
    this.deliveryOrder_WhsCode,
    this.deliveryOrder_WhsName,
    this.receiptProduction_Auth_Add,
    this.receiptProduction_Auth_Detail,
    this.receiptProduction_WhsCode,
    this.receiptProduction_WhsName,
    this.receiptIssue_Auth_Add,
    this.receiptIssue_Auth_Detail,
    this.receiptIssue_WhsCode,
    this.receiptIssue_WhsName,
    this.receiptOrder_Auth_Add,
    this.receiptOrder_Auth_Detail,
    this.receiptOrder_WhsCode,
    this.receiptOrder_WhsName,
    this.receiptSupplier_Auth_Add,
    this.receiptSupplier_Auth_Detail,
    this.receiptSupplier_WhsCode,
    this.receiptSupplier_WhsName,
    this.returnSales_Auth_Add,
    this.returnSales_Auth_Detail,
    this.returnSales_WhsCode,
    this.returnSales_WhsName,
    this.inventoryTransfer_Auth_Detail,
    this.inventoryTransfer_Auth_Add,
    this.inventoryTransfer_WhsCodeFrom,
    this.inventoryTransfer_WhsNameFrom,
    this.inventoryTransfer_WhsCodeTo,
    this.inventoryTransfer_WhsNameTo,
    this.purchaseReturns_Auth_Add,
    this.purchaseReturns_Auth_Detail,
    this.purchaseReturns_WhsCode,
    this.purchaseReturns_WhsName,
    this.payableCredit_Auth_Add,
    this.payableCredit_Auth_Detail,
    this.payableCredit_WhsCode,
    this.payableCredit_WhsName,
    this.transferBranch_Auth_Add,
    this.transferBranch_Auth_Detail,
    this.transferBranch_WhsCode,
    this.transferBranch_WhsName,
    this.receiptBranch_Auth_Add,
    this.receiptBranch_Auth_Detail,
    this.receiptBranch_WhsCode,
    this.receiptBranch_WhsName,
    this.goodsIssue_Auth_Add,
    this.goodsIssue_Auth_Detail,
    this.goodsIssueMixing_Auth_Detail,
    this.goodsIssueMixing_Auth_Add,
    this.goodsIssue_WhsCode,
    this.goodsIssue_WhsName,
    this.goodsReceipt_Auth_Add,
    this.goodsReceipt_Auth_Detail,
    this.goodsReceipt_WhsCode,
    this.goodsReceipt_WhsName,
    this.issueProduction_Auth_Add,
    this.issueProduction_Auth_Detail,
    this.issueProduction_WhsCode,
    this.issueProduction_WhsName,
    this.requestIssue_Auth_Add,
    this.requestIssue_Auth_Detail,
    this.requestIssue_WhsCode,
    this.requestIssue_WhsName,
    this.receivableCredit_Auth_Add,
    this.receivableCredit_Auth_Detail,
    this.receivableCredit_WhsCode,
    this.receivableCredit_WhsName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
