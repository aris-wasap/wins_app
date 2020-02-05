// To parse this JSON data, do
//
//     final cflGoodsIssueResponse = cflGoodsIssueResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'cfl_goods_issue_response.g.dart';

CflGoodsIssueResponse cflGoodsIssueResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return CflGoodsIssueResponse.fromJson(jsonData);
}
 

@JsonSerializable()
class CflGoodsIssueResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  CflGoodsIssueResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory CflGoodsIssueResponse.fromJson(Map<String, dynamic> json) {
    return _$CflGoodsIssueResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CflGoodsIssueResponseToJson(this);
}

@JsonSerializable()
class Data { 
  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'TransNo')
  String transNo;  

  @JsonKey(name: 'DocNum')
  String docNum;

  @JsonKey(name:'SeriesName')
  String seriesName;

  @JsonKey(name: 'TransDate')
  DateTime transDate;  

  @JsonKey(name: 'Status')
  String status;  

  Data({ 
    this.id=0,
    this.seriesName,
    this.transNo,
    this.docNum, 
    this.transDate, 
    this.status, 
  });

 factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
