// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final receiptProductionDetailResponse = receiptProductionDetailResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'receipt_production_detail_response.g.dart';

ReceiptProductionDetailResponse receiptProductionDetailResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return ReceiptProductionDetailResponse.fromJson(jsonData);
}

@JsonSerializable()
class ReceiptProductionDetailResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Data data;

  ReceiptProductionDetailResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory ReceiptProductionDetailResponse.fromJson(Map<String, dynamic> json) {
    return _$ReceiptProductionDetailResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReceiptProductionDetailResponseToJson(this);
}

@JsonSerializable()
class Data {
  
  @JsonKey(name: 'Id')
  int id; 

  @JsonKey(name: 'TransNo')
  String transNo;

  @JsonKey(name: 'TransDate')
  DateTime transDate;  

  @JsonKey(name: 'Items')
  List<Item> items;

  
  

  Data({
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

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'WoId') 
  int woId;

  @JsonKey(name: 'WoNo')
  String woNo;

  @JsonKey(name: 'WebId')
  int webId;

  @JsonKey(name: 'WebDetId')
  int webDetId;

  @JsonKey(name: 'ItemCode')
  String itemCode;
  
  @JsonKey(name: 'ItemName')
  String itemName;

  @JsonKey(name: 'Quantity')
  double quantity;

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
    this.id: 0,
    this.woId: 0,
    this.woNo,
    this.webId,
    this.webDetId,
    this.itemCode,
    this.itemName,
    this.quantity:0,
    this.uom,
    this.whsCode ,
    this.whsName,
    this.binAbs,
    this.binCode,
    this.batchNo,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
 