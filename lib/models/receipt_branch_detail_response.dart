// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final ReceiptBranchDetailResponse = ReceiptBranchDetailResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'receipt_branch_detail_response.g.dart';

ReceiptBranchDetailResponse receiptBranchDetailResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return ReceiptBranchDetailResponse.fromJson(jsonData);
}

@JsonSerializable()
class ReceiptBranchDetailResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Data data;

  ReceiptBranchDetailResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory ReceiptBranchDetailResponse.fromJson(Map<String, dynamic> json) {
    return _$ReceiptBranchDetailResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReceiptBranchDetailResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'IssueId')
  int issueId;

  @JsonKey(name: 'IssueNo')
  String issueNo;

  @JsonKey(name: 'SeriesNameIssue')
  String seriesNameIssue;

  @JsonKey(name: 'SeriesName')
  String seriesName;

  @JsonKey(name: 'TransNo')
  String transNo;

  @JsonKey(name: 'TransDate')
  DateTime transDate;

  @JsonKey(name: 'BranchId')
  int branchId;

  @JsonKey(name: 'FromBranchName')
  String fromBranchName;

  @JsonKey(name: 'FromBranchId')
  int fromBranchId;

  @JsonKey(name: 'BranchName')
  String branchName;

  @JsonKey(name: 'SapReceiptBranchId')
  int sapReceiptBranchId;

  @JsonKey(name: 'SapReceiptBranchNo')
  String sapReceiptBranchNo;

  @JsonKey(name: 'CreatedUser')
  int createdUser;

  @JsonKey(name: 'Status')
  String status;

  @JsonKey(name: 'Items')
  List<Item> items;

  Data({
    this.issueId: 0,
    this.issueNo,
    this.seriesNameIssue,
    this.seriesName,
    this.id: 0,
    this.transNo,
    this.transDate,
    this.branchId,
    this.branchName,
    this.fromBranchId,
    this.fromBranchName,
    this.sapReceiptBranchId: 0,
    this.sapReceiptBranchNo,
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

  @JsonKey(name: 'Length')
  double length;

  @JsonKey(name: 'Width')
  double width;

  @JsonKey(name: 'Weight')
  double weight;

  @JsonKey(name: 'Micron')
  double micron;

  @JsonKey(name: 'Type')
  String type;

  @JsonKey(name: 'ItemType')
  String itemType;

  @JsonKey(name: 'ItemCost')
  double itemCost;

  @JsonKey(name: 'Uom')
  String uom;

  @JsonKey(name: 'FromWhsCode')
  String fromWhsCode;

  @JsonKey(name: 'FromWhsName')
  String fromWhsName;

  @JsonKey(name: 'FromBinAbs')
  int fromBinAbs;

  @JsonKey(name: 'FromBinCode')
  String fromBinCode;

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

  Item({
    this.issueId: 0,
    this.issueLineNo: 0,
    this.id: 0,
    this.lineNo: 0,
    this.visLineNo: 0,
    this.itemCode,
    this.itemName,
    this.issueQty: 0,
    this.qty: 0,
    this.length,
    this.width,
    this.weight,
    this.type,
    this.itemType,
    this.itemCost: 0,
    this.uom,
    this.fromWhsCode,
    this.fromWhsName,
    this.fromBinAbs,
    this.fromBinCode,
    this.whsCode,
    this.whsName,
    this.binAbs,
    this.binCode,
    this.batchNo,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
