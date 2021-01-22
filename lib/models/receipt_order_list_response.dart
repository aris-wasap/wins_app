// To parse this JSON data, do
//
//     final receiptOrderListResponse = receiptOrderListResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'receipt_order_list_response.g.dart';

ReceiptOrderListResponse receiptOrderListResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return ReceiptOrderListResponse.fromJson(jsonData);
}

@JsonSerializable()
class ReceiptOrderListResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  ReceiptOrderListResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory ReceiptOrderListResponse.fromJson(Map<String, dynamic> json) {
    return _$ReceiptOrderListResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReceiptOrderListResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'UserId')
  int userId;

  @JsonKey(name: 'SapReceiptOrderNo')
  String sapReceiptOrderNo;

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
    this.sapReceiptOrderNo,
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
