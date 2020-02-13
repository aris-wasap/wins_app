// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final inventoryTransferDetailScanResponse = inventoryTransferDetailScanResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:ncf_app/models/inventory_transfer_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'inventory_transfer_detail_scan_response.g.dart';

InventoryTransferDetailScanResponse inventoryTransferDetailScanResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return InventoryTransferDetailScanResponse.fromJson(jsonData);
}

@JsonSerializable()
class InventoryTransferDetailScanResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Item data;  

  InventoryTransferDetailScanResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory InventoryTransferDetailScanResponse.fromJson(Map<String, dynamic> json) {
    return _$InventoryTransferDetailScanResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InventoryTransferDetailScanResponseToJson(this);
}
  
 