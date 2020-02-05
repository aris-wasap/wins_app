// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_order_detail_scan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptOrderDetailScanResponse _$ReceiptOrderDetailScanResponseFromJson(
    Map<String, dynamic> json) {
  return ReceiptOrderDetailScanResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Item.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ReceiptOrderDetailScanResponseToJson(
        ReceiptOrderDetailScanResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };
