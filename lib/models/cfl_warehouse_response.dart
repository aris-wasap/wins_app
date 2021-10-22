// To parse this JSON data, do
//
//     final cflWarehouseResponse = cflWarehouseResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'cfl_warehouse_response.g.dart';

CflWarehouseResponse cflWarehouseResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return CflWarehouseResponse.fromJson(jsonData);
}

@JsonSerializable()
class CflWarehouseResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  CflWarehouseResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory CflWarehouseResponse.fromJson(Map<String, dynamic> json) {
    return _$CflWarehouseResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CflWarehouseResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'BranchId')
  int branchId;

  @JsonKey(name: 'BranchName')
  String branchName;

  @JsonKey(name: 'WhsCode')
  String whsCode;

  @JsonKey(name: 'WhsName')
  String whsName;

  @JsonKey(name: 'AbsEntry')
  int absEntry;

  @JsonKey(name: 'BinCode')
  String binCode;

  Data({
    this.branchId,
    this.branchName,
    this.whsCode,
    this.whsName,
    this.absEntry,
    this.binCode,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
