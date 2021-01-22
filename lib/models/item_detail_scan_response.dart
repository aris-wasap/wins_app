// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final ItemDetailScanResponse = ItemDetailScanResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'item_detail_scan_response.g.dart';

ItemDetailScanResponse itemDetailScanResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return ItemDetailScanResponse.fromJson(jsonData);
}

@JsonSerializable()
class ItemDetailScanResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Data data;

  ItemDetailScanResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory ItemDetailScanResponse.fromJson(Map<String, dynamic> json) {
    return _$ItemDetailScanResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ItemDetailScanResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'ItemCode')
  String itemCode;

  @JsonKey(name: 'ItemName')
  String itemName;

  @JsonKey(name: 'DistNumber')
  String distNumber;

  @JsonKey(name: 'TotalStock')
  double totalStock;

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
  @JsonKey(name: 'Uom')
  String uom;

  @JsonKey(name: 'Details')
  List<Item> details;

  Data({
    this.itemCode,
    this.itemName,
    this.distNumber,
    this.totalStock,
    this.length,
    this.width,
    this.weight,
    this.itemType,
    this.micron,
    this.uom,
    this.details
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
} 

@JsonSerializable()
class Item { 

  @JsonKey(name: 'InDate')
  String inDate;

  @JsonKey(name: 'MnfDate')
  String mnfDate;

  @JsonKey(name: 'ExpDate')
  String expDate;

  @JsonKey(name: 'WhsCode')
  String whsCode;

  @JsonKey(name: 'WhsName')
  String whsName;

  @JsonKey(name: 'Stock')
  double stock;

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

  @JsonKey(name: 'Uom')
  String uom;
  
  Item({
    this.inDate,
    this.mnfDate, 
    this.expDate, 
    this.whsCode, 
    this.whsName, 
    this.stock: 0,
    this.length,
    this.width,
    this.weight,
    this.itemType,
    this.micron,
    this.uom,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
 