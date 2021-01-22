// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final payableCreditDetailScanResponse = payableCreditDetailScanResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:admart_app/models/payable_credit_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'payable_credit_detail_scan_response.g.dart';

PayableCreditDetailScanResponse payableCreditDetailScanResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return PayableCreditDetailScanResponse.fromJson(jsonData);
}

@JsonSerializable()
class PayableCreditDetailScanResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Item data;  

  PayableCreditDetailScanResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory PayableCreditDetailScanResponse.fromJson(Map<String, dynamic> json) {
    return _$PayableCreditDetailScanResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PayableCreditDetailScanResponseToJson(this);
}
  
 