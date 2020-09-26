// To parse this JSON data, do
//
//     final cflRequestBranchResponse = cflRequestBranchResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'cfl_request_branch_response.g.dart';

CflRequestBranchResponse cflRequestBranchResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return CflRequestBranchResponse.fromJson(jsonData);
}

@JsonSerializable()
class CflRequestBranchResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  CflRequestBranchResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory CflRequestBranchResponse.fromJson(Map<String, dynamic> json) {
    return _$CflRequestBranchResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CflRequestBranchResponseToJson(this);
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

  @JsonKey(name: 'ToWhsCode')
  String toWhsCode;

  @JsonKey(name: 'ToWhsName')
  String toWhsName;

  @JsonKey(name: 'BranchId')
  int branchId;

  @JsonKey(name: 'BranchName')
  String branchName;

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
    this.toWhsCode,
    this.toWhsName,
    this.branchId,
    this.branchName,
    this.toBranchId,
    this.toBranchName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
