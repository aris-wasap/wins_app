// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods_receipt_detail_scan_batch_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodsReceiptDetailScanBatchResponse
    _$GoodsReceiptDetailScanBatchResponseFromJson(Map<String, dynamic> json) {
  return GoodsReceiptDetailScanBatchResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    dataBatch: json['Data'] == null
        ? null
        : ItemBatch.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GoodsReceiptDetailScanBatchResponseToJson(
        GoodsReceiptDetailScanBatchResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.dataBatch,
    };
