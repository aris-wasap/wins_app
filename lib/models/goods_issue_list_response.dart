// To parse this JSON data, do
//
//     final goodsIssueListResponse = goodsIssueListResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'goods_issue_list_response.g.dart';

GoodsIssueListResponse goodsIssueListResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return GoodsIssueListResponse.fromJson(jsonData);
}

@JsonSerializable()
class GoodsIssueListResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  GoodsIssueListResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory GoodsIssueListResponse.fromJson(Map<String, dynamic> json) {
    return _$GoodsIssueListResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GoodsIssueListResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'UserId')
  int userId;

  @JsonKey(name: 'TransNo')
  String transNo;

  @JsonKey(name: 'TransDate')
  DateTime transDate;

  @JsonKey(name: 'Status')
  String status;
  
  @JsonKey(name: 'CreatedUser')
  String createdUser;

  @JsonKey(name: 'SeriesName')
  String seriesName;

  @JsonKey(name: 'WoNo')
  String woNo;

  @JsonKey(name: 'SeriesNameWo')
  String seriesNameWo;

  @JsonKey(name: 'ProductCode')
  String productCode;

  @JsonKey(name: 'ProductName')
  String productName;
 

  Data({
    this.id,
    this.userId,
    this.transNo,
    this.transDate,
    this.status, 
    this.createdUser, 
    this.seriesName,
    this.woNo,
    this.seriesNameWo,
    this.productCode,
    this.productName
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
