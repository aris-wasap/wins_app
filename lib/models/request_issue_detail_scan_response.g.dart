// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_issue_detail_scan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestIssueDetailScanResponse _$RequestIssueDetailScanResponseFromJson(
    Map<String, dynamic> json) {
  return RequestIssueDetailScanResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Item.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RequestIssueDetailScanResponseToJson(
        RequestIssueDetailScanResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };
