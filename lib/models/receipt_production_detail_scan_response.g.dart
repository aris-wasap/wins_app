// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_production_detail_scan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptProductionDetailScanResponse
    _$ReceiptProductionDetailScanResponseFromJson(Map<String, dynamic> json) {
  return ReceiptProductionDetailScanResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Item.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ReceiptProductionDetailScanResponseToJson(
        ReceiptProductionDetailScanResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };
