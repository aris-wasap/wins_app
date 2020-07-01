// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final issueProductionDetailScanResponse = issueProductionDetailScanResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:admart_app/models/issue_production_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'issue_production_detail_scan_response.g.dart';

IssueProductionDetailScanResponse issueProductionDetailScanResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return IssueProductionDetailScanResponse.fromJson(jsonData);
}

@JsonSerializable()
class IssueProductionDetailScanResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Item data;  

  IssueProductionDetailScanResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory IssueProductionDetailScanResponse.fromJson(Map<String, dynamic> json) {
    return _$IssueProductionDetailScanResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$IssueProductionDetailScanResponseToJson(this);
}
  
 