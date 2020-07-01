// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final issueProductionDetailResponse = issueProductionDetailResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'issue_production_detail_response.g.dart';

IssueProductionDetailResponse issueProductionDetailResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return IssueProductionDetailResponse.fromJson(jsonData);
}

@JsonSerializable()
class IssueProductionDetailResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Data data;

  IssueProductionDetailResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory IssueProductionDetailResponse.fromJson(Map<String, dynamic> json) {
    return _$IssueProductionDetailResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$IssueProductionDetailResponseToJson(this);
}

@JsonSerializable()
class Data {
  
  @JsonKey(name: 'Id')
  int id; 

  @JsonKey(name: 'WoId')
  int woId;

  @JsonKey(name: 'WoNo')
  String woNo;  

  @JsonKey(name: 'TransNo')
  String transNo;

  @JsonKey(name: 'TransDate')
  DateTime transDate;  

  @JsonKey(name: 'SeriesNamePo')
  String seriesNamePo;

  @JsonKey(name: 'SeriesName')
  String seriesName;

  @JsonKey(name: 'Items')
  List<Item> items;

  
  

  Data({
    this.woId: 0, 
    this.woNo, 
    this.id: 0,
    this.transNo,
    this.transDate, 
    this.seriesNamePo,
    this.seriesName,
    this.items,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
} 

@JsonSerializable()
class Item { 

  @JsonKey(name: 'WoId')
  int woId;

  @JsonKey(name: 'WoLineNo')
  int woLineNo;

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

  @JsonKey(name: 'WoQty')
  double woQty;

  @JsonKey(name: 'Qty')
  double qty;

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
    this.woId: 0,
    this.woLineNo: 0,
    this.id: 0,
    this.lineNo: 0,
    this.visLineNo: 0,
    this.itemCode,
    this.itemName, 
    this.woQty: 0,
    this.qty: 0,
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
 