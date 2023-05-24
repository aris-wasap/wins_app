// To parse this JSON data, do
//
//     final cflReceiptProductionLabelResponse = cflReceiptProductionLabelResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'cfl_receipt_production_label_response.g.dart';

CflReceiptProductionLabelResponse cflReceiptProductionLabelResponseFromJson(
    String str) {
  final jsonData = json.decode(str);
  return CflReceiptProductionLabelResponse.fromJson(jsonData);
}

@JsonSerializable()
class CflReceiptProductionLabelResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  CflReceiptProductionLabelResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory CflReceiptProductionLabelResponse.fromJson(Map<String, dynamic> json) {
    return _$CflReceiptProductionLabelResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CflReceiptProductionLabelResponseToJson(this);
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

  @JsonKey(name: 'WoId')
  int woId;

  @JsonKey(name: 'WoNo')
  String woNo;

  @JsonKey(name: 'ProductCode')
  String productCode;

  @JsonKey(name: 'ProductName')
  String productName;

  @JsonKey(name: 'SeriesName')
  String seriesName;

  @JsonKey(name: 'BranchId')
  int branchId;

  @JsonKey(name: 'BranchName')
  String branchName;

  Data({
    this.id: 0,
    this.transNo,
    this.transDate,
    this.docEntry: 0,
    this.docNum,
    this.docDate,
    this.woId : 0,
    this.woNo,
    this.status,
    this.productCode,
    this.productName,
    this.seriesName,
    this.branchId,
    this.branchName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
