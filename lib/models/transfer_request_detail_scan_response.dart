// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final transferRequestDetailScanResponse = transferRequestDetailScanResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:ncf_app/models/transfer_request_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'transfer_request_detail_scan_response.g.dart';

TransferRequestDetailScanResponse transferRequestDetailScanResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return TransferRequestDetailScanResponse.fromJson(jsonData);
}

@JsonSerializable()
class TransferRequestDetailScanResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Item data;  

  TransferRequestDetailScanResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory TransferRequestDetailScanResponse.fromJson(Map<String, dynamic> json) {
    return _$TransferRequestDetailScanResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TransferRequestDetailScanResponseToJson(this);
}
  
 