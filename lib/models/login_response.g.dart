// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) {
  return LoginResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Data.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    userId: json['UserId'] as int,
    roleName: json['RoleName'] as String,
    isAdmin: json['IsAdmin'] as String,
    branchId: json['BranchId'] as int,
    branchName: json['BranchName'] as String,
    transferRelease_Auth_Detail: json['TransferRelease_Auth_Detail'] as String,
    transferRelease_Auth_Add: json['TransferRelease_Auth_Add'] as String,
    transferRelease_WhsCodeFrom: json['TransferRelease_WhsCodeFrom'] as String,
    transferRelease_WhsNameFrom: json['TransferRelease_WhsNameFrom'] as String,
    transferRelease_WhsCodeTo: json['TransferRelease_WhsCodeTo'] as String,
    transferRelease_WhsNameTo: json['TransferRelease_WhsNameTo'] as String,
    transferReject_Auth_Detail: json['TransferReject_Auth_Detail'] as String,
    transferReject_Auth_Add: json['TransferReject_Auth_Add'] as String,
    transferReject_WhsCodeFrom: json['TransferReject_WhsCodeFrom'] as String,
    transferReject_WhsNameFrom: json['TransferReject_WhsNameFrom'] as String,
    transferReject_WhsCodeTo: json['TransferReject_WhsCodeTo'] as String,
    transferReject_WhsNameTo: json['TransferReject_WhsNameTo'] as String,
    transferProduction_Auth_Detail:
        json['TransferProduction_Auth_Detail'] as String,
    transferProduction_Auth_Add: json['TransferProduction_Auth_Add'] as String,
    transferProduction_WhsCodeFrom:
        json['TransferProduction_WhsCodeFrom'] as String,
    transferProduction_WhsNameFrom:
        json['TransferProduction_WhsNameFrom'] as String,
    transferProduction_WhsCodeTo:
        json['TransferProduction_WhsCodeTo'] as String,
    transferProduction_WhsNameTo:
        json['TransferProduction_WhsNameTo'] as String,
    transferRequest_Auth_Detail: json['TransferRequest_Auth_Detail'] as String,
    transferRequest_Auth_Add: json['TransferRequest_Auth_Add'] as String,
    transferRequest_WhsCodeFrom: json['TransferRequest_WhsCodeFrom'] as String,
    transferRequest_WhsNameFrom: json['TransferRequest_WhsNameFrom'] as String,
    transferRequest_WhsCodeTo: json['TransferRequest_WhsCodeTo'] as String,
    transferRequest_WhsNameTo: json['TransferRequest_WhsNameTo'] as String,
    deliveryOrder_Auth_Detail: json['DeliveryOrder_Auth_Detail'] as String,
    deliveryOrder_Auth_Add: json['DeliveryOrder_Auth_Add'] as String,
    deliveryOrder_WhsCode: json['DeliveryOrder_WhsCode'] as String,
    deliveryOrder_WhsName: json['DeliveryOrder_WhsName'] as String,
    receiptProduction_Auth_Add: json['ReceiptProduction_Auth_Add'] as String,
    receiptProduction_Auth_Detail:
        json['ReceiptProduction_Auth_Detail'] as String,
    receiptProduction_WhsCode: json['ReceiptProduction_WhsCode'] as String,
    receiptProduction_WhsName: json['ReceiptProduction_WhsName'] as String,
    receiptIssue_Auth_Add: json['ReceiptIssue_Auth_Add'] as String,
    receiptIssue_Auth_Detail: json['ReceiptIssue_Auth_Detail'] as String,
    receiptIssue_WhsCode: json['ReceiptIssue_WhsCode'] as String,
    receiptIssue_WhsName: json['ReceiptIssue_WhsName'] as String,
    receiptOrder_Auth_Add: json['ReceiptOrder_Auth_Add'] as String,
    receiptOrder_Auth_Detail: json['ReceiptOrder_Auth_Detail'] as String,
    receiptOrder_WhsCode: json['ReceiptOrder_WhsCode'] as String,
    receiptOrder_WhsName: json['ReceiptOrder_WhsName'] as String,
    receiptSupplier_Auth_Add: json['ReceiptSupplier_Auth_Add'] as String,
    receiptSupplier_Auth_Detail: json['ReceiptSupplier_Auth_Detail'] as String,
    receiptSupplier_WhsCode: json['ReceiptSupplier_WhsCode'] as String,
    receiptSupplier_WhsName: json['ReceiptSupplier_WhsName'] as String,
    returnSales_Auth_Add: json['ReturnSales_Auth_Add'] as String,
    returnSales_Auth_Detail: json['ReturnSales_Auth_Detail'] as String,
    returnSales_WhsCode: json['ReturnSales_WhsCode'] as String,
    returnSales_WhsName: json['ReturnSales_WhsName'] as String,
    inventoryTransfer_Auth_Detail:
        json['InventoryTransfer_Auth_Detail'] as String,
    inventoryTransfer_Auth_Add: json['InventoryTransfer_Auth_Add'] as String,
    inventoryTransfer_WhsCodeFrom:
        json['InventoryTransfer_WhsCodeFrom'] as String,
    inventoryTransfer_WhsNameFrom:
        json['InventoryTransfer_WhsNameFrom'] as String,
    inventoryTransfer_WhsCodeTo: json['InventoryTransfer_WhsCodeTo'] as String,
    inventoryTransfer_WhsNameTo: json['InventoryTransfer_WhsNameTo'] as String,
  )
    ..issueProduction_Auth_Detail =
        json['IssueProduction_Auth_Detail'] as String
    ..issueProduction_Auth_Add = json['IssueProduction_Auth_Add'] as String
    ..issueProduction_WhsCode = json['IssueProduction_WhsCode'] as String
    ..issueProduction_WhsName = json['IssueProduction_WhsName'] as String
    ..goodsIssue_Auth_Detail = json['GoodsIssue_Auth_Detail'] as String
    ..goodsIssue_Auth_Add = json['GoodsIssue_Auth_Add'] as String
    ..goodsIssue_WhsCode = json['GoodsIssue_WhsCode'] as String
    ..goodsIssue_WhsName = json['GoodsIssue_WhsName'] as String
    ..goodsReceipt_Auth_Detail = json['GoodsReceipt_Auth_Detail'] as String
    ..goodsReceipt_Auth_Add = json['GoodsReceipt_Auth_Add'] as String
    ..goodsReceipt_WhsCode = json['GoodsReceipt_WhsCode'] as String
    ..goodsReceipt_WhsName = json['GoodsReceipt_WhsName'] as String
    ..transferBranch_Auth_Detail = json['TransferBranch_Auth_Detail'] as String
    ..transferBranch_Auth_Add = json['TransferBranch_Auth_Add'] as String
    ..transferBranch_WhsCode = json['TransferBranch_WhsCode'] as String
    ..transferBranch_WhsName = json['TransferBranch_WhsName'] as String
    ..receiptBranch_Auth_Detail = json['ReceiptBranch_Auth_Detail'] as String
    ..receiptBranch_Auth_Add = json['ReceiptBranch_Auth_Add'] as String
    ..receiptBranch_WhsCode = json['ReceiptBranch_WhsCode'] as String
    ..receiptBranch_WhsName = json['ReceiptBranch_WhsName'] as String
    ..requestIssue_Auth_Detail = json['RequestIssue_Auth_Detail'] as String
    ..requestIssue_Auth_Add = json['RequestIssue_Auth_Add'] as String
    ..requestIssue_WhsCode = json['RequestIssue_WhsCode'] as String
    ..requestIssue_WhsName = json['RequestIssue_WhsName'] as String
    ..purchaseReturns_Auth_Detail =
        json['PurchaseReturns_Auth_Detail'] as String
    ..purchaseReturns_Auth_Add = json['PurchaseReturns_Auth_Add'] as String
    ..purchaseReturns_WhsCode = json['PurchaseReturns_WhsCode'] as String
    ..purchaseReturns_WhsName = json['PurchaseReturns_WhsName'] as String;
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'UserId': instance.userId,
      'RoleName': instance.roleName,
      'IsAdmin': instance.isAdmin,
      'BranchId': instance.branchId,
      'BranchName': instance.branchName,
      'TransferRelease_Auth_Detail': instance.transferRelease_Auth_Detail,
      'TransferRelease_Auth_Add': instance.transferRelease_Auth_Add,
      'TransferRelease_WhsCodeFrom': instance.transferRelease_WhsCodeFrom,
      'TransferRelease_WhsNameFrom': instance.transferRelease_WhsNameFrom,
      'TransferRelease_WhsCodeTo': instance.transferRelease_WhsCodeTo,
      'TransferRelease_WhsNameTo': instance.transferRelease_WhsNameTo,
      'TransferReject_Auth_Detail': instance.transferReject_Auth_Detail,
      'TransferReject_Auth_Add': instance.transferReject_Auth_Add,
      'TransferReject_WhsCodeFrom': instance.transferReject_WhsCodeFrom,
      'TransferReject_WhsNameFrom': instance.transferReject_WhsNameFrom,
      'TransferReject_WhsCodeTo': instance.transferReject_WhsCodeTo,
      'TransferReject_WhsNameTo': instance.transferReject_WhsNameTo,
      'TransferProduction_Auth_Detail': instance.transferProduction_Auth_Detail,
      'TransferProduction_Auth_Add': instance.transferProduction_Auth_Add,
      'TransferProduction_WhsCodeFrom': instance.transferProduction_WhsCodeFrom,
      'TransferProduction_WhsNameFrom': instance.transferProduction_WhsNameFrom,
      'TransferProduction_WhsCodeTo': instance.transferProduction_WhsCodeTo,
      'TransferProduction_WhsNameTo': instance.transferProduction_WhsNameTo,
      'TransferRequest_Auth_Detail': instance.transferRequest_Auth_Detail,
      'TransferRequest_Auth_Add': instance.transferRequest_Auth_Add,
      'TransferRequest_WhsCodeFrom': instance.transferRequest_WhsCodeFrom,
      'TransferRequest_WhsNameFrom': instance.transferRequest_WhsNameFrom,
      'TransferRequest_WhsCodeTo': instance.transferRequest_WhsCodeTo,
      'TransferRequest_WhsNameTo': instance.transferRequest_WhsNameTo,
      'DeliveryOrder_Auth_Detail': instance.deliveryOrder_Auth_Detail,
      'DeliveryOrder_Auth_Add': instance.deliveryOrder_Auth_Add,
      'DeliveryOrder_WhsCode': instance.deliveryOrder_WhsCode,
      'DeliveryOrder_WhsName': instance.deliveryOrder_WhsName,
      'IssueProduction_Auth_Detail': instance.issueProduction_Auth_Detail,
      'IssueProduction_Auth_Add': instance.issueProduction_Auth_Add,
      'IssueProduction_WhsCode': instance.issueProduction_WhsCode,
      'IssueProduction_WhsName': instance.issueProduction_WhsName,
      'ReceiptProduction_Auth_Detail': instance.receiptProduction_Auth_Detail,
      'ReceiptProduction_Auth_Add': instance.receiptProduction_Auth_Add,
      'ReceiptProduction_WhsCode': instance.receiptProduction_WhsCode,
      'ReceiptProduction_WhsName': instance.receiptProduction_WhsName,
      'GoodsIssue_Auth_Detail': instance.goodsIssue_Auth_Detail,
      'GoodsIssue_Auth_Add': instance.goodsIssue_Auth_Add,
      'GoodsIssue_WhsCode': instance.goodsIssue_WhsCode,
      'GoodsIssue_WhsName': instance.goodsIssue_WhsName,
      'GoodsReceipt_Auth_Detail': instance.goodsReceipt_Auth_Detail,
      'GoodsReceipt_Auth_Add': instance.goodsReceipt_Auth_Add,
      'GoodsReceipt_WhsCode': instance.goodsReceipt_WhsCode,
      'GoodsReceipt_WhsName': instance.goodsReceipt_WhsName,
      'TransferBranch_Auth_Detail': instance.transferBranch_Auth_Detail,
      'TransferBranch_Auth_Add': instance.transferBranch_Auth_Add,
      'TransferBranch_WhsCode': instance.transferBranch_WhsCode,
      'TransferBranch_WhsName': instance.transferBranch_WhsName,
      'ReceiptBranch_Auth_Detail': instance.receiptBranch_Auth_Detail,
      'ReceiptBranch_Auth_Add': instance.receiptBranch_Auth_Add,
      'ReceiptBranch_WhsCode': instance.receiptBranch_WhsCode,
      'ReceiptBranch_WhsName': instance.receiptBranch_WhsName,
      'RequestIssue_Auth_Detail': instance.requestIssue_Auth_Detail,
      'RequestIssue_Auth_Add': instance.requestIssue_Auth_Add,
      'RequestIssue_WhsCode': instance.requestIssue_WhsCode,
      'RequestIssue_WhsName': instance.requestIssue_WhsName,
      'ReceiptIssue_Auth_Detail': instance.receiptIssue_Auth_Detail,
      'ReceiptIssue_Auth_Add': instance.receiptIssue_Auth_Add,
      'ReceiptIssue_WhsCode': instance.receiptIssue_WhsCode,
      'ReceiptIssue_WhsName': instance.receiptIssue_WhsName,
      'ReceiptOrder_Auth_Detail': instance.receiptOrder_Auth_Detail,
      'ReceiptOrder_Auth_Add': instance.receiptOrder_Auth_Add,
      'ReceiptOrder_WhsCode': instance.receiptOrder_WhsCode,
      'ReceiptOrder_WhsName': instance.receiptOrder_WhsName,
      'ReceiptSupplier_Auth_Detail': instance.receiptSupplier_Auth_Detail,
      'ReceiptSupplier_Auth_Add': instance.receiptSupplier_Auth_Add,
      'ReceiptSupplier_WhsCode': instance.receiptSupplier_WhsCode,
      'ReceiptSupplier_WhsName': instance.receiptSupplier_WhsName,
      'PurchaseReturns_Auth_Detail': instance.purchaseReturns_Auth_Detail,
      'PurchaseReturns_Auth_Add': instance.purchaseReturns_Auth_Add,
      'PurchaseReturns_WhsCode': instance.purchaseReturns_WhsCode,
      'PurchaseReturns_WhsName': instance.purchaseReturns_WhsName,
      'ReturnSales_Auth_Detail': instance.returnSales_Auth_Detail,
      'ReturnSales_Auth_Add': instance.returnSales_Auth_Add,
      'ReturnSales_WhsCode': instance.returnSales_WhsCode,
      'ReturnSales_WhsName': instance.returnSales_WhsName,
      'InventoryTransfer_Auth_Detail': instance.inventoryTransfer_Auth_Detail,
      'InventoryTransfer_Auth_Add': instance.inventoryTransfer_Auth_Add,
      'InventoryTransfer_WhsCodeFrom': instance.inventoryTransfer_WhsCodeFrom,
      'InventoryTransfer_WhsNameFrom': instance.inventoryTransfer_WhsNameFrom,
      'InventoryTransfer_WhsCodeTo': instance.inventoryTransfer_WhsCodeTo,
      'InventoryTransfer_WhsNameTo': instance.inventoryTransfer_WhsNameTo,
    };
