// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final inventoryTransferDetailResponse = inventoryTransferDetailResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'inventory_transfer_detail_response.g.dart';

InventoryTransferDetailResponse inventoryTransferDetailResponseFromJson(
    String str) {
  final jsonData = json.decode(str);
  return InventoryTransferDetailResponse.fromJson(jsonData);
}

@JsonSerializable()
class InventoryTransferDetailResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Data data;

  InventoryTransferDetailResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory InventoryTransferDetailResponse.fromJson(Map<String, dynamic> json) {
    return _$InventoryTransferDetailResponseFromJson(json);
  }

  Map<String, dynamic> toJson() =>
      _$InventoryTransferDetailResponseToJson(this);
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

  @JsonKey(name: 'RequestId')
  int requestId;

  @JsonKey(name: 'RequestNo')
  String requestNo;

  @JsonKey(name: 'SeriesNameReq')
  String seriesNameReq;

  @JsonKey(name: 'TransDate')
  DateTime transDate;

  @JsonKey(name: 'FromBranchId')
  int fromBranchId;

  @JsonKey(name: 'FromBranchName')
  String fromBranchName;

  @JsonKey(name: 'FromWhsCode')
  String fromWhsCode;

  @JsonKey(name: 'FromWhsName')
  String fromWhsName;

  @JsonKey(name: 'FromAbsEntry')
  int fromAbsEntry;

  @JsonKey(name: 'FromBinCode')
  String fromBinCode;

  @JsonKey(name: 'ToBranchId')
  int toBranchId;

  @JsonKey(name: 'ToBranchName')
  String toBranchName;

  @JsonKey(name: 'ToWhsCode')
  String toWhsCode;

  @JsonKey(name: 'ToWhsName')
  String toWhsName;

  @JsonKey(name: 'ToAbsEntry')
  int toAbsEntry;

  @JsonKey(name: 'ToBinCode')
  String toBinCode;

  @JsonKey(name: 'TotalQty')
  double totalQty;

  @JsonKey(name: 'SapInventoryTransferId')
  int sapInventoryTransferId;

  @JsonKey(name: 'SapInventoryTransferNo')
  String sapInventoryTransferNo;

  @JsonKey(name: 'CreatedUser')
  int createdUser;

  @JsonKey(name: 'Status')
  String status;

  @JsonKey(name: 'Comments')
  String comments;

  @JsonKey(name: 'Items')
  List<Item> items;

  Data({
    this.id: 0,
    this.userId,
    this.transNo,
    this.seriesName,
    this.requestId,
    this.requestNo,
    this.seriesNameReq,
    this.transDate,
    this.fromBranchId,
    this.fromBranchName,
    this.fromWhsCode,
    this.fromWhsName,
    this.fromAbsEntry,
    this.fromBinCode,
    this.toBranchId,
    this.toBranchName,
    this.toWhsCode,
    this.toWhsName,
    this.toAbsEntry,
    this.toBinCode,
    this.totalQty,
    this.sapInventoryTransferId: 0,
    this.sapInventoryTransferNo,
    this.createdUser,
    this.status,
    this.items,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Item {

   @JsonKey(name: 'RequestId')
  int requestId;

  @JsonKey(name: 'RequestLineNo')
  int requestLineNo;

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'LineNo')
  int lineNo;

  @JsonKey(name: 'VisLineNo')
  int visLineNo;

  @JsonKey(name: 'ItemCode')
  String itemCode;

  @JsonKey(name: 'ItemName')
  String itemName;

  @JsonKey(name: 'AvailableQty')
  double availableQty;

  @JsonKey(name: 'Qty')
  double qty;

  @JsonKey(name: 'Uom')
  String uom;

  @JsonKey(name: 'FromWhsCode')
  String fromWhsCode;

  @JsonKey(name: 'FromAbsEntry')
  int fromAbsEntry;

  @JsonKey(name: 'FromBinCode')
  String fromBinCode;

  @JsonKey(name: 'ToWhsCode')
  String toWhsCode;

  @JsonKey(name: 'ToAbsEntry')
  int toAbsEntry;

  @JsonKey(name: 'ToBinCode')
  String toBinCode;

  @JsonKey(name: 'BatchNo')
  String batchNo;

  @JsonKey(name: 'Length')
  double length;

   @JsonKey(name: 'Length2')
  double length2;

  @JsonKey(name: 'Width')
  double width;

  @JsonKey(name: 'Weight')
  double weight;

  @JsonKey(name: 'Micron')
  double micron;

  @JsonKey(name: 'ManufacturingDate')
  DateTime manufacturingDate;

  @JsonKey(name: 'ExpirationDate')
  DateTime expirationDate;

  @JsonKey(name: 'ItemType')
  String itemType;

  @JsonKey(name: 'IsAsset')
  String isAsset;

  @JsonKey(name: 'IsBatch')
  String isBatch;

  Item({
    this.id: 0,
    this.lineNo: 0,
    this.visLineNo: 0,
    this.itemCode,
    this.itemName,
    this.availableQty,
    this.qty: 0,
    this.uom,
    this.toWhsCode,
    this.toAbsEntry,
    this.toBinCode,
    this.batchNo,
    this.length,
    this.length2,
    this.width,
    this.weight,
    this.micron,
    this.manufacturingDate,
    this.expirationDate,
    this.itemType,
    this.isAsset,
    this.isBatch,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
