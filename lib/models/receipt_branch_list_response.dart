// To parse this JSON data, do
//
//     final receiptBranchListResponse = receiptBranchListResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'receipt_branch_list_response.g.dart';

ReceiptBranchListResponse receiptBranchListResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return ReceiptBranchListResponse.fromJson(jsonData);
}

@JsonSerializable()
class ReceiptBranchListResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  ReceiptBranchListResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory ReceiptBranchListResponse.fromJson(Map<String, dynamic> json) {
    return _$ReceiptBranchListResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReceiptBranchListResponseToJson(this);
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

  @JsonKey(name: 'IssueNo')
  String issueNo;

  @JsonKey(name: 'BranchId')
  int branchId;

  @JsonKey(name: 'BranchName')
  String branchName;

  @JsonKey(name: 'FromBranchId')
  int fromBranchId;

  @JsonKey(name: 'FromBranchName')
  String fromBranchName;

  @JsonKey(name: 'SeriesNameIssue')
  String seriesNameIssue;

  Data({
    this.id,
    this.seriesName,
    this.userId,
    this.transNo,
    this.transDate,
    this.status,
    this.createdUser,
    this.issueNo,
    this.seriesNameIssue,
    this.branchId,
    this.branchName,
    this.fromBranchId,
    this.fromBranchName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
