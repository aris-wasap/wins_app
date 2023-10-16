// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final goodsReceiptDetailScanBatchResponse = goodsReceiptDetailScanBatchResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:wins_app/models/goods_receipt_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'goods_receipt_detail_scan_batch_response.g.dart';

GoodsReceiptDetailScanBatchResponse goodsReceiptDetailScanBatchResponseFromJson(
    String str) {
  final jsonData = json.decode(str);
  return GoodsReceiptDetailScanBatchResponse.fromJson(jsonData);
}

@JsonSerializable()
class GoodsReceiptDetailScanBatchResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  ItemBatch dataBatch;

  GoodsReceiptDetailScanBatchResponse({
    this.error,
    this.errorMessage,
    this.dataBatch,
  });

  factory GoodsReceiptDetailScanBatchResponse.fromJson(
      Map<String, dynamic> json) {
    return _$GoodsReceiptDetailScanBatchResponseFromJson(json);
  }

  Map<String, dynamic> toJson() =>
      _$GoodsReceiptDetailScanBatchResponseToJson(this);
}
