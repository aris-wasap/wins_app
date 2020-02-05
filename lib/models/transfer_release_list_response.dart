// To parse this JSON data, do
//
//     final transferReleaseListResponse = transferReleaseListResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'transfer_release_list_response.g.dart';

TransferReleaseListResponse transferReleaseListResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return TransferReleaseListResponse.fromJson(jsonData);
}

@JsonSerializable()
class TransferReleaseListResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  TransferReleaseListResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory TransferReleaseListResponse.fromJson(Map<String, dynamic> json) {
    return _$TransferReleaseListResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TransferReleaseListResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'UserId')
  int userId;

  @JsonKey(name: 'TransNo')
  String transNo;

  @JsonKey(name: 'TransDate')
  DateTime transDate; 

  @JsonKey(name: 'Status')
  String status; 
  
  @JsonKey(name: 'WhsCodeFrom')
  String whsCodeFrom;

  @JsonKey(name: 'WhsNameFrom')
  String whsNameFrom;

  @JsonKey(name: 'WhsCodeTo')
  String whsCodeTo;

  @JsonKey(name: 'WhsNameTo')
  String whsNameTo;
  
  @JsonKey(name: 'CreatedUser')
  String createdUser;
 

  Data({
    this.id,
    this.userId,
    this.transNo,
    this.transDate,
    this.status, 
    this.whsCodeFrom,
    this.whsNameFrom,
    this.whsCodeTo, 
    this.whsNameTo, 
    this.createdUser, 
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
