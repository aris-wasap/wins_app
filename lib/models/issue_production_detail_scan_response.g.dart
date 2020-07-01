// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_production_detail_scan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssueProductionDetailScanResponse _$IssueProductionDetailScanResponseFromJson(
    Map<String, dynamic> json) {
  return IssueProductionDetailScanResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Item.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$IssueProductionDetailScanResponseToJson(
        IssueProductionDetailScanResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };
