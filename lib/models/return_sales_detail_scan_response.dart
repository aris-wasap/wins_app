// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final returnSalesDetailScanResponse = returnSalesDetailScanResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:ncf_app/models/return_sales_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'return_sales_detail_scan_response.g.dart';

ReturnSalesDetailScanResponse returnSalesDetailScanResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return ReturnSalesDetailScanResponse.fromJson(jsonData);
}

@JsonSerializable()
class ReturnSalesDetailScanResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Item data;  

  ReturnSalesDetailScanResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory ReturnSalesDetailScanResponse.fromJson(Map<String, dynamic> json) {
    return _$ReturnSalesDetailScanResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReturnSalesDetailScanResponseToJson(this);
}
  
 