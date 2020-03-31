// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_supplier_detail_scan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptSupplierDetailScanResponse _$ReceiptSupplierDetailScanResponseFromJson(
    Map<String, dynamic> json) {
  return ReceiptSupplierDetailScanResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Item.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ReceiptSupplierDetailScanResponseToJson(
        ReceiptSupplierDetailScanResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };
