// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final transferBranchDetailScanResponse = transferBranchDetailScanResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:admart_app/models/transfer_branch_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'transfer_branch_detail_scan_response.g.dart';

TransferBranchDetailScanResponse transferBranchDetailScanResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return TransferBranchDetailScanResponse.fromJson(jsonData);
}

@JsonSerializable()
class TransferBranchDetailScanResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Item data;  

  TransferBranchDetailScanResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory TransferBranchDetailScanResponse.fromJson(Map<String, dynamic> json) {
    return _$TransferBranchDetailScanResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TransferBranchDetailScanResponseToJson(this);
}
  
 