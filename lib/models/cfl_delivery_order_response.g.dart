// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cfl_delivery_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CflDeliveryOrderResponse _$CflDeliveryOrderResponseFromJson(
    Map<String, dynamic> json) {
  return CflDeliveryOrderResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: (json['Data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CflDeliveryOrderResponseToJson(
        CflDeliveryOrderResponse instance) =>
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
    branchId: json['BranchId'] as int,
    branchName: json['BranchName'] as String,
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
      'BranchId': instance.branchId,
      'BranchName': instance.branchName,
    };
