// To parse this JSON data, do
//
//     final cflProductionOrderResponse = cflProductionOrderResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'cfl_production_order_response.g.dart';

CflProductionOrderResponse cflProductionOrderResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return CflProductionOrderResponse.fromJson(jsonData);
}
 

@JsonSerializable()
class CflProductionOrderResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  CflProductionOrderResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory CflProductionOrderResponse.fromJson(Map<String, dynamic> json) {
    return _$CflProductionOrderResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CflProductionOrderResponseToJson(this);
}

@JsonSerializable()
class Data { 
  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'TransNo')
  String transNo;  

  @JsonKey(name: 'TransDate')
  DateTime transDate;  

  @JsonKey(name: 'ProductCode')
  String productCode;  

  @JsonKey(name: 'ProductName')
  String productName;  

  @JsonKey(name: 'Status')
  String status;  


  Data({ 
    this.id=0,
    this.transNo, 
    this.transDate, 
    this.productCode, 
    this.productName, 
    this.status, 
  });

 factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
