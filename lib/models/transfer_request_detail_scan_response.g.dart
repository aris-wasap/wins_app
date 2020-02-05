// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_request_detail_scan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferRequestDetailScanResponse _$TransferRequestDetailScanResponseFromJson(
    Map<String, dynamic> json) {
  return TransferRequestDetailScanResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Item.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TransferRequestDetailScanResponseToJson(
        TransferRequestDetailScanResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };
