// To parse this JSON data, do
//
//     final cflTransferRequestResponse = cflTransferRequestResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'cfl_transfer_request_response.g.dart';

CflTransferRequestResponse cflTransferRequestResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return CflTransferRequestResponse.fromJson(jsonData);
}
 

@JsonSerializable()
class CflTransferRequestResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  CflTransferRequestResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory CflTransferRequestResponse.fromJson(Map<String, dynamic> json) {
    return _$CflTransferRequestResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CflTransferRequestResponseToJson(this);
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

  @JsonKey(name: 'SeriesName')
  String seriesName;

  Data({ 
    this.id=0,
    this.transNo, 
    this.transDate, 
    this.status, 
    this.customerCode, 
    this.customerName,
    this.seriesName 
  });

 factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
