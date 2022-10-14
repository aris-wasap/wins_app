// To parse this JSON data, do
//
//     final cflPurchaseOrderLabelResponse = cflPurchaseOrderLabelResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'cfl_purchase_order_label_response.g.dart';

CflPurchaseOrderLabelResponse cflPurchaseOrderLabelResponseFromJson(
    String str) {
  final jsonData = json.decode(str);
  return CflPurchaseOrderLabelResponse.fromJson(jsonData);
}

@JsonSerializable()
class CflPurchaseOrderLabelResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  CflPurchaseOrderLabelResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory CflPurchaseOrderLabelResponse.fromJson(Map<String, dynamic> json) {
    return _$CflPurchaseOrderLabelResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CflPurchaseOrderLabelResponseToJson(this);
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

  @JsonKey(name: 'DocEntry')
  int docEntry;

  @JsonKey(name: 'DocNum')
  String docNum;

  @JsonKey(name: 'DocDate')
  DateTime docDate;

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
    this.docEntry = 0,
    this.docNum,
    this.docDate,
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
