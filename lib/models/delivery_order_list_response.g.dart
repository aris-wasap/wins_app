// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_order_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryOrderListResponse _$DeliveryOrderListResponseFromJson(
    Map<String, dynamic> json) {
  return DeliveryOrderListResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: (json['Data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DeliveryOrderListResponseToJson(
        DeliveryOrderListResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    id: json['Id'] as int,
    userId: json['UserId'] as int,
    sapDeliveryNo: json['SapDeliveryNo'] as String,
    soNo: json['SoNo'] as String,
    transNo: json['TransNo'] as String,
    seriesName: json['SeriesName'] as String,
    transDate: json['TransDate'] == null
        ? null
        : DateTime.parse(json['TransDate'] as String),
    customerCode: json['CustomerCode'] as String,
    customerName: json['CustomerName'] as String,
    status: json['Status'] as String,
    createdUser: json['CreatedUser'] as String,
    branchId: json['BranchId'] as int,
    branchName: json['BranchName'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'Id': instance.id,
      'UserId': instance.userId,
      'SapDeliveryNo': instance.sapDeliveryNo,
      'SoNo': instance.soNo,
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
