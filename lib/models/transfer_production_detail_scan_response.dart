// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final transferProductionDetailScanResponse = transferProductionDetailScanResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:ncf_app/models/transfer_production_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'transfer_production_detail_scan_response.g.dart';

TransferProductionDetailScanResponse transferProductionDetailScanResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return TransferProductionDetailScanResponse.fromJson(jsonData);
}

@JsonSerializable()
class TransferProductionDetailScanResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Item data;  

  TransferProductionDetailScanResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory TransferProductionDetailScanResponse.fromJson(Map<String, dynamic> json) {
    return _$TransferProductionDetailScanResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TransferProductionDetailScanResponseToJson(this);
}
  
 