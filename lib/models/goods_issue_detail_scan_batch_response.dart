// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final goodsIssueDetailScanBatchResponse = goodsIssueDetailScanBatchResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:wins_app/models/goods_issue_mixing_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'goods_issue_detail_scan_batch_response.g.dart';

GoodsIssueDetailScanBatchResponse goodsIssueDetailScanBatchResponseFromJson(
    String str) {
  final jsonData = json.decode(str);
  return GoodsIssueDetailScanBatchResponse.fromJson(jsonData);
}

@JsonSerializable()
class GoodsIssueDetailScanBatchResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  ItemBatch dataBatch;

  GoodsIssueDetailScanBatchResponse({
    this.error,
    this.errorMessage,
    this.dataBatch,
  });

  factory GoodsIssueDetailScanBatchResponse.fromJson(
      Map<String, dynamic> json) {
    return _$GoodsIssueDetailScanBatchResponseFromJson(json);
  }

  Map<String, dynamic> toJson() =>
      _$GoodsIssueDetailScanBatchResponseToJson(this);
}
