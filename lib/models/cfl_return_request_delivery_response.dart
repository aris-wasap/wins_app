// To parse this JSON data, do
//
//     final cflReturnRequestDeliveryResponse = cflReturnRequestDeliveryResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'cfl_return_request_delivery_response.g.dart';

CflReturnRequestDeliveryResponse cflReturnRequestDeliveryResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return CflReturnRequestDeliveryResponse.fromJson(jsonData);
}

@JsonSerializable()
class CflReturnRequestDeliveryResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  CflReturnRequestDeliveryResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory CflReturnRequestDeliveryResponse.fromJson(Map<String, dynamic> json) {
    return _$CflReturnRequestDeliveryResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CflReturnRequestDeliveryResponseToJson(this);
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

  @JsonKey(name: 'RefNo')
  String refNo;

  @JsonKey(name: 'SeriesName')
  String seriesName;

  @JsonKey(name: 'BranchId')
  int branchId;

  @JsonKey(name: 'BranchName')
  String branchName;

  Data({
    this.id = 0,
    this.transNo,
    this.transDate,
    this.status,
    this.customerCode,
    this.customerName,
    this.refNo,
    this.seriesName,
    this.branchId,
    this.branchName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
