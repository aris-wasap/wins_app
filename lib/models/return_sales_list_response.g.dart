// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_sales_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReturnSalesListResponse _$ReturnSalesListResponseFromJson(
    Map<String, dynamic> json) {
  return ReturnSalesListResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: (json['Data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ReturnSalesListResponseToJson(
        ReturnSalesListResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    id: json['Id'] as int,
    userId: json['UserId'] as int,
    transNo: json['TransNo'] as String,
    transDate: json['TransDate'] == null
        ? null
        : DateTime.parse(json['TransDate'] as String),
    customerCode: json['CustomerCode'] as String,
    customerName: json['CustomerName'] as String,
    status: json['Status'] as String,
    createdUser: json['CreatedUser'] as String,
    branchId: json['BranchId'] as int,
    branchName: json['BranchName'] as String,
  )..seriesName = json['SeriesName'] as String;
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'Id': instance.id,
      'UserId': instance.userId,
      'TransNo': instance.transNo,
      'SeriesName': instance.seriesName,
      'TransDate': instance.transDate?.toIso8601String(),
      'CustomerCode': instance.customerCode,
      'CustomerName': instance.customerName,
      'Status': instance.status,
      'CreatedUser': instance.createdUser,
      'BranchId': instance.branchId,
      'BranchName': instance.branchName,
    };
