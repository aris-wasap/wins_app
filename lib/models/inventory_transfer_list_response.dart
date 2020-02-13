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
    this.transNo,
    this.transDate,
    this.status,
    this.whsCodeFrom,
    this.whsNameFrom,
    this.whsCodeTo,
    this.whsNameTo,
    this.createdUser
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
