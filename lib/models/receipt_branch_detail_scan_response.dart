// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final receiptBranchDetailScanResponse = receiptBranchDetailScanResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:wins_app/models/receipt_branch_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'receipt_branch_detail_scan_response.g.dart';

ReceiptBranchDetailScanResponse receiptBranchDetailScanResponseFromJson(
    String str) {
  final jsonData = json.decode(str);
  return ReceiptBranchDetailScanResponse.fromJson(jsonData);
}

@JsonSerializable()
class ReceiptBranchDetailScanResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Item data;

  ReceiptBranchDetailScanResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory ReceiptBranchDetailScanResponse.fromJson(Map<String, dynamic> json) {
    return _$ReceiptBranchDetailScanResponseFromJson(json);
  }

  Map<String, dynamic> toJson() =>
      _$ReceiptBranchDetailScanResponseToJson(this);
}
