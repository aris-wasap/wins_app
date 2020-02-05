// To parse this JSON data, do
//
//     final receiptProductionListResponse = receiptProductionListResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'receipt_production_list_response.g.dart';

ReceiptProductionListResponse receiptProductionListResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return ReceiptProductionListResponse.fromJson(jsonData);
}

@JsonSerializable()
class ReceiptProductionListResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  ReceiptProductionListResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory ReceiptProductionListResponse.fromJson(Map<String, dynamic> json) {
    return _$ReceiptProductionListResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReceiptProductionListResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'UserId')
  int userId;

  @JsonKey(name: 'TransNo')
  String transNo;

  @JsonKey(name: 'TransDate')
  DateTime transDate;

  @JsonKey(name: 'Status')
  String status;
  
  @JsonKey(name: 'CreatedUser')
  String createdUser;
 

  Data({
    this.id,
    this.userId,
    this.transNo,
    this.transDate,
    this.status, 
    this.createdUser, 
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
