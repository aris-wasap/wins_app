// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final RequestIssueDetailResponse = RequestIssueDetailResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'request_issue_detail_response.g.dart';

RequestIssueDetailResponse requestIssueDetailResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return RequestIssueDetailResponse.fromJson(jsonData);
}

@JsonSerializable()
class RequestIssueDetailResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Data data;

  RequestIssueDetailResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory RequestIssueDetailResponse.fromJson(Map<String, dynamic> json) {
    return _$RequestIssueDetailResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RequestIssueDetailResponseToJson(this);
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

  @JsonKey(name: 'SapRequestIssueId')
  int sapRequestIssueId;

  @JsonKey(name: 'SapRequestIssueNo')
  String sapRequestIssueNo;

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
    this.docNum,
    this.id: 0,
    this.transNo,
    this.transDate,
    this.sapRequestIssueId: 0,
    this.sapRequestIssueNo,
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

  @JsonKey(name: 'ItemCost')
  double itemCost;

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
    this.itemCost:0,
    this.uom,
    this.whsCode,
    this.whsName,
    this.binAbs,
    this.binCode,  
    this.batchNo,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
 