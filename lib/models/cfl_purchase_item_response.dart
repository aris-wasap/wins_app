// To parse this JSON data, do
//
//     final cflPurchaseItemResponse = cflPurchaseItemResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'cfl_purchase_item_response.g.dart';

CflPurchaseItemResponse cflPurchaseItemResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return CflPurchaseItemResponse.fromJson(jsonData);
}
 

@JsonSerializable()
class CflPurchaseItemResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  CflPurchaseItemResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory CflPurchaseItemResponse.fromJson(Map<String, dynamic> json) {
    return _$CflPurchaseItemResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CflPurchaseItemResponseToJson(this);
}

@JsonSerializable()
class Data { 
  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'TransNo')
  String transNo;  

  @JsonKey(name: 'TransDate')
  DateTime transDate;  

  @JsonKey(name: 'Status')
  String status;  

  @JsonKey(name: 'VendorCode')
  String vendorCode;  

  @JsonKey(name: 'VendorName')
  String vendorName;  

  @JsonKey(name: 'SeriesName')
  String seriesName;

  @JsonKey(name: 'ItemCode')
  String itemCode;

  @JsonKey(name: 'ItemName')
  String itemName;

  @JsonKey(name: 'Uom')
  String uom;

  @JsonKey(name: 'WhsCode')
  String whsCode;

  @JsonKey(name: 'WhsName')
  String whsName;

  @JsonKey(name: 'UnitPriceTc')
  double unitPriceTc;

  @JsonKey(name: 'Quantity')
  double quantity;

  @JsonKey(name: 'LineNum')
  int lineNum;

  @JsonKey(name: 'LineStatus')
  String lineStatus;

  Data({ 
    this.id=0,
    this.transNo, 
    this.transDate, 
    this.status, 
    this.vendorCode, 
    this.vendorName, 
    this.seriesName,
    this.itemCode,
    this.itemName,
    this.whsCode,
    this.whsName,
    this.unitPriceTc,
    this.quantity,
    this.lineNum,
    this.lineStatus
  });

 factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
