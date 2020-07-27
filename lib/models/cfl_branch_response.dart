// To parse this JSON data, do
//
//     final cflBranchResponse = cflBranchResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'cfl_branch_response.g.dart';

CflBranchResponse cflBranchResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return CflBranchResponse.fromJson(jsonData);
}

@JsonSerializable()
class CflBranchResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  CflBranchResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory CflBranchResponse.fromJson(Map<String, dynamic> json) {
    return _$CflBranchResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CflBranchResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'BranchId')
  int branchId;

  @JsonKey(name: 'BranchName')
  String branchName;

  Data({
    this.branchId,
    this.branchName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
