// To parse this JSON data, do
//
//     final cflBatchLocationResponse = cflBatchLocationResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'cfl_batch_location_response.g.dart';

CflBatchLocationResponse cflBatchLocationResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return CflBatchLocationResponse.fromJson(jsonData);
}

@JsonSerializable()
class CflBatchLocationResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  CflBatchLocationResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory CflBatchLocationResponse.fromJson(Map<String, dynamic> json) {
    return _$CflBatchLocationResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CflBatchLocationResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'BatchNumber')
  String batchNumber;

  @JsonKey(name: 'AbsEntry')
  int absEntry;

  @JsonKey(name: 'BinCode')
  String binCode;

  @JsonKey(name: 'WhsCode')
  String whsCode;

  @JsonKey(name: 'AvailableQty')
  double availableQty;

  @JsonKey(name: 'SysBin')
  String sysBin;

  @JsonKey(name: 'Uom')
  String uom;

  Data({
    this.batchNumber,
    this.absEntry,
    this.binCode,
    this.whsCode,
    this.availableQty,
    this.sysBin,
    this.uom,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
