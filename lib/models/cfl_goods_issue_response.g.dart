// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cfl_goods_issue_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CflGoodsIssueResponse _$CflGoodsIssueResponseFromJson(
    Map<String, dynamic> json) {
  return CflGoodsIssueResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: (json['Data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CflGoodsIssueResponseToJson(
        CflGoodsIssueResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    id: json['Id'] as int,
    seriesName: json['SeriesName'] as String,
    branchId: json['BranchId'] as int,
    branchName: json['BranchName'] as String,
    transNo: json['TransNo'] as String,
    docNum: json['DocNum'] as String,
    transDate: json['TransDate'] == null
        ? null
        : DateTime.parse(json['TransDate'] as String),
    status: json['Status'] as String,
  )..refNo = json['RefNo'] as String;
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'Id': instance.id,
      'TransNo': instance.transNo,
      'RefNo': instance.refNo,
      'DocNum': instance.docNum,
      'SeriesName': instance.seriesName,
      'BranchId': instance.branchId,
      'BranchName': instance.branchName,
      'TransDate': instance.transDate?.toIso8601String(),
      'Status': instance.status,
    };
