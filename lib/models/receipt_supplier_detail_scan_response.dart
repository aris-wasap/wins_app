// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final receiptSupplierDetailScanResponse = receiptSupplierDetailScanResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:wins_app/models/receipt_supplier_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'receipt_supplier_detail_scan_response.g.dart';

ReceiptSupplierDetailScanResponse receiptSupplierDetailScanResponseFromJson(
    String str) {
  final jsonData = json.decode(str);
  return ReceiptSupplierDetailScanResponse.fromJson(jsonData);
}

@JsonSerializable()
class ReceiptSupplierDetailScanResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Item data;

  ReceiptSupplierDetailScanResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory ReceiptSupplierDetailScanResponse.fromJson(
      Map<String, dynamic> json) {
    return _$ReceiptSupplierDetailScanResponseFromJson(json);
  }

  Map<String, dynamic> toJson() =>
      _$ReceiptSupplierDetailScanResponseToJson(this);
}
