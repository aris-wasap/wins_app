// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final goodsReceiptDetailRefreshResponse = goodsReceiptDetailRefreshResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:wins_app/models/goods_receipt_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'goods_receipt_detail_refresh_response.g.dart';

GoodsReceiptDetailRefreshResponse goodsReceiptDetailRefreshResponseFromJson(
    String str) {
  final jsonData = json.decode(str);
  return GoodsReceiptDetailRefreshResponse.fromJson(jsonData);
}

@JsonSerializable()
class GoodsReceiptDetailRefreshResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Item> data;

  GoodsReceiptDetailRefreshResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory GoodsReceiptDetailRefreshResponse.fromJson(Map<String, dynamic> json) {
    return _$GoodsReceiptDetailRefreshResponseFromJson(json);
  }

  Map<String, dynamic> toJson() =>
      _$GoodsReceiptDetailRefreshResponseToJson(this);
}
