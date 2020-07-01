// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods_receipt_detail_scan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodsReceiptDetailScanResponse _$GoodsReceiptDetailScanResponseFromJson(
    Map<String, dynamic> json) {
  return GoodsReceiptDetailScanResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Item.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GoodsReceiptDetailScanResponseToJson(
        GoodsReceiptDetailScanResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };
