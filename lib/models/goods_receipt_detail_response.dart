// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final goodsReceiptDetailResponse = goodsReceiptDetailResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'goods_receipt_detail_response.g.dart';

GoodsReceiptDetailResponse goodsReceiptDetailResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return GoodsReceiptDetailResponse.fromJson(jsonData);
}

@JsonSerializable()
class GoodsReceiptDetailResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Data data;

  GoodsReceiptDetailResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory GoodsReceiptDetailResponse.fromJson(Map<String, dynamic> json) {
    return _$GoodsReceiptDetailResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GoodsReceiptDetailResponseToJson(this);
}

@JsonSerializable()
class Data {
  
  @JsonKey(name: 'Id')
  int id; 

  @JsonKey(name: 'WoId')
  int woId;

  @JsonKey(name: 'WoNo')
  String woNo; 

  @JsonKey(name: 'WoDate')
  DateTime woDate;

  @JsonKey(name: 'ProductCode')
  String productCode; 

  @JsonKey(name: 'ProductName')
  String productName; 

  @JsonKey(name: 'TransNo')
  String transNo;

  @JsonKey(name: 'TransDate')
  DateTime transDate;  

  @JsonKey(name: 'SeriesNameWo')
  String seriesNameWo;

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
    this.seriesNameWo,
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

  @JsonKey(name: 'WoQty')
  double woQty;

  @JsonKey(name: 'Qty')
  double qty;

  @JsonKey(name: 'Uom')
  String uom;

  @JsonKey(name: 'ItemCost')
  double itemCost;

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
    this.webId:0,
    this.webDetId:0,
    this.id: 0,
    this.lineNo: 0,
    this.visLineNo: 0,
    this.itemCode,
    this.itemName, 
    this.woQty: 0,
    this.qty: 0,
    this.uom,
    this.itemCost,
    this.whsCode,
    this.whsName,
    this.binAbs,
    this.binCode, 
    this.batchNo,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
 