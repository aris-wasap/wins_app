// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_release_detail_scan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferReleaseDetailScanResponse _$TransferReleaseDetailScanResponseFromJson(
    Map<String, dynamic> json) {
  return TransferReleaseDetailScanResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Item.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TransferReleaseDetailScanResponseToJson(
        TransferReleaseDetailScanResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };
