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

  @JsonKey(name: 'SapGoodsReceiptId')
  int sapGoodsReceiptId;

  @JsonKey(name: 'SapGoodsReceiptNo')
  String sapGoodsReceiptNo;

  @JsonKey(name: 'BranchId')
  int branchId;

  @JsonKey(name: 'BranchName')
  String branchName;

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
    this.sapGoodsReceiptId = 0,
    this.sapGoodsReceiptNo,
    this.branchId,
    this.branchName,
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

  @JsonKey(name: 'ItemCostTc')
  double itemCostTc;

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

  @JsonKey(name: 'Group')
  String group;

  @JsonKey(name: 'Machine')
  String machine;

  @JsonKey(name: 'Shift')
  String shift;
 
 
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
    this.itemCostTc,
    this.whsCode,
    this.whsName,
    this.binAbs,
    this.binCode, 
    this.batchNo,
    this.width,
    this.length,
    this.length2,
    this.weight,
    this.micron,
    this.expirationDate,
    this.manufacturingDate,
    this.itemType,
    this.type,
    this.group,
    this.machine,
    this.shift,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
 