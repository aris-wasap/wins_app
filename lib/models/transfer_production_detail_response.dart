// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);
//     final transferProductionDetailResponse = transferProductionDetailResponseFromJson(jsonString);
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'transfer_production_detail_response.g.dart';

TransferProductionDetailResponse transferProductionDetailResponseFromJson(
    String str) {
  final jsonData = json.decode(str);
  return TransferProductionDetailResponse.fromJson(jsonData);
}

@JsonSerializable()
class TransferProductionDetailResponse {
  @JsonKey(name: 'Error')
  bool error;

  @JsonKey(name: 'ErrorMessage')
  String errorMessage;

  @JsonKey(name: 'Data')
  Data data;

  TransferProductionDetailResponse({
    this.error,
    this.errorMessage,
    this.data,
  });

  factory TransferProductionDetailResponse.fromJson(Map<String, dynamic> json) {
    return _$TransferProductionDetailResponseFromJson(json);
  }

  Map<String, dynamic> toJson() =>
      _$TransferProductionDetailResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'WoId')
  int woId;

  @JsonKey(name: 'WoNo')
  String woNo;

  @JsonKey(name: 'WoDate')
  DateTime woDate;

  @JsonKey(name: 'ProductCode')
  String productCode;

  @JsonKey(name: 'ProductName')
  String productName;

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'TransNo')
  String transNo;

  @JsonKey(name: 'TransDate')
  DateTime transDate;

  @JsonKey(name: 'FromWhsCode')
  String fromWhsCode;

  @JsonKey(name: 'FromWhsName')
  String fromWhsName;

  @JsonKey(name: 'FromAbsEntry')
  int fromAbsEntry;

  @JsonKey(name: 'FromBinCode')
  String fromBinCode;

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

  @JsonKey(name: 'SapTransferProductionId')
  int sapTransferProductionId;

  @JsonKey(name: 'SapTransferProductionNo')
  String sapTransferProductionNo;

  @JsonKey(name: 'Items')
  List<Item> items;

  Data({
    this.woId: 0,
    this.woNo,
    this.woDate,
    this.productCode,
    this.productName,
    this.id: 0,
    this.transNo,
    this.transDate,
    this.fromWhsCode,
    this.fromWhsName,
    this.fromAbsEntry,
    this.fromBinCode,
    this.toWhsCode,
    this.toWhsName,
    this.toAbsEntry,
    this.toBinCode,
    this.totalQty,
    this.sapTransferProductionId: 0,
    this.sapTransferProductionNo,
    this.items,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Item {
  @JsonKey(name: 'WoId')
  int woId;

  @JsonKey(name: 'WoLineNo')
  int woLineNo;

  @JsonKey(name: 'WoVisOrder')
  int woVisOrder;

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'DetId')
  int detId;

  @JsonKey(name: 'LineNo')
  int lineNo;

  @JsonKey(name: 'VisLineNo')
  int visLineNo;

  @JsonKey(name: 'ItemCode')
  String itemCode;

  @JsonKey(name: 'ItemName')
  String itemName;

  @JsonKey(name: 'PlannedQty')
  double plannedQty;

  @JsonKey(name: 'AvailableQty')
  double availableQty;

  @JsonKey(name: 'Qty')
  double qty;

  @JsonKey(name: 'OpenQty')
  double openQty;

  @JsonKey(name: 'IssueQty')
  double issueQty;

  @JsonKey(name: 'Uom')
  String uom;

  @JsonKey(name: 'FromWhsCode')
  String fromWhsCode;

  @JsonKey(name: 'FromWhsName')
  String fromWhsName;

  @JsonKey(name: 'FromAbsEntry')
  int fromAbsEntry;

  @JsonKey(name: 'FromBinCode')
  String fromBinCode;

  @JsonKey(name: 'ToWhsCode')
  String toWhsCode;

  @JsonKey(name: 'ToWhsName')
  String toWhsName;

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

  @JsonKey(name: 'Type')
  String type;

  @JsonKey(name: 'Group')
  String group;

  @JsonKey(name: 'Machine')
  String machine;

  @JsonKey(name: 'Shift')
  String shift;
  

  Item({
    this.woId: 0,
    this.woLineNo: 0,
    this.woVisOrder: 0,
    this.id: 0,
    this.detId: 0,
    this.lineNo: 0,
    this.visLineNo: 0,
    this.itemCode,
    this.itemName,
    this.availableQty,
    this.qty: 0,
    this.openQty: 0,
    this.issueQty: 0,
    this.uom,
    this.fromWhsCode,
    this.fromWhsName,
    this.fromAbsEntry,
    this.fromBinCode,
    this.toWhsCode,
    this.toWhsName,
    this.toAbsEntry,
    this.toBinCode,
    this.batchNo,
    this.width,
    this.length,
    this.length2,
    this.weight,
    this.micron,
    this.expirationDate,
    this.manufacturingDate,
    this.itemType,
    this.type,
    this.group,
    this.machine,
    this.shift,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
