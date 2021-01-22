// To parse this JSON data, do
//
//     final payableCreditListResponse = payableCreditListResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'payable_credit_list_response.g.dart';

PayableCreditListResponse payableCreditListResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return PayableCreditListResponse.fromJson(jsonData);
}

@JsonSerializable()
class PayableCreditListResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  PayableCreditListResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory PayableCreditListResponse.fromJson(Map<String, dynamic> json) {
    return _$PayableCreditListResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PayableCreditListResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'UserId')
  int userId;

  @JsonKey(name: 'SapReturnNo')
  String sapReturnNo;

  @JsonKey(name: 'ReturnRequestNo')
  String returnRequestNo;

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
    this.sapReturnNo,
    this.returnRequestNo,
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
