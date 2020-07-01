// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final goodsIssueDetailRefreshResponse = goodsIssueDetailRefreshResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:admart_app/models/goods_issue_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'goods_issue_detail_refresh_response.g.dart';

GoodsIssueDetailRefreshResponse goodsIssueDetailRefreshResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return GoodsIssueDetailRefreshResponse.fromJson(jsonData);
}

@JsonSerializable()
class GoodsIssueDetailRefreshResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Item> data;

  GoodsIssueDetailRefreshResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory GoodsIssueDetailRefreshResponse.fromJson(Map<String, dynamic> json) {
    return _$GoodsIssueDetailRefreshResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GoodsIssueDetailRefreshResponseToJson(this);
}
 