// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final deliveryOrderDetailScanResponse = deliveryOrderDetailScanResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:wins_app/models/delivery_order_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'delivery_order_detail_scan_response.g.dart';

DeliveryOrderDetailScanResponse deliveryOrderDetailScanResponseFromJson(
    String str) {
  final jsonData = json.decode(str);
  return DeliveryOrderDetailScanResponse.fromJson(jsonData);
}

@JsonSerializable()
class DeliveryOrderDetailScanResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Item data;

  DeliveryOrderDetailScanResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory DeliveryOrderDetailScanResponse.fromJson(Map<String, dynamic> json) {
    return _$DeliveryOrderDetailScanResponseFromJson(json);
  }

  Map<String, dynamic> toJson() =>
      _$DeliveryOrderDetailScanResponseToJson(this);
}
