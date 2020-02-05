// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_production_detail_scan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferProductionDetailScanResponse
    _$TransferProductionDetailScanResponseFromJson(Map<String, dynamic> json) {
  return TransferProductionDetailScanResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Item.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TransferProductionDetailScanResponseToJson(
        TransferProductionDetailScanResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };
