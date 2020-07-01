// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final receiptIssueDetailScanResponse = receiptIssueDetailScanResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:admart_app/models/receipt_issue_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'receipt_issue_detail_scan_response.g.dart';

ReceiptIssueDetailScanResponse receiptIssueDetailScanResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return ReceiptIssueDetailScanResponse.fromJson(jsonData);
}

@JsonSerializable()
class ReceiptIssueDetailScanResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Item data;  

  ReceiptIssueDetailScanResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory ReceiptIssueDetailScanResponse.fromJson(Map<String, dynamic> json) {
    return _$ReceiptIssueDetailScanResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReceiptIssueDetailScanResponseToJson(this);
}
  
 