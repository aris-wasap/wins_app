// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final purchaseCreditDetailScanResponse = purchaseCreditDetailScanResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:admart_app/models/purchase_credit_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'purchase_credit_detail_scan_response.g.dart';

PurchaseCreditDetailScanResponse purchaseCreditDetailScanResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return PurchaseCreditDetailScanResponse.fromJson(jsonData);
}

@JsonSerializable()
class PurchaseCreditDetailScanResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Item data;  

  PurchaseCreditDetailScanResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory PurchaseCreditDetailScanResponse.fromJson(Map<String, dynamic> json) {
    return _$PurchaseCreditDetailScanResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PurchaseCreditDetailScanResponseToJson(this);
}
  
 