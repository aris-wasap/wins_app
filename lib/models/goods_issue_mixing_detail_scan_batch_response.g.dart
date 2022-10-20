// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods_issue_mixing_detail_scan_batch_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodsIssueMixingDetailScanBatchResponse
    _$GoodsIssueMixingDetailScanBatchResponseFromJson(
        Map<String, dynamic> json) {
  return GoodsIssueMixingDetailScanBatchResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    dataBatch: json['Data'] == null
        ? null
        : ItemBatch.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GoodsIssueMixingDetailScanBatchResponseToJson(
        GoodsIssueMixingDetailScanBatchResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.dataBatch,
    };
