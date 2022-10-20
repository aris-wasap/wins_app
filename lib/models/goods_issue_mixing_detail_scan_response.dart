// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final goodsIssueMixingDetailScanResponse = goodsIssueMixingDetailScanResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:wins_app/models/goods_issue_mixing_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'goods_issue_mixing_detail_scan_response.g.dart';

GoodsIssueMixingDetailScanResponse goodsIssueMixingDetailScanResponseFromJson(
    String str) {
  final jsonData = json.decode(str);
  return GoodsIssueMixingDetailScanResponse.fromJson(jsonData);
}

@JsonSerializable()
class GoodsIssueMixingDetailScanResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Item data;

  GoodsIssueMixingDetailScanResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory GoodsIssueMixingDetailScanResponse.fromJson(
      Map<String, dynamic> json) {
    return _$GoodsIssueMixingDetailScanResponseFromJson(json);
  }

  Map<String, dynamic> toJson() =>
      _$GoodsIssueMixingDetailScanResponseToJson(this);
}
