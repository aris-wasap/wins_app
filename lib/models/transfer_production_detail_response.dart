// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final transferProductionDetailResponse = transferProductionDetailResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'transfer_production_detail_response.g.dart';

TransferProductionDetailResponse transferProductionDetailResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return TransferProductionDetailResponse.fromJson(jsonData);
}

@JsonSerializable()
class TransferProductionDetailResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Data data;

  TransferProductionDetailResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory TransferProductionDetailResponse.fromJson(Map<String, dynamic> json) {
    return _$TransferProductionDetailResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TransferProductionDetailResponseToJson(this);
}

@JsonSerializable()
class Data {

  @JsonKey(name: 'ProdOrderId')
  int prodOrderId;  

  @JsonKey(name: 'ProdOrderNo')
  String prodOrderNo;

  @JsonKey(name: 'ProdDate')
  DateTime prodDate;

  @JsonKey(name: 'ProductCode')
  String productCode;

  @JsonKey(name: 'ProductName')
  String productName;
  
  @JsonKey(name: 'Id')
  int id;  

  @JsonKey(name: 'TransNo')
  String transNo;

  @JsonKey(name: 'TransDate')
  DateTime transDate;  

  @JsonKey(name: 'WhsCodeFrom')
  String whsCodeFrom; 
  
  @JsonKey(name: 'WhsNameFrom')
  String whsNameFrom;

  @JsonKey(name: 'WhsCodeTo')
  String whsCodeTo;

  @JsonKey(name: 'WhsNameTo')
  String whsNameTo;


  @JsonKey(name: 'Items')
  List<Item> items;

  
  

  Data({  
    this.prodOrderId: 0,
    this.prodOrderNo,
    this.prodDate,
    this.productCode,
    this.productName,
    this.id: 0,
    this.transNo,
    this.transDate, 
    this.whsCodeFrom,
    this.whsNameFrom,
    this.whsCodeTo, 
    this.whsNameTo,
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

  @JsonKey(name: 'WhsCode')
  String whsCode;

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
    this.whsCode, 
    this.batchNo, 
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
 