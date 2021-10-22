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

  @JsonKey(name: 'FromWhsCode')
  String fromWhsCode;

  @JsonKey(name: 'FromWhsName')
  String fromWhsName;

  @JsonKey(name: 'FromBinEntry')
  int fromBinEntry;

  @JsonKey(name: 'FromBinCode')
  String fromBinCode;

  @JsonKey(name: 'ToWhsCode')
  String toWhsCode;

  @JsonKey(name: 'ToWhsName')
  String toWhsName;

  @JsonKey(name: 'ToBinEntry')
  int toBinEntry;

  @JsonKey(name: 'ToBinCode')
  String toBinCode;

  @JsonKey(name: 'FromBranchId')
  int fromBranchId;

  @JsonKey(name: 'FromBranchName')
  String fromBranchName;

  @JsonKey(name: 'ToBranchId')
  int toBranchId;

  @JsonKey(name: 'ToBranchName')
  String toBranchName;

  Data({
    this.id = 0,
    this.transNo,
    this.transDate,
    this.status,
    this.customerCode,
    this.customerName,
    this.seriesName,
    this.fromWhsCode,
    this.fromWhsName,
    this.fromBinEntry,
    this.fromBinCode,
    this.toWhsCode,
    this.toWhsName,
    this.toBinEntry,
    this.toBinCode,
    this.fromBranchId,
    this.fromBranchName,
    this.toBranchId,
    this.toBranchName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
