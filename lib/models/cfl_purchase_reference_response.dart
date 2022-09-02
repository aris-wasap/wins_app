// To parse this JSON data, do
//
//     final cflPurchaseReferenceResponse = cflPurchaseReferenceResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'cfl_purchase_reference_response.g.dart';

CflPurchaseReferenceResponse cflPurchaseReferenceResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return CflPurchaseReferenceResponse.fromJson(jsonData);
}

@JsonSerializable()
class CflPurchaseReferenceResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  CflPurchaseReferenceResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory CflPurchaseReferenceResponse.fromJson(Map<String, dynamic> json) {
    return _$CflPurchaseReferenceResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CflPurchaseReferenceResponseToJson(this);
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

  @JsonKey(name: 'RefNo')
  String refNo;

  @JsonKey(name: 'ScaleNo')
  String scaleNo;

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
    this.refNo,
    this.scaleNo,
    this.seriesName,
    this.branchId,
    this.branchName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
