// To parse this JSON data, do
//
//     final purchaseReturnsListResponse = purchaseReturnsListResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'purchase_returns_list_response.g.dart';

PurchaseReturnsListResponse purchaseReturnsListResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return PurchaseReturnsListResponse.fromJson(jsonData);
}

@JsonSerializable()
class PurchaseReturnsListResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  PurchaseReturnsListResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory PurchaseReturnsListResponse.fromJson(Map<String, dynamic> json) {
    return _$PurchaseReturnsListResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PurchaseReturnsListResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'UserId')
  int userId;

  @JsonKey(name: 'TransNo')
  String transNo;

  @JsonKey(name: 'TransDate')
  DateTime transDate;

  @JsonKey(name: 'VendorCode')
  String vendorCode;

  @JsonKey(name: 'VendorName')
  String vendorName;

  @JsonKey(name: 'Status')
  String status;

  @JsonKey(name: 'CreatedUser')
  String createdUser;

  @JsonKey(name: 'SeriesName')
  String seriesName;

  @JsonKey(name: 'BranchId')
  int branchId;

  @JsonKey(name: 'BranchName')
  String branchName;

  Data({
    this.id,
    this.userId,
    this.transNo,
    this.transDate,
    this.vendorCode,
    this.vendorName,
    this.status,
    this.createdUser,
    this.seriesName,
    this.branchId,
    this.branchName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
