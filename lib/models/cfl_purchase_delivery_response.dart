// To parse this JSON data, do
//
//     final cflPurchaseDeliveryResponse = cflPurchaseDeliveryResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'cfl_purchase_delivery_response.g.dart';

CflPurchaseDeliveryResponse cflPurchaseDeliveryResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return CflPurchaseDeliveryResponse.fromJson(jsonData);
}

@JsonSerializable()
class CflPurchaseDeliveryResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  CflPurchaseDeliveryResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory CflPurchaseDeliveryResponse.fromJson(Map<String, dynamic> json) {
    return _$CflPurchaseDeliveryResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CflPurchaseDeliveryResponseToJson(this);
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

  @JsonKey(name: 'VendorCode')
  String vendorCode;

  @JsonKey(name: 'VendorName')
  String vendorName;

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
    this.vendorCode,
    this.vendorName,
    this.seriesName,
    this.branchId,
    this.branchName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
