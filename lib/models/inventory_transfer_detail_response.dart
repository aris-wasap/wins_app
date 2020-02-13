// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final transferProductionDetailResponse = transferProductionDetailResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'inventory_transfer_detail_response.g.dart';

InventoryTransferDetailResponse transferProductionDetailResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return InventoryTransferDetailResponse.fromJson(jsonData);
}

@JsonSerializable()
class InventoryTransferDetailResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Data data;

  InventoryTransferDetailResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory InventoryTransferDetailResponse.fromJson(Map<String, dynamic> json) {
    return _$InventoryTransferDetailResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InventoryTransferDetailResponseToJson(this);
}

@JsonSerializable()
class Data {

  @JsonKey(name: 'Id')
  int id;  

  @JsonKey(name: 'TransNo')
  String transNo;

  @JsonKey(name: 'TransDate')
  DateTime transDate;  

  @JsonKey(name: 'FromWhsCode')
  String fromWhsCode; 
  
  @JsonKey(name: 'FromWhsName')
  String fromWhsName;

  @JsonKey(name: 'ToWhsCode')
  String toWhsCode;

  @JsonKey(name: 'ToWhsName')
  String toWhsName;

  @JsonKey(name: 'TotalQty')
  double totalQty;

  @JsonKey(name: 'Items')
  List<Item> items;

  
  

  Data({  
    this.id: 0,
    this.transNo,
    this.transDate, 
    this.fromWhsCode,
    this.fromWhsName,
    this.toWhsCode, 
    this.toWhsName,
    this.totalQty,
    this.items,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
} 

@JsonSerializable()
class Item {  

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

  @JsonKey(name: 'Qty')
  double qty;

  @JsonKey(name: 'Uom')
  String uom;

  @JsonKey(name: 'ToWhsCode')
  String toWhsCode;

  @JsonKey(name: 'BatchNo')
  String batchNo; 
   
 
 
  Item({ 
    this.id: 0,
    this.lineNo: 0,
    this.visLineNo: 0,
    this.itemCode,
    this.itemName, 
    this.qty: 0,
    this.uom,
    this.toWhsCode, 
    this.batchNo, 
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
 