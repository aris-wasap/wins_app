// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_issue_detail_scan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptIssueDetailScanResponse _$ReceiptIssueDetailScanResponseFromJson(
    Map<String, dynamic> json) {
  return ReceiptIssueDetailScanResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Item.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ReceiptIssueDetailScanResponseToJson(
        ReceiptIssueDetailScanResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };
