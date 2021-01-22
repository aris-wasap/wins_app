// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cfl_transfer_request_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CflTransferRequestResponse _$CflTransferRequestResponseFromJson(
    Map<String, dynamic> json) {
  return CflTransferRequestResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: (json['Data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CflTransferRequestResponseToJson(
        CflTransferRequestResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    id: json['Id'] as int,
    transNo: json['TransNo'] as String,
    transDate: json['TransDate'] == null
        ? null
        : DateTime.parse(json['TransDate'] as String),
    status: json['Status'] as String,
    customerCode: json['CustomerCode'] as String,
    customerName: json['CustomerName'] as String,
    seriesName: json['SeriesName'] as String,
    fromWhsCode: json['FromWhsCode'] as String,
    fromWhsName: json['FromWhsName'] as String,
    toWhsCode: json['ToWhsCode'] as String,
    toWhsName: json['ToWhsName'] as String,
    fromBranchId: json['FromBranchId'] as int,
    fromBranchName: json['FromBranchName'] as String,
    toBranchId: json['ToBranchId'] as int,
    toBranchName: json['ToBranchName'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'Id': instance.id,
      'TransNo': instance.transNo,
      'TransDate': instance.transDate?.toIso8601String(),
      'Status': instance.status,
      'CustomerCode': instance.customerCode,
      'CustomerName': instance.customerName,
      'SeriesName': instance.seriesName,
      'FromWhsCode': instance.fromWhsCode,
      'FromWhsName': instance.fromWhsName,
      'ToWhsCode': instance.toWhsCode,
      'ToWhsName': instance.toWhsName,
      'FromBranchId': instance.fromBranchId,
      'FromBranchName': instance.fromBranchName,
      'ToBranchId': instance.toBranchId,
      'ToBranchName': instance.toBranchName,
    };
