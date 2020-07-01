// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_returns_detail_scan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchaseReturnsDetailScanResponse _$PurchaseReturnsDetailScanResponseFromJson(
    Map<String, dynamic> json) {
  return PurchaseReturnsDetailScanResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Item.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PurchaseReturnsDetailScanResponseToJson(
        PurchaseReturnsDetailScanResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };
