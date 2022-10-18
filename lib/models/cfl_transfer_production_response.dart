// To parse this JSON data, do
//
//     final cflTransferProductionResponse = cflTransferProductionResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'cfl_transfer_production_response.g.dart';

CflTransferProductionResponse cflTransferProductionResponseFromJson(
    String str) {
  final jsonData = json.decode(str);
  return CflTransferProductionResponse.fromJson(jsonData);
}

@JsonSerializable()
class CflTransferProductionResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  CflTransferProductionResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory CflTransferProductionResponse.fromJson(Map<String, dynamic> json) {
    return _$CflTransferProductionResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CflTransferProductionResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'TransNo')
  String transNo;

  @JsonKey(name: 'TransDate')
  DateTime transDate;

  @JsonKey(name: 'ProductCode')
  String productCode;

  @JsonKey(name: 'ProductName')
  String productName;

  @JsonKey(name: 'WhsCode')
  String whsCode;

  @JsonKey(name: 'WhsName')
  String whsName;

  @JsonKey(name: 'PlannedQty')
  double plannedQty;

  @JsonKey(name: 'Uom')
  String uom;

  @JsonKey(name: 'Status')
  String status;

  Data({
    this.id = 0,
    this.transNo,
    this.transDate,
    this.productCode,
    this.productName,
    this.whsCode,
    this.whsName,
    this.plannedQty: 0,
    this.uom,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
