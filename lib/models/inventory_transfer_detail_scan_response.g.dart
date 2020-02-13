// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_transfer_detail_scan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryTransferDetailScanResponse
    _$InventoryTransferDetailScanResponseFromJson(Map<String, dynamic> json) {
  return InventoryTransferDetailScanResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Item.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$InventoryTransferDetailScanResponseToJson(
        InventoryTransferDetailScanResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };
