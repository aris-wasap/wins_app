// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods_issue_detail_scan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodsIssueDetailScanResponse _$GoodsIssueDetailScanResponseFromJson(
    Map<String, dynamic> json) {
  return GoodsIssueDetailScanResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Item.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GoodsIssueDetailScanResponseToJson(
        GoodsIssueDetailScanResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };
