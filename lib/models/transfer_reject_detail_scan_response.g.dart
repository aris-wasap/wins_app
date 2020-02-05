// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_reject_detail_scan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferRejectDetailScanResponse _$TransferRejectDetailScanResponseFromJson(
    Map<String, dynamic> json) {
  return TransferRejectDetailScanResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Item.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TransferRejectDetailScanResponseToJson(
        TransferRejectDetailScanResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };
