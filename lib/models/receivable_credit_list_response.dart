// To parse this JSON data, do
//
//     final receivableCreditListResponse = receivableCreditListResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'receivable_credit_list_response.g.dart';

ReceivableCreditListResponse receivableCreditListResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return ReceivableCreditListResponse.fromJson(jsonData);
}

@JsonSerializable()
class ReceivableCreditListResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  ReceivableCreditListResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory ReceivableCreditListResponse.fromJson(Map<String, dynamic> json) {
    return _$ReceivableCreditListResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReceivableCreditListResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'UserId')
  int userId;

  @JsonKey(name: 'SapReceivableCreditNo')
  String sapReceivableCreditNo;

  @JsonKey(name: 'TransNo')
  String transNo;

  @JsonKey(name: 'SeriesName')
  String seriesName;

  @JsonKey(name: 'TransDate')
  DateTime transDate;

  @JsonKey(name: 'CustomerCode')
  String customerCode;

  @JsonKey(name: 'CustomerName')
  String customerName;

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
    this.userId,
    this.sapReceivableCreditNo,
    this.transNo,
    this.transDate,
    this.customerCode,
    this.customerName,
    this.status,
    this.createdUser,
    this.branchId,
    this.branchName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
