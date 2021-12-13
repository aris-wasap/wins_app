// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final goodsIssueDetailScanResponse = goodsIssueDetailScanResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:wins_app/models/goods_issue_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'goods_issue_detail_scan_response.g.dart';

GoodsIssueDetailScanResponse goodsIssueDetailScanResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return GoodsIssueDetailScanResponse.fromJson(jsonData);
}

@JsonSerializable()
class GoodsIssueDetailScanResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Item data;

  GoodsIssueDetailScanResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory GoodsIssueDetailScanResponse.fromJson(Map<String, dynamic> json) {
    return _$GoodsIssueDetailScanResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GoodsIssueDetailScanResponseToJson(this);
}
