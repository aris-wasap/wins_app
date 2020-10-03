// To parse this JSON data, do
//
//     final requestIssueListResponse = requestIssueListResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'request_issue_list_response.g.dart';

RequestIssueListResponse requestIssueListResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return RequestIssueListResponse.fromJson(jsonData);
}

@JsonSerializable()
class RequestIssueListResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  RequestIssueListResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory RequestIssueListResponse.fromJson(Map<String, dynamic> json) {
    return _$RequestIssueListResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RequestIssueListResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'UserId')
  int userId;

  @JsonKey(name: 'SapRequestIssueNo')
  String sapRequestIssueNo;

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

  Data({
    this.id,
    this.seriesName,
    this.userId,
    this.sapRequestIssueNo,
    this.transNo,
    this.transDate,
    this.status,
    this.createdUser,
    this.branchId,
    this.branchName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
