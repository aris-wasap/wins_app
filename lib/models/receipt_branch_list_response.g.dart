// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_branch_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptBranchListResponse _$ReceiptBranchListResponseFromJson(
    Map<String, dynamic> json) {
  return ReceiptBranchListResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: (json['Data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ReceiptBranchListResponseToJson(
        ReceiptBranchListResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    id: json['Id'] as int,
    seriesName: json['SeriesName'] as String,
    userId: json['UserId'] as int,
    transNo: json['TransNo'] as String,
    transDate: json['TransDate'] == null
        ? null
        : DateTime.parse(json['TransDate'] as String),
    status: json['Status'] as String,
    createdUser: json['CreatedUser'] as String,
    issueNo: json['IssueNo'] as String,
    seriesNameIssue: json['SeriesNameIssue'] as String,
    branchId: json['BranchId'] as int,
    branchName: json['BranchName'] as String,
    fromBranchId: json['FromBranchId'] as int,
    fromBranchName: json['FromBranchName'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'Id': instance.id,
      'UserId': instance.userId,
      'SeriesName': instance.seriesName,
      'TransNo': instance.transNo,
      'TransDate': instance.transDate?.toIso8601String(),
      'Status': instance.status,
      'CreatedUser': instance.createdUser,
      'IssueNo': instance.issueNo,
      'BranchId': instance.branchId,
      'BranchName': instance.branchName,
      'FromBranchId': instance.fromBranchId,
      'FromBranchName': instance.fromBranchName,
      'SeriesNameIssue': instance.seriesNameIssue,
    };
