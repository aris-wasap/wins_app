// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final receiptOrderDetailScanResponse = receiptOrderDetailScanResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:admart_app/models/receipt_order_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'receipt_order_detail_scan_response.g.dart';

ReceiptOrderDetailScanResponse receiptOrderDetailScanResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return ReceiptOrderDetailScanResponse.fromJson(jsonData);
}

@JsonSerializable()
class ReceiptOrderDetailScanResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Item data;  

  ReceiptOrderDetailScanResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory ReceiptOrderDetailScanResponse.fromJson(Map<String, dynamic> json) {
    return _$ReceiptOrderDetailScanResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReceiptOrderDetailScanResponseToJson(this);
}
  
 