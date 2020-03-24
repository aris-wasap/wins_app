// To parse this JSON data, do
//
//     final cflBinLocationResponse = cflBinLocationResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'cfl_binlocation_response.g.dart';

CflBinLocationResponse cflBinLocationResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return CflBinLocationResponse.fromJson(jsonData);
}
 

@JsonSerializable()
class CflBinLocationResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  CflBinLocationResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory CflBinLocationResponse.fromJson(Map<String, dynamic> json) {
    return _$CflBinLocationResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CflBinLocationResponseToJson(this);
}

@JsonSerializable()
class Data { 
  @JsonKey(name: 'AbsEntry')
  int absEntry;

  @JsonKey(name: 'BinCode')
  String binCode;  

  @JsonKey(name: 'WhsCode')
  String whsCode;  

  @JsonKey(name: 'SysBin')
  String sysBin;  

  Data({ 
    this.absEntry,
    this.binCode,
    this.whsCode, 
    this.sysBin
  });

 factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
