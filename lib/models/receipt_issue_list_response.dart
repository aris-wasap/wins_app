// To parse this JSON data, do
//
//     final receiptIssueListResponse = receiptIssueListResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'receipt_issue_list_response.g.dart';

ReceiptIssueListResponse receiptIssueListResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return ReceiptIssueListResponse.fromJson(jsonData);
}

@JsonSerializable()
class ReceiptIssueListResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  ReceiptIssueListResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory ReceiptIssueListResponse.fromJson(Map<String, dynamic> json) {
    return _$ReceiptIssueListResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReceiptIssueListResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'UserId')
  int userId;

  @JsonKey(name:'SeriesName')
  String seriesName;

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
    this.seriesName,
    this.userId,
    this.transNo,
    this.transDate,
    this.status, 
    this.createdUser, 
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
