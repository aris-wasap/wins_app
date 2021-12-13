// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final receiptProductionDetailScanResponse = receiptProductionDetailScanResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:wins_app/models/receipt_production_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'receipt_production_detail_scan_response.g.dart';

ReceiptProductionDetailScanResponse receiptProductionDetailScanResponseFromJson(
    String str) {
  final jsonData = json.decode(str);
  return ReceiptProductionDetailScanResponse.fromJson(jsonData);
}

@JsonSerializable()
class ReceiptProductionDetailScanResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Item data;

  ReceiptProductionDetailScanResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory ReceiptProductionDetailScanResponse.fromJson(
      Map<String, dynamic> json) {
    return _$ReceiptProductionDetailScanResponseFromJson(json);
  }

  Map<String, dynamic> toJson() =>
      _$ReceiptProductionDetailScanResponseToJson(this);
}
