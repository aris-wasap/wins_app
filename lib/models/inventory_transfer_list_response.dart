import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'inventory_transfer_list_response.g.dart';

InventoryTransferListResponse inventoryTransferListResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return  InventoryTransferListResponse.fromJson(jsonData);
}

@JsonSerializable()
class InventoryTransferListResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  List<Data> data;

  InventoryTransferListResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory InventoryTransferListResponse.fromJson(Map<String, dynamic> json) {
    return _$InventoryTransferListResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InventoryTransferListResponseToJson(this);
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
    this.transDate,
    this.status,
    this.fromWhsCode,
    this.fromWhsName,
    this.toWhsCode,
    this.toWhsName,
    this.createdUser
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
