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

  @JsonKey(name:'SeriesName')
  String seriesName;

  @JsonKey(name: 'DocNum')
  String docNum;

  @JsonKey(name: 'TransNo')
  String transNo;

  @JsonKey(name: 'TransDate')
  DateTime transDate;  

  @JsonKey(name: 'Items')
  List<Item> items;

  
  

  Data({
    this.issueId: 0, 
    this.issueNo, 
    this.seriesName,
    this.docNum,
    this.id: 0,
    this.transNo,
    this.transDate,
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

  @JsonKey(name: 'Uom')
  String uom;

  @JsonKey(name: 'WhsCode')
  String whsCode;

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
    this.uom,
    this.whsCode, 
    this.batchNo,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
 