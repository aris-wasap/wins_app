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

  @JsonKey(name: 'CustomerCode')
  String customerCode;

  @JsonKey(name: 'CustomerName')
  String customerName;
 

  Data({
    this.id,
    this.transNo,
    this.transDate,
    this.customerCode,
    this.customerName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
