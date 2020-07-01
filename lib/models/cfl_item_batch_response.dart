// To parse this JSON data, do
//
//     final cflItemBatchResponse = cflItemBatchResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'cfl_item_batch_response.g.dart';

CflItemBatchResponse cflItemBatchResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return CflItemBatchResponse.fromJson(jsonData);
}
 

@JsonSerializable()
class CflItemBatchResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  CflItemBatchResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory CflItemBatchResponse.fromJson(Map<String, dynamic> json) {
    return _$CflItemBatchResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CflItemBatchResponseToJson(this);
}

@JsonSerializable()
class Data { 
  @JsonKey(name: 'SysNumber')
  int sysNumber;

  @JsonKey(name: 'LineNum')
  int lineNum;

  @JsonKey(name: 'ItemCode')
  String itemCode;  

  @JsonKey(name: 'ItemName')
  String itemName;  

  @JsonKey(name: 'BatchNumber')
  String batchNumber;

  @JsonKey(name: 'AbsEntry')
  int absEntry;

  @JsonKey(name: 'BinCode')
  String binCode;  

  @JsonKey(name: 'WhsCode')
  String whsCode;

  @JsonKey(name: 'PlannedQty')
  double plannedQty; 

  @JsonKey(name: 'AvailableQty')
  double availableQty;

  @JsonKey(name: 'IssueQty')
  double issueQty;

  @JsonKey(name: 'OpenQty')
  double openQty;  

  @JsonKey(name: 'Location')
  String location;  

  Data({ 
    this.sysNumber,
    this.itemCode,
    this.itemName, 
    this.batchNumber,
    this.absEntry,
    this.binCode,
    this.whsCode,
    this.plannedQty,
    this.availableQty,
    this.issueQty,
    this.openQty, 
    this.location
  });

 factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
