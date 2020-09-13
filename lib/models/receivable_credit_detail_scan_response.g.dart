// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receivable_credit_detail_scan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceivableCreditDetailScanResponse _$ReceivableCreditDetailScanResponseFromJson(
    Map<String, dynamic> json) {
  return ReceivableCreditDetailScanResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Item.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ReceivableCreditDetailScanResponseToJson(
        ReceivableCreditDetailScanResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };
