// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final transferReleaseDetailScanResponse = transferReleaseDetailScanResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:ncf_app/models/transfer_release_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'transfer_release_detail_scan_response.g.dart';

TransferReleaseDetailScanResponse transferReleaseDetailScanResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return TransferReleaseDetailScanResponse.fromJson(jsonData);
}

@JsonSerializable()
class TransferReleaseDetailScanResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Item data;  

  TransferReleaseDetailScanResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory TransferReleaseDetailScanResponse.fromJson(Map<String, dynamic> json) {
    return _$TransferReleaseDetailScanResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TransferReleaseDetailScanResponseToJson(this);
}
  
 