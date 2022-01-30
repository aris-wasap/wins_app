// To parse this JSON data, do
//
//     final goodsReceiptListResponse = goodsReceiptListResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'goods_receipt_list_response.g.dart';

GoodsReceiptListResponse goodsReceiptListResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return GoodsReceiptListResponse.fromJson(jsonData);
}

@JsonSerializable()
class GoodsReceiptListResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  GoodsReceiptListResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory GoodsReceiptListResponse.fromJson(Map<String, dynamic> json) {
    return _$GoodsReceiptListResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GoodsReceiptListResponseToJson(this);
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

  @JsonKey(name: 'SapGoodsReceiptNo')
  String sapGoodsReceiptNo;

  @JsonKey(name: 'ProductCode')
  String productCode;

  @JsonKey(name: 'ProductName')
  String productName;

  
  @JsonKey(name: 'BranchId')
  int branchId;

  @JsonKey(name: 'BranchName')
  String branchName;
 

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
    this.sapGoodsReceiptNo,
    this.productCode,
    this.productName,
    this.branchId,
    this.branchName
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
