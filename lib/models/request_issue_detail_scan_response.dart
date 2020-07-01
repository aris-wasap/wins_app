// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final requestIssueDetailScanResponse = requestIssueDetailScanResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:admart_app/models/request_issue_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'request_issue_detail_scan_response.g.dart';

RequestIssueDetailScanResponse requestIssueDetailScanResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return RequestIssueDetailScanResponse.fromJson(jsonData);
}

@JsonSerializable()
class RequestIssueDetailScanResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Item data;  

  RequestIssueDetailScanResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory RequestIssueDetailScanResponse.fromJson(Map<String, dynamic> json) {
    return _$RequestIssueDetailScanResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RequestIssueDetailScanResponseToJson(this);
}
  
 