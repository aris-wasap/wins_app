// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final goodsReceiptDetailScanResponse = goodsReceiptDetailScanResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:wins_app/models/goods_receipt_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'goods_receipt_detail_scan_response.g.dart';

GoodsReceiptDetailScanResponse goodsReceiptDetailScanResponseFromJson(
    String str) {
  final jsonData = json.decode(str);
  return GoodsReceiptDetailScanResponse.fromJson(jsonData);
}

@JsonSerializable()
class GoodsReceiptDetailScanResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Item data;

  GoodsReceiptDetailScanResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory GoodsReceiptDetailScanResponse.fromJson(Map<String, dynamic> json) {
    return _$GoodsReceiptDetailScanResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GoodsReceiptDetailScanResponseToJson(this);
}
