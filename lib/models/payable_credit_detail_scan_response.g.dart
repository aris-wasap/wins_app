// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payable_credit_detail_scan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayableCreditDetailScanResponse _$PayableCreditDetailScanResponseFromJson(
    Map<String, dynamic> json) {
  return PayableCreditDetailScanResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Item.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PayableCreditDetailScanResponseToJson(
        PayableCreditDetailScanResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };
