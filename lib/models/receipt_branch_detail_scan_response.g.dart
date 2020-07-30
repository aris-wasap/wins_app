// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_branch_detail_scan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptBranchDetailScanResponse _$ReceiptBranchDetailScanResponseFromJson(
    Map<String, dynamic> json) {
  return ReceiptBranchDetailScanResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Item.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ReceiptBranchDetailScanResponseToJson(
        ReceiptBranchDetailScanResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };
