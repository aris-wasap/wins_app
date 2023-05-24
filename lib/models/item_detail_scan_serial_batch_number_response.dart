// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final ItemDetailScanSerialBatchNumberResponse = ItemDetailScanSerialBatchNumberResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'item_detail_scan_serial_batch_number_response.g.dart';

ItemDetailScanSerialBatchNumberResponse
    itemDetailScanSerialBatchNumberResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return ItemDetailScanSerialBatchNumberResponse.fromJson(jsonData);
}

@JsonSerializable()
class ItemDetailScanSerialBatchNumberResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  DataSnB data;

  ItemDetailScanSerialBatchNumberResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory ItemDetailScanSerialBatchNumberResponse.fromJson(
      Map<String, dynamic> json) {
    return _$ItemDetailScanSerialBatchNumberResponseFromJson(json);
  }

  Map<String, dynamic> toJson() =>
      _$ItemDetailScanSerialBatchNumberResponseToJson(this);
}

@JsonSerializable()
class DataSnB {
  @JsonKey(name: 'ItemCode')
  String itemCode;

  @JsonKey(name: 'ItemName')
  String itemName;

  @JsonKey(name: 'DistNumber')
  String distNumber;

  @JsonKey(name: 'WhsCode')
  String whsCode;

  @JsonKey(name: 'WhsName')
  String whsName;

  @JsonKey(name: 'InDate')
  String inDate;

  @JsonKey(name: 'MnfDate')
  String mnfDate;

  @JsonKey(name: 'ExpDate')
  String expDate;

  @JsonKey(name: 'TotalStock')
  double totalStock;

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

  @JsonKey(name: 'ItemType')
  String itemType;

  @JsonKey(name: 'Uom')
  String uom;

  @JsonKey(name: 'Details')
  List<ItemSnB> details;

  DataSnB({
    this.itemCode,
    this.itemName,
    this.distNumber,
    this.inDate,
    this.mnfDate,
    this.expDate,
    this.whsCode,
    this.whsName,
    this.totalStock,
    this.length,
    this.length2,
    this.width,
    this.weight,
    this.itemType,
    this.micron,
    this.uom,
    this.details,
  });

  factory DataSnB.fromJson(Map<String, dynamic> json) =>
      _$DataSnBFromJson(json);

  Map<String, dynamic> toJson() => _$DataSnBToJson(this);
}

@JsonSerializable()
class ItemSnB {
  @JsonKey(name: 'ItemCode')
  String itemCode;

  @JsonKey(name: 'ItemName')
  String itemName;

  @JsonKey(name: 'WhsCode')
  String whsCode;

  @JsonKey(name: 'WhsName')
  String whsName;

  @JsonKey(name: 'BinAbs')
  int binAbs;

  @JsonKey(name: 'BinCode')
  String binCode;

  @JsonKey(name: 'Stock')
  double stock;

  @JsonKey(name: 'Uom')
  String uom;

  ItemSnB({
    this.itemCode,
    this.itemName,
    this.whsCode,
    this.whsName,
    this.binAbs: 0,
    this.binCode,
    this.stock: 0,
    this.uom,
  });

  factory ItemSnB.fromJson(Map<String, dynamic> json) =>
      _$ItemSnBFromJson(json);

  Map<String, dynamic> toJson() => _$ItemSnBToJson(this);
}
