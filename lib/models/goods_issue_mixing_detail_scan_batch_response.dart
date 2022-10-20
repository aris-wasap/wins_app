// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final goodsIssueMixingDetailScanBatchResponse = goodsIssueMixingDetailScanBatchResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:wins_app/models/goods_issue_mixing_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'goods_issue_mixing_detail_scan_batch_response.g.dart';

GoodsIssueMixingDetailScanBatchResponse goodsIssueMixingDetailScanBatchResponseFromJson(
    String str) {
  final jsonData = json.decode(str);
  return GoodsIssueMixingDetailScanBatchResponse.fromJson(jsonData);
}

@JsonSerializable()
class GoodsIssueMixingDetailScanBatchResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  ItemBatch dataBatch;

  GoodsIssueMixingDetailScanBatchResponse({
    this.error,
    this.errorMessage,
    this.dataBatch,
  });

  factory GoodsIssueMixingDetailScanBatchResponse.fromJson(
      Map<String, dynamic> json) {
    return _$GoodsIssueMixingDetailScanBatchResponseFromJson(json);
  }

  Map<String, dynamic> toJson() =>
      _$GoodsIssueMixingDetailScanBatchResponseToJson(this);
}
