// To parse this JSON data, do
//
//     final transferProductionListResponse = transferProductionListResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'transfer_production_list_response.g.dart';

TransferProductionListResponse transferProductionListResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return TransferProductionListResponse.fromJson(jsonData);
}

@JsonSerializable()
class TransferProductionListResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  TransferProductionListResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory TransferProductionListResponse.fromJson(Map<String, dynamic> json) {
    return _$TransferProductionListResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TransferProductionListResponseToJson(this);
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

  @JsonKey(name: 'WoNo')
  String woNo;

  @JsonKey(name: 'SeriesNameWo')
  String seriesNameWo;

  @JsonKey(name: 'SapTransferProductionNo')
  String sapTransferProductionNo;

  @JsonKey(name: 'TransDate')
  DateTime transDate;

  @JsonKey(name: 'Status')
  String status;

  @JsonKey(name: 'FromWhsCode')
  String fromWhsCode;

  @JsonKey(name: 'FromWhsName')
  String fromWhsName;
 
  @JsonKey(name: 'ToWhsCode')
  String toWhsCode;
 
  @JsonKey(name: 'ToWhsName')
  String toWhsName;
  
  @JsonKey(name: 'CreatedUser')
  String createdUser;
 

  Data({
    this.id,
    this.userId,
    this.transNo,
    this.seriesName,
    this.woNo,
    this.seriesNameWo,
    this.sapTransferProductionNo,
    this.transDate,
    this.status,
    this.fromWhsCode,
    this.fromWhsName,
    this.toWhsCode,
    this.toWhsName,
    this.createdUser, 
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
