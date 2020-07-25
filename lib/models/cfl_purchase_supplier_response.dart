// To parse this JSON data, do
//
//     final cflPurchaseSupplierResponse = cflPurchaseSupplierResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'cfl_purchase_supplier_response.g.dart';

CflPurchaseSupplierResponse cflPurchaseSupplierResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return CflPurchaseSupplierResponse.fromJson(jsonData);
}

@JsonSerializable()
class CflPurchaseSupplierResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  CflPurchaseSupplierResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory CflPurchaseSupplierResponse.fromJson(Map<String, dynamic> json) {
    return _$CflPurchaseSupplierResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CflPurchaseSupplierResponseToJson(this);
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

  @JsonKey(name: 'CustomerCode')
  String customerCode;

  @JsonKey(name: 'CustomerName')
  String customerName;

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
    this.customerCode,
    this.customerName,
    this.seriesName,
    this.branchId,
    this.branchName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
