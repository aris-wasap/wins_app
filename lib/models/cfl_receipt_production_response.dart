// To parse this JSON data, do
//
//     final cflReceiptProductionResponse = cflReceiptProductionResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'cfl_receipt_production_response.g.dart';

CflReceiptProductionResponse cflReceiptProductionResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return CflReceiptProductionResponse.fromJson(jsonData);
}
 

@JsonSerializable()
class CflReceiptProductionResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  CflReceiptProductionResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory CflReceiptProductionResponse.fromJson(Map<String, dynamic> json) {
    return _$CflReceiptProductionResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CflReceiptProductionResponseToJson(this);
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

  @JsonKey(name: 'WhsCode')
  String whsCode;  

  @JsonKey(name: 'WhsName')
  String whsName;  

  @JsonKey(name: 'Status')
  String status;  


  Data({ 
    this.id=0,
    this.transNo, 
    this.transDate, 
    this.productCode, 
    this.productName,
    this.whsCode,
    this.whsName, 
    this.status, 
  });

 factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
