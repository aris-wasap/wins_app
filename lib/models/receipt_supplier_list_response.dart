// To parse this JSON data, do
//
//     final receiptSupplierListResponse = receiptSupplierListResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'receipt_supplier_list_response.g.dart';

ReceiptSupplierListResponse receiptSupplierListResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return ReceiptSupplierListResponse.fromJson(jsonData);
}

@JsonSerializable()
class ReceiptSupplierListResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  ReceiptSupplierListResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory ReceiptSupplierListResponse.fromJson(Map<String, dynamic> json) {
    return _$ReceiptSupplierListResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReceiptSupplierListResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'UserId')
  int userId;

  @JsonKey(name: 'SapReceiptSupplierNo')
  String sapReceiptSupplierNo;

  @JsonKey(name: 'PoNo')
  String poNo;

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
    this.sapReceiptSupplierNo,
    this.poNo,
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
