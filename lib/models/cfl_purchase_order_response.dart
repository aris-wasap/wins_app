// To parse this JSON data, do
//
//     final cflPurchaseOrderResponse = cflPurchaseOrderResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'cfl_purchase_order_response.g.dart';

CflPurchaseOrderResponse cflPurchaseOrderResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return CflPurchaseOrderResponse.fromJson(jsonData);
}
 

@JsonSerializable()
class CflPurchaseOrderResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  CflPurchaseOrderResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory CflPurchaseOrderResponse.fromJson(Map<String, dynamic> json) {
    return _$CflPurchaseOrderResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CflPurchaseOrderResponseToJson(this);
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

  @JsonKey(name: 'CustomerCode')
  String customerCode;  

  @JsonKey(name: 'CustomerName')
  String customerName;  

  Data({ 
    this.id=0,
    this.transNo, 
    this.transDate, 
    this.status, 
    this.customerCode, 
    this.customerName, 
  });

 factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
