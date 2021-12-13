// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final receivableCreditDetailScanResponse = receivableCreditDetailScanResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:wins_app/models/receivable_credit_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'receivable_credit_detail_scan_response.g.dart';

ReceivableCreditDetailScanResponse receivableCreditDetailScanResponseFromJson(
    String str) {
  final jsonData = json.decode(str);
  return ReceivableCreditDetailScanResponse.fromJson(jsonData);
}

@JsonSerializable()
class ReceivableCreditDetailScanResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Item data;

  ReceivableCreditDetailScanResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory ReceivableCreditDetailScanResponse.fromJson(
      Map<String, dynamic> json) {
    return _$ReceivableCreditDetailScanResponseFromJson(json);
  }

  Map<String, dynamic> toJson() =>
      _$ReceivableCreditDetailScanResponseToJson(this);
}
