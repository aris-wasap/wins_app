// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final ReceiptIssueDetailResponse = ReceiptIssueDetailResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'receipt_issue_detail_response.g.dart';

ReceiptIssueDetailResponse receiptIssueDetailResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return ReceiptIssueDetailResponse.fromJson(jsonData);
}

@JsonSerializable()
class ReceiptIssueDetailResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Data data;

  ReceiptIssueDetailResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory ReceiptIssueDetailResponse.fromJson(Map<String, dynamic> json) {
    return _$ReceiptIssueDetailResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReceiptIssueDetailResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'IssueId')
  int issueId;

  @JsonKey(name: 'IssueNo')
  String issueNo;

  @JsonKey(name: 'SeriesName')
  String seriesName;

  @JsonKey(name: 'RefNo')
  String refNo;

  @JsonKey(name: 'TransNo')
  String transNo;

  @JsonKey(name: 'TransDate')
  DateTime transDate;

  @JsonKey(name: 'SapReceiptIssueId')
  int sapReceiptIssueId;

  @JsonKey(name: 'SapReceiptIssueNo')
  String sapReceiptIssueNo;

  @JsonKey(name: 'BranchId')
  int branchId;

  @JsonKey(name: 'BranchName')
  String branchName;

  @JsonKey(name: 'CreatedUser')
  int createdUser;

  @JsonKey(name: 'Status')
  String status;

  @JsonKey(name: 'Items')
  List<Item> items;

  Data({
    this.issueId: 0,
    this.issueNo,
    this.seriesName,
    this.refNo,
    this.id: 0,
    this.transNo,
    this.transDate,
    this.sapReceiptIssueId: 0,
    this.sapReceiptIssueNo,
    this.branchId,
    this.branchName,
    this.createdUser,
    this.status,
    this.items,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Item {
  @JsonKey(name: 'IssueId')
  int issueId;

  @JsonKey(name: 'IssueLineNo')
  int issueLineNo;

  @JsonKey(name: 'WebId')
  int webId;

  @JsonKey(name: 'WebDetId')
  int webDetId;

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'LineNo')
  int lineNo;

  @JsonKey(name: 'VisLineNo')
  int visLineNo;

  @JsonKey(name: 'ItemCode')
  String itemCode;

  @JsonKey(name: 'ItemName')
  String itemName;

  @JsonKey(name: 'IssueQty')
  double issueQty;

  @JsonKey(name: 'Qty')
  double qty;

  @JsonKey(name: 'ItemCostTc')
  double itemCostTc;

  @JsonKey(name: 'Uom')
  String uom;

  @JsonKey(name: 'WhsCode')
  String whsCode;

  @JsonKey(name: 'WhsName')
  String whsName;

  @JsonKey(name: 'BinAbs')
  int binAbs;

  @JsonKey(name: 'BinCode')
  String binCode;

  @JsonKey(name: 'BatchNo')
  String batchNo;

  @JsonKey(name: 'MnfBatchNo')
  String mnfBatchNo;

  @JsonKey(name: 'Length')
  double length;

  @JsonKey(name: 'Length2')
  double length2;

  @JsonKey(name: 'Width')
  double width;

  @JsonKey(name: 'Weight')
  double weight;

  @JsonKey(name: 'Micron')
  double micron;

  @JsonKey(name: 'ManufacturingDate')
  DateTime manufacturingDate;

  @JsonKey(name: 'ExpirationDate')
  DateTime expirationDate;

  @JsonKey(name: 'ItemType')
  String itemType;

  @JsonKey(name: 'Type')
  String type;

  @JsonKey(name: 'IsAsset')
  String isAsset;

  @JsonKey(name: 'IsBatch')
  String isBatch;

  @JsonKey(name: 'PriceMode')
  String priceMode;

  Item({
    this.issueId: 0,
    this.issueLineNo: 0,
    this.webId,
    this.webDetId,
    this.id: 0,
    this.lineNo: 0,
    this.visLineNo: 0,
    this.itemCode,
    this.itemName,
    this.issueQty: 0,
    this.qty: 0,
    this.itemCostTc: 0,
    this.uom,
    this.whsCode,
    this.whsName,
    this.binAbs,
    this.binCode,
    this.batchNo,
    this.mnfBatchNo,
    this.width,
    this.length,
    this.length2,
    this.weight,
    this.micron,
    this.expirationDate,
    this.manufacturingDate,
    this.itemType,
    this.type,
    this.isAsset,
    this.isBatch,
    this.priceMode,

  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
