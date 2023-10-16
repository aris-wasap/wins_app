// To parse this JSON data, do
//
//     final goodsIssueMixingListResponse = goodsIssueMixingListResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'goods_issue_mixing_list_response.g.dart';

GoodsIssueMixingListResponse goodsIssueMixingListResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return GoodsIssueMixingListResponse.fromJson(jsonData);
}

@JsonSerializable()
class GoodsIssueMixingListResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  GoodsIssueMixingListResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory GoodsIssueMixingListResponse.fromJson(Map<String, dynamic> json) {
    return _$GoodsIssueMixingListResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GoodsIssueMixingListResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'RecordNo')
  int recordNo;

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'UserId')
  int userId;

  @JsonKey(name: 'TransNo')
  String transNo;

  @JsonKey(name: 'TransDate')
  DateTime transDate;

  @JsonKey(name: 'WoStatus')
  String woStatus;

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

  @JsonKey(name: 'PlannedQty')
  double plannedQty;

  @JsonKey(name: 'Uom')
  String uom;

  @JsonKey(name: 'ProductionType')
  String productionType;

  Data({
    this.recordNo,
    this.id,
    this.userId,
    this.transNo,
    this.transDate,
    this.woStatus,
    this.status,
    this.createdUser,
    this.seriesName,
    this.woNo,
    this.seriesNameWo,
    this.productCode,
    this.productName,
    this.plannedQty,
    this.uom,
    this.productionType,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
