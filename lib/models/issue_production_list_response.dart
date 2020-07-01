// To parse this JSON data, do
//
//     final issueProductionListResponse = issueProductionListResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'issue_production_list_response.g.dart';

IssueProductionListResponse issueProductionListResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return IssueProductionListResponse.fromJson(jsonData);
}

@JsonSerializable()
class IssueProductionListResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  IssueProductionListResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory IssueProductionListResponse.fromJson(Map<String, dynamic> json) {
    return _$IssueProductionListResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$IssueProductionListResponseToJson(this);
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
  
  @JsonKey(name: 'CreatedUser')
  String createdUser;

  @JsonKey(name: 'SeriesName')
  String seriesName;
 

  Data({
    this.id,
    this.userId,
    this.transNo,
    this.transDate,
    this.status, 
    this.createdUser, 
    this.seriesName
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
