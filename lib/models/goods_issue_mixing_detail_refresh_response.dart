// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final goodsIssueMixingDetailRefreshResponse = goodsIssueMixingDetailRefreshResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:wins_app/models/goods_issue_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'goods_issue_mixing_detail_refresh_response.g.dart';

GoodsIssueMixingDetailRefreshResponse
    goodsIssueMixingDetailRefreshResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return GoodsIssueMixingDetailRefreshResponse.fromJson(jsonData);
}

@JsonSerializable()
class GoodsIssueMixingDetailRefreshResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Item> data;

  GoodsIssueMixingDetailRefreshResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory GoodsIssueMixingDetailRefreshResponse.fromJson(
      Map<String, dynamic> json) {
    return _$GoodsIssueMixingDetailRefreshResponseFromJson(json);
  }

  Map<String, dynamic> toJson() =>
      _$GoodsIssueMixingDetailRefreshResponseToJson(this);
}
