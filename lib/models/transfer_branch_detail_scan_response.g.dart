// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_branch_detail_scan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferBranchDetailScanResponse _$TransferBranchDetailScanResponseFromJson(
    Map<String, dynamic> json) {
  return TransferBranchDetailScanResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Item.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TransferBranchDetailScanResponseToJson(
        TransferBranchDetailScanResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };
