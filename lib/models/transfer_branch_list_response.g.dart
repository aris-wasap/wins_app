// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_branch_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferBranchListResponse _$TransferBranchListResponseFromJson(
    Map<String, dynamic> json) {
  return TransferBranchListResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: (json['Data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TransferBranchListResponseToJson(
        TransferBranchListResponse instance) =>
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
    branchId: json['BranchId'] as int,
    branchName: json['BranchName'] as String,
    toBranchId: json['ToBranchId'] as int,
    toBranchName: json['ToBranchName'] as String,
  )..sapTransferBranchNo = json['SapTransferBranchNo'] as String;
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'Id': instance.id,
      'UserId': instance.userId,
      'SapTransferBranchNo': instance.sapTransferBranchNo,
      'SeriesName': instance.seriesName,
      'TransNo': instance.transNo,
      'TransDate': instance.transDate?.toIso8601String(),
      'Status': instance.status,
      'CreatedUser': instance.createdUser,
      'BranchId': instance.branchId,
      'BranchName': instance.branchName,
      'ToBranchId': instance.toBranchId,
      'ToBranchName': instance.toBranchName,
    };
