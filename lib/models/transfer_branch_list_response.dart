// To parse this JSON data, do
//
//     final transferBranchListResponse = transferBranchListResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'transfer_branch_list_response.g.dart';

TransferBranchListResponse transferBranchListResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return TransferBranchListResponse.fromJson(jsonData);
}

@JsonSerializable()
class TransferBranchListResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  TransferBranchListResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory TransferBranchListResponse.fromJson(Map<String, dynamic> json) {
    return _$TransferBranchListResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TransferBranchListResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'UserId')
  int userId;

  @JsonKey(name: 'SeriesName')
  String seriesName;

  @JsonKey(name: 'TransNo')
  String transNo;

  @JsonKey(name: 'TransDate')
  DateTime transDate;

  @JsonKey(name: 'Status')
  String status;

  @JsonKey(name: 'CreatedUser')
  String createdUser;

  @JsonKey(name: 'BranchId')
  int branchId;

  @JsonKey(name: 'BranchName')
  String branchName;

  @JsonKey(name: 'ToBranchId')
  int toBranchId;

  @JsonKey(name: 'ToBranchName')
  String toBranchName;

  Data({
    this.id,
    this.seriesName,
    this.userId,
    this.transNo,
    this.transDate,
    this.status,
    this.createdUser,
    this.branchId,
    this.branchName,
    this.toBranchId,
    this.toBranchName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
