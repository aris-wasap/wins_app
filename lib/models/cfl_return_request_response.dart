// To parse this JSON data, do
//
//     final cflReturnRequestResponse = cflReturnRequestResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'cfl_return_request_response.g.dart';

CflReturnRequestResponse cflReturnRequestResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return CflReturnRequestResponse.fromJson(jsonData);
}

@JsonSerializable()
class CflReturnRequestResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  CflReturnRequestResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory CflReturnRequestResponse.fromJson(Map<String, dynamic> json) {
    return _$CflReturnRequestResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CflReturnRequestResponseToJson(this);
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
