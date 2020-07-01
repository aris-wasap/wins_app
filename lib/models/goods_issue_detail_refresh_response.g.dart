// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods_issue_detail_refresh_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodsIssueDetailRefreshResponse _$GoodsIssueDetailRefreshResponseFromJson(
    Map<String, dynamic> json) {
  return GoodsIssueDetailRefreshResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: (json['Data'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GoodsIssueDetailRefreshResponseToJson(
        GoodsIssueDetailRefreshResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };
