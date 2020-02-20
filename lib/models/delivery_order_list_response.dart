// To parse this JSON data, do
//
//     final deliveryOrderListResponse = deliveryOrderListResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'delivery_order_list_response.g.dart';

DeliveryOrderListResponse deliveryOrderListResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return DeliveryOrderListResponse.fromJson(jsonData);
}

@JsonSerializable()
class DeliveryOrderListResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  DeliveryOrderListResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory DeliveryOrderListResponse.fromJson(Map<String, dynamic> json) {
    return _$DeliveryOrderListResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DeliveryOrderListResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'UserId')
  int userId;

  @JsonKey(name: 'TransNo')
  String transNo;

  @JsonKey(name: 'SeriesName')
  String seriesName;

  @JsonKey(name: 'TransDate')
  DateTime transDate;

  @JsonKey(name: 'CustomerCode')
  String customerCode;

  @JsonKey(name: 'CustomerName')
  String customerName;

  @JsonKey(name: 'Status')
  String status;
  
  @JsonKey(name: 'CreatedUser')
  String createdUser;
 

  Data({
    this.id,
    this.userId,
    this.transNo,
    this.seriesName,
    this.transDate,
    this.customerCode,
    this.customerName, 
    this.status, 
    this.createdUser, 
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
