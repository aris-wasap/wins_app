// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cfl_production_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CflProductionOrderResponse _$CflProductionOrderResponseFromJson(
    Map<String, dynamic> json) {
  return CflProductionOrderResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: (json['Data'] as List)
        ?.map(
            (e) => e == null ? null : Data.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CflProductionOrderResponseToJson(
        CflProductionOrderResponse instance) =>
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
    productCode: json['ProductCode'] as String,
    productName: json['ProductName'] as String,
    whsCode: json['WhsCode'] as String,
    whsName: json['WhsName'] as String,
    status: json['Status'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'Id': instance.id,
      'TransNo': instance.transNo,
      'TransDate': instance.transDate?.toIso8601String(),
      'ProductCode': instance.productCode,
      'ProductName': instance.productName,
      'WhsCode': instance.whsCode,
      'WhsName': instance.whsName,
      'Status': instance.status,
    };
