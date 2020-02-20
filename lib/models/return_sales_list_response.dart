// To parse this JSON data, do
//
//     final returnSalesListResponse = returnSalesListResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'return_sales_list_response.g.dart';

ReturnSalesListResponse returnSalesListResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return ReturnSalesListResponse.fromJson(jsonData);
}

@JsonSerializable()
class ReturnSalesListResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  ReturnSalesListResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory ReturnSalesListResponse.fromJson(Map<String, dynamic> json) {
    return _$ReturnSalesListResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReturnSalesListResponseToJson(this);
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
    this.transDate,
    this.customerCode,
    this.customerName, 
    this.status, 
    this.createdUser, 
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
