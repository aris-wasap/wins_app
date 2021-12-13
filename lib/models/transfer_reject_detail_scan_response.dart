// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final transferRejectDetailScanResponse = transferRejectDetailScanResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:wins_app/models/transfer_reject_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'transfer_reject_detail_scan_response.g.dart';

TransferRejectDetailScanResponse transferRejectDetailScanResponseFromJson(
    String str) {
  final jsonData = json.decode(str);
  return TransferRejectDetailScanResponse.fromJson(jsonData);
}

@JsonSerializable()
class TransferRejectDetailScanResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Item data;

  TransferRejectDetailScanResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory TransferRejectDetailScanResponse.fromJson(Map<String, dynamic> json) {
    return _$TransferRejectDetailScanResponseFromJson(json);
  }

  Map<String, dynamic> toJson() =>
      _$TransferRejectDetailScanResponseToJson(this);
}
