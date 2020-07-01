// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final purchaseReturnsDetailScanResponse = purchaseReturnsDetailScanResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:admart_app/models/purchase_returns_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'purchase_returns_detail_scan_response.g.dart';

PurchaseReturnsDetailScanResponse purchaseReturnsDetailScanResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return PurchaseReturnsDetailScanResponse.fromJson(jsonData);
}

@JsonSerializable()
class PurchaseReturnsDetailScanResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Item data;  

  PurchaseReturnsDetailScanResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory PurchaseReturnsDetailScanResponse.fromJson(Map<String, dynamic> json) {
    return _$PurchaseReturnsDetailScanResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PurchaseReturnsDetailScanResponseToJson(this);
}
  
 