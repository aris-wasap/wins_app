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

  @JsonKey(name: 'RequestId')
  int requestId;

  @JsonKey(name: 'RequestNo')
  String requestNo;  

  @JsonKey(name:'SeriesName')
  String seriesName;

  @JsonKey(name:'SeriesNameReqNo')
  String seriesNameReqNo;

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
    this.requestId: 0, 
    this.requestNo, 
    this.seriesName,
    this.seriesNameReqNo,
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

  @JsonKey(name: 'RequestId')
  int requestId;

  @JsonKey(name: 'RequestLineNo')
  int requestLineNo;

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

  @JsonKey(name: 'ReqQty')
  double reqQty;

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

  @JsonKey(name: 'ItemType')
  String itemType;

  @JsonKey(name: 'Type')
  String type;

  @JsonKey(name: 'ManufacturingDate')
  DateTime manufacturingDate;

  @JsonKey(name: 'ExpirationDate')
  DateTime expirationDate;

  @JsonKey(name: 'ItemCost')
  double itemCost;

  @JsonKey(name: 'IsAsset')
  String isAsset;

  @JsonKey(name: 'IsBatch')
  String isBatch;

  @JsonKey(name: 'PriceMode')
  String priceMode;

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
    this.requestId: 0,
    this.requestLineNo: 0,
    this.webId,
    this.webDetId,
    this.id: 0,
    this.lineNo: 0,
    this.visLineNo: 0,
    this.itemCode,
    this.itemName, 
    this.reqQty: 0,
    this.qty: 0,
    this.itemCost:0,
    this.uom,
    this.length,
    this.width,
    this.weight,
    this.itemType,
    this.type,
    this.whsCode,
    this.whsName,
    this.binAbs,
    this.binCode,
    this.isAsset,
    this.isBatch,
    this.priceMode,
    this.batchNo,
    this.micron,
    this.manufacturingDate,
    this.expirationDate,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
 