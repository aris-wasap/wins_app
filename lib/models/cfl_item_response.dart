// To parse this JSON data, do
//
//     final cflItemResponse = cflItemResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'cfl_item_response.g.dart';

CflItemResponse cflItemResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return CflItemResponse.fromJson(jsonData);
}

@JsonSerializable()
class CflItemResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  CflItemResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory CflItemResponse.fromJson(Map<String, dynamic> json) {
    return _$CflItemResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CflItemResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'ItemCode')
  String itemCode;

  @JsonKey(name: 'ItemName')
  String itemName;

  Data({
    this.itemCode,
    this.itemName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
