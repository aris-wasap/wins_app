// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods_issue_mixing_detail_scan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodsIssueMixingDetailScanResponse _$GoodsIssueMixingDetailScanResponseFromJson(
    Map<String, dynamic> json) {
  return GoodsIssueMixingDetailScanResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Item.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GoodsIssueMixingDetailScanResponseToJson(
        GoodsIssueMixingDetailScanResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };
