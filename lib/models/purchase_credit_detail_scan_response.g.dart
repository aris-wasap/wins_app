// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_credit_detail_scan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchaseCreditDetailScanResponse _$PurchaseCreditDetailScanResponseFromJson(
    Map<String, dynamic> json) {
  return PurchaseCreditDetailScanResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Item.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PurchaseCreditDetailScanResponseToJson(
        PurchaseCreditDetailScanResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };
