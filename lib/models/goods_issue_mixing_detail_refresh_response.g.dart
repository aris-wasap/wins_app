// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods_issue_mixing_detail_refresh_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodsIssueMixingDetailRefreshResponse
    _$GoodsIssueMixingDetailRefreshResponseFromJson(Map<String, dynamic> json) {
  return GoodsIssueMixingDetailRefreshResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: (json['Data'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GoodsIssueMixingDetailRefreshResponseToJson(
        GoodsIssueMixingDetailRefreshResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };
