// To parse this JSON data, do
//
//     final warehouseResponse = warehouseResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'warehouse_response.g.dart';

WarehouseResponse warehouseResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return WarehouseResponse.fromJson(jsonData);
}
 

@JsonSerializable()
class WarehouseResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  WarehouseResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory WarehouseResponse.fromJson(Map<String, dynamic> json) {
    return _$WarehouseResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$WarehouseResponseToJson(this);
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

  Data({  
    this.branchId,
    this.branchName,
    this.whsCode, 
    this.whsName, 
  });

 factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
