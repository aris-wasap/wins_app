// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_order_detail_scan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryOrderDetailScanResponse _$DeliveryOrderDetailScanResponseFromJson(
    Map<String, dynamic> json) {
  return DeliveryOrderDetailScanResponse(
    error: json['Error'] as bool,
    errorMessage: json['ErrorMessage'] as String,
    data: json['Data'] == null
        ? null
        : Item.fromJson(json['Data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DeliveryOrderDetailScanResponseToJson(
        DeliveryOrderDetailScanResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'ErrorMessage': instance.errorMessage,
      'Data': instance.data,
    };
