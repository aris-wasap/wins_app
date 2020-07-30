// To parse this JSON data, do
//
//     final cflTransferBranchResponse = cflTransferBranchResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'cfl_transfer_branch_response.g.dart';

CflTransferBranchResponse cflTransferBranchResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return CflTransferBranchResponse.fromJson(jsonData);
}

@JsonSerializable()
class CflTransferBranchResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  CflTransferBranchResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory CflTransferBranchResponse.fromJson(Map<String, dynamic> json) {
    return _$CflTransferBranchResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CflTransferBranchResponseToJson(this);
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
    this.seriesName,
    this.branchId,
    this.branchName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
