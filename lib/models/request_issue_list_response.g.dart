// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_issue_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestIssueListResponse _$RequestIssueListResponseFromJson(
    Map<String, dynamic> json) {
  return RequestIssueListResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: (json['Data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RequestIssueListResponseToJson(
        RequestIssueListResponse instance) =>
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
    requestNo: json['RequestNo'] as String,
    sapRequestIssueNo: json['SapRequestIssueNo'] as String,
    transNo: json['TransNo'] as String,
    transDate: json['TransDate'] == null
        ? null
        : DateTime.parse(json['TransDate'] as String),
    status: json['Status'] as String,
    createdUser: json['CreatedUser'] as String,
    branchId: json['BranchId'] as int,
    branchName: json['BranchName'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'Id': instance.id,
      'UserId': instance.userId,
      'RequestNo': instance.requestNo,
      'SapRequestIssueNo': instance.sapRequestIssueNo,
      'SeriesName': instance.seriesName,
      'TransNo': instance.transNo,
      'TransDate': instance.transDate?.toIso8601String(),
      'Status': instance.status,
      'CreatedUser': instance.createdUser,
      'BranchId': instance.branchId,
      'BranchName': instance.branchName,
    };
