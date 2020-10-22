// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_issue_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptIssueDetailResponse _$ReceiptIssueDetailResponseFromJson(
    Map<String, dynamic> json) {
  return ReceiptIssueDetailResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Data.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ReceiptIssueDetailResponseToJson(
        ReceiptIssueDetailResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    issueId: json['IssueId'] as int,
    issueNo: json['IssueNo'] as String,
    seriesName: json['SeriesName'] as String,
    docNum: json['DocNum'] as String,
    id: json['Id'] as int,
    transNo: json['TransNo'] as String,
    transDate: json['TransDate'] == null
        ? null
        : DateTime.parse(json['TransDate'] as String),
    sapReceiptIssueId: json['SapReceiptIssueId'] as int,
    sapReceiptIssueNo: json['SapReceiptIssueNo'] as String,
    branchId: json['BranchId'] as int,
    branchName: json['BranchName'] as String,
    createdUser: json['CreatedUser'] as int,
    status: json['Status'] as String,
    items: (json['Items'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'Id': instance.id,
      'IssueId': instance.issueId,
      'IssueNo': instance.issueNo,
      'SeriesName': instance.seriesName,
      'DocNum': instance.docNum,
      'TransNo': instance.transNo,
      'TransDate': instance.transDate?.toIso8601String(),
      'SapReceiptIssueId': instance.sapReceiptIssueId,
      'SapReceiptIssueNo': instance.sapReceiptIssueNo,
      'BranchId': instance.branchId,
      'BranchName': instance.branchName,
      'CreatedUser': instance.createdUser,
      'Status': instance.status,
      'Items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    issueId: json['IssueId'] as int,
    issueLineNo: json['IssueLineNo'] as int,
    webId: json['WebId'] as int,
    webDetId: json['WebDetId'] as int,
    id: json['Id'] as int,
    lineNo: json['LineNo'] as int,
    visLineNo: json['VisLineNo'] as int,
    itemCode: json['ItemCode'] as String,
    itemName: json['ItemName'] as String,
    issueQty: (json['IssueQty'] as num)?.toDouble(),
    qty: (json['Qty'] as num)?.toDouble(),
    itemCost: (json['ItemCost'] as num)?.toDouble(),
    uom: json['Uom'] as String,
    whsCode: json['WhsCode'] as String,
    whsName: json['WhsName'] as String,
    binAbs: json['BinAbs'] as int,
    binCode: json['BinCode'] as String,
    batchNo: json['BatchNo'] as String,
    mnfBatchNo: json['MnfBatchNo'] as String,
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'IssueId': instance.issueId,
      'IssueLineNo': instance.issueLineNo,
      'WebId': instance.webId,
      'WebDetId': instance.webDetId,
      'Id': instance.id,
      'LineNo': instance.lineNo,
      'VisLineNo': instance.visLineNo,
      'ItemCode': instance.itemCode,
      'ItemName': instance.itemName,
      'IssueQty': instance.issueQty,
      'Qty': instance.qty,
      'ItemCost': instance.itemCost,
      'Uom': instance.uom,
      'WhsCode': instance.whsCode,
      'WhsName': instance.whsName,
      'BinAbs': instance.binAbs,
      'BinCode': instance.binCode,
      'BatchNo': instance.batchNo,
      'MnfBatchNo': instance.mnfBatchNo,
    };
